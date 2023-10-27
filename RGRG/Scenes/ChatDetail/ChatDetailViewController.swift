//
//  ChatDetailViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import FirebaseAuth
import SnapKit
import UIKit

class ChatDetailViewController: UIViewController {
    let vc = ChatSettingViewController()
    let tableView = CustomTableView(frame: .zero, style: .plain)

    let rightBarButtonItem = CustomBarButton()
    let emptyView = UIView(frame: .zero)
    let blankMessage = CustomLabel(frame: .zero)
    let sendMessageIcon = CustomImageView(frame: .zero)
    let textField = CustomTextField(frame: .zero)

    var thread = ""
    var chats: [ChatInfo] = []
    var fetchingMore = false
    var count = 1

    var currentUserEmail = ""

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
        showBlankListMessage()

        FireStoreManager.shared.loadChatting(channelName: "channels", thread: thread, startIndex: count) { [weak self] data in
            guard let self = self else { return }
            self.chats = data

            FireStoreManager.shared.updateChannel(currentMessage: self.chats.last?.content ?? "n/a", thread: thread)

            if chats.isEmpty == true {
                blankMessage.isHidden = false
            } else {
                blankMessage.isHidden = true
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
                if self.chats.isEmpty != true {
                    let endexIndex = IndexPath(row: self.chats.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endexIndex, at: .bottom, animated: true)
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        chats.removeAll()
    }
}

// MARK: - SetUp UI

extension ChatDetailViewController {
    func setupUI() {
        view.backgroundColor = .systemGray5
        confirmTableView()
        makeRightBarButton()
        registerCell()
        confirmTextField()
        confirmEmptyView()
        confirmSendMessageIcon()
    }
}

// MARK: - Making TableView

extension ChatDetailViewController {
    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        tableView.separatorStyle = .none
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

    func showBlankListMessage() {
        view.addSubview(blankMessage)
        blankMessage.text = "쪽지를 보내서 RG 친구를 만들어 보세요!"
        blankMessage.font = .systemFont(ofSize: 14)

        blankMessage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.equalTo(view).offset(416)
            make.leading.equalTo(view).offset(80)
            make.height.equalTo(20)
        }
    }
}

// MARK: - Making RightBarButtonItem

extension ChatDetailViewController {
    func makeRightBarButton() {
        navigationItem.rightBarButtonItem = rightBarButtonItem.makeBarButtonItem(imageName: "gearshape", target: self, action: #selector(tappedSettingButton))
    }

    @objc func tappedSettingButton(_ sender: UIBarButtonItem) {
        vc.sheetPresentationController?.preferredCornerRadius = 20
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        tableView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)

        present(vc, animated: true)
    }
}

extension ChatDetailViewController {}

// MARK: - TextField

extension ChatDetailViewController {
    func confirmTextField() {
        view.addSubview(textField)
        textField.backgroundColor = .white
        textField.settingCornerRadius(radius: 10)
        textField.settingPlaceholder(description: "메세지 보내기")
        textField.settingLeftPadding()

        textField.snp.makeConstraints { make in
            make.trailing.equalTo(view).offset(-48)
            make.leading.equalTo(view).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
            make.top.equalTo(tableView.snp.bottom).offset(8)
        }
    }
}

// MARK: - Sending Message Button

extension ChatDetailViewController {
    func confirmEmptyView() {
        view.addSubview(emptyView)
        emptyView.layer.cornerRadius = 10

        emptyView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.top).offset(1)
            make.bottom.equalTo(textField.snp.bottom).offset(-1)
            make.leading.equalTo(textField.snp.trailing).offset(4)
            make.trailing.equalTo(view).offset(-8)
        }
    }

    func confirmSendMessageIcon() {
        emptyView.addSubview(sendMessageIcon)

        sendMessageIcon.image = UIImage(systemName: "paperplane.fill")
        sendMessageIcon.tintColor = .systemGray2
        sendMessageIcon.contentMode = .scaleAspectFit
//        sendMessageIcon.layer.bounds = .init(x: 0, y: 0, width: 36, height: 36)

        sendMessageIcon.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSendingMessageButton))
        sendMessageIcon.addGestureRecognizer(tapGesture)

        sendMessageIcon.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(emptyView)
        }
    }

    @objc func tappedSendingMessageButton(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 2, animations: {
            self.sendMessageIcon.tintColor = .blue
        }, completion: { _ in
            self.sendMessageIcon.tintColor = .systemGray2
        })

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
            cell.setupUI()
            cell.myChatContent.text = item.content
            cell.myChatTime.text = item.date

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YourFeedCell.identifier, for: indexPath) as? YourFeedCell else { return UITableViewCell() }
            cell.setupUI()
            cell.yourChatContent.text = item.content
            cell.yourChatTime.text = item.date
            return cell
        }
    }
}

// MARK: - TableView Delegate

extension ChatDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
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
