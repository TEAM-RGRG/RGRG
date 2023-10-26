//
//  ChatDetailViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import FirebaseAuth
import SnapKit
import SwiftUI
import UIKit

class ChatDetailViewController: UIViewController {
    let vc = ChatSettingViewController()
    let tableView = CustomTableView(frame: .zero, style: .plain)

    let rightBarButtonItem = CustomBarButton()
    let sendMessageButton = CustomButton(frame: .zero)
    let textField = CustomTextField(frame: .zero)

    let db = FireStoreManager.db
    var thread = ""
    var chats: [ChatInfo] = [] {
        didSet {
            print("### 지금 현재 :: \(chats)")
        }
    }

    var fetchingMore = false
    var count = 1

    var currentUserEmail = ""
    var currentMessageHandler: ((String) -> Void)?

    deinit {
        print("### ChatDetailViewController deinitialized")
    }
}

extension ChatDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = Auth.auth().currentUser {
            print("### User Info: \(user.email)")
            currentUserEmail = user.email ?? "n/a"
        } else {
            print("### Login : Error")
        }

        FireStoreManager.shared.updateReadChat(thread: thread, currentUser: currentUserEmail)

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        FireStoreManager.shared.loadChatting(channelName: "channels", thread: thread, startIndex: count) { [weak self] data in
            guard let self = self else { return }
            self.chats = data
            self.currentMessageHandler?(chats.last?.content ?? "n/a")

            FireStoreManager.shared.updateChannel(currentMessage: self.chats.last?.content ?? "n/a")
            print("^^^ \(self.chats.last?.content)")

            DispatchQueue.main.async {
                self.tableView.reloadData()
                if self.chats.isEmpty != true {
                    let endexIndex = IndexPath(row: self.chats.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endexIndex, at: .bottom, animated: true)
                }
            }
        }
    }
}

// MARK: - SetUp UI

extension ChatDetailViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        confirmTableView()
        makeRightBarButton()
        registerCell()
        confirmTextField()
        confirmMessageButton()
    }
}

// MARK: - Making TableView

extension ChatDetailViewController {
    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        tableView.backgroundColor = .systemOrange

        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
        }
    }

    func registerCell() {
        tableView.register(MyFeedCell.self, forCellReuseIdentifier: MyFeedCell.identifier)
        tableView.register(YourFeedCell.self, forCellReuseIdentifier: YourFeedCell.identifier)
    }
}

// MARK: - Making RightBarButtonItem

extension ChatDetailViewController {
    func makeRightBarButton() {
        navigationItem.rightBarButtonItem = rightBarButtonItem.makeBarButtonItem(imageName: "gearshape", target: self, action: #selector(tappedSettingButton))
    }

    @objc func tappedSettingButton(_ sender: UIBarButtonItem) {
        present(vc, animated: true)
    }
}

// MARK: - TextField

extension ChatDetailViewController {
    func confirmTextField() {
        view.addSubview(textField)
        textField.settingCornerRadius(radius: 10)
        textField.settingBorder(borderWidth: 1, borderColor: .black)
        textField.settingPlaceholder(description: "내용을 입력해주세요")
        textField.settingLeftPadding()

        textField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.leading.equalTo(view).offset(55)
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: -

extension ChatDetailViewController {
    func confirmMessageButton() {
        view.addSubview(sendMessageButton)
        sendMessageButton.configureButton(image: "paperplane")
        sendMessageButton.layer.cornerRadius = 10
        sendMessageButton.backgroundColor = .systemBlue
        sendMessageButton.tintColor = .white
        sendMessageButton.addTarget(self, action: #selector(tappedSendMessageButton), for: .touchUpInside)

        sendMessageButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.leading.equalTo(textField.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func tappedSendMessageButton(_ sender: UIButton) {
        FireStoreManager.shared.addChat(thread: thread, sender: currentUserEmail, date: FireStoreManager.shared.dateFormatter(value: Date.now), read: false, content: textField.text ?? "n/a") { chat in
            self.chats.append(chat)

            DispatchQueue.main.async {
                self.textField.text = ""
            }
        }
    }
}

// MARK: - TableView DataSource

extension ChatDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = chats[indexPath.row]

        if item.sender == currentUserEmail {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFeedCell.identifier, for: indexPath) as? MyFeedCell else { return UITableViewCell() }
            cell.myChatLabel.text = item.content
            cell.timeLabel.text = item.date
            cell.backgroundColor = .RGRGColor1
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YourFeedCell.identifier, for: indexPath) as? YourFeedCell else { return UITableViewCell() }
            cell.yourChatLabel.text = item.content
            cell.timeLabel.text = item.date
            cell.backgroundColor = .RGRGColor2
            return cell
        }
    }
}

// MARK: - TableView Delegate

extension ChatDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
//                beginBatchFetch()
            }
        }
    }

    func beginBatchFetch() {
        fetchingMore = true
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
        count += 10
        FireStoreManager.shared.loadChatting(channelName: "channels", thread: thread, startIndex: count) { chat in
            self.chats += chat
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                print("&&& \(self.count)")
                self.fetchingMore = false
                self.tableView.reloadData()
            }
        }
    }
}
