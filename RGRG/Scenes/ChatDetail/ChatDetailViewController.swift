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
    let tableView = CustomTableView(frame: .zero, style: .plain)

    let rightBarButtonItem = CustomBarButton()
    let emptyView = UIView(frame: .zero)
    let bottomBaseView = UIView(frame: .zero)
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
        setupUI()
        if let user = Auth.auth().currentUser {
            print("### User Info: \(user.email)")
            currentUserEmail = user.email ?? "n/a"
        } else {
            print("### Login : Error")
        }

        FireStoreManager.shared.updateReadChat(thread: thread, currentUser: currentUserEmail)
    }

    override func viewWillAppear(_ animated: Bool) {
        showBlankListMessage()
        FireStoreManager.shared.loadChatting(channelName: "channels", thread: thread, startIndex: count) { [weak self] data in
            guard let self = self else { return }
            self.chats = data

            FireStoreManager.shared.updateChannel(currentMessage: self.chats.last?.content ?? "", thread: thread)

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
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        navigationController?.navigationBar.shadowImage = nil
        confirmTableView()
        makeRightBarButton()
        registerCell()
        confirmBottomBaseView()
        confirmTextField()
        confirmEmptyView()
        confirmSendMessageIcon()
        makeBackButton()
    }
}

// MARK: - Making TableView

extension ChatDetailViewController {
    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hex: "#F4F4F4")

        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-54)
        }
    }

    func registerCell() {
        tableView.register(MyFeedCell.self, forCellReuseIdentifier: MyFeedCell.identifier)
        tableView.register(YourFeedCell.self, forCellReuseIdentifier: YourFeedCell.identifier)
        tableView.register(ChatAlertCell.self, forCellReuseIdentifier: ChatAlertCell.identifier)
    }

    func showBlankListMessage() {
        view.addSubview(blankMessage)
        blankMessage.text = "쪽지를 보내서 RG 친구를 만들어 보세요!"
        blankMessage.textAlignment = .center
        blankMessage.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        blankMessage.textColor = UIColor(hex: "#767676")

        blankMessage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.equalTo(view).offset(416)
            make.leading.equalTo(view).offset(40)
            make.height.equalTo(20)
        }
    }
}

// MARK: - Making RightBarButtonItem

extension ChatDetailViewController {
    func makeRightBarButton() {
        rightBarButtonItem.image = UIImage(named: "chatGearIcon")
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(tappedSettingButton)
        rightBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func tappedSettingButton(_ sender: UIBarButtonItem) {
        let vc = ChatSettingViewController()
        vc.sheetPresentationController?.preferredCornerRadius = 20
        vc.thread = thread
        present(vc, animated: true)
    }
}

// MARK: - TextField

extension ChatDetailViewController {
    func confirmTextField() {
        bottomBaseView.addSubview(textField)
        textField.backgroundColor = UIColor(hex: "#FFFFFF")
        textField.settingCornerRadius(radius: 10)
        textField.settingPlaceholder(description: "메세지 보내기")
        textField.settingLeftPadding()

        textField.snp.makeConstraints { make in
            make.leading.equalTo(bottomBaseView).offset(11)
            make.top.equalTo(bottomBaseView).offset(8)
            make.width.equalTo(334)
            make.height.equalTo(38)
        }
    }
}

// MARK: - Sending Message Button

extension ChatDetailViewController {
    func confirmBottomBaseView() {
        view.addSubview(bottomBaseView)

        bottomBaseView.backgroundColor = UIColor(hex: "#F1F1F1")

        bottomBaseView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view)
        }
    }

    func confirmEmptyView() {
        bottomBaseView.addSubview(emptyView)
        emptyView.layer.cornerRadius = 10

        emptyView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.top).offset(1)
            make.bottom.equalTo(textField.snp.bottom).offset(-1)
            make.leading.equalTo(textField.snp.trailing).offset(4)
            make.trailing.equalTo(bottomBaseView).offset(-8)
        }
    }

    func confirmSendMessageIcon() {
        emptyView.addSubview(sendMessageIcon)

        sendMessageIcon.image = UIImage(named: "Send_fill")
        sendMessageIcon.tintColor = UIColor(hex: "#ADADAD")
        sendMessageIcon.contentMode = .scaleAspectFit

        sendMessageIcon.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSendingMessageButton))
        sendMessageIcon.addGestureRecognizer(tapGesture)

        sendMessageIcon.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(emptyView)
        }
    }

    @objc func tappedSendingMessageButton(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: sendMessageIcon, duration: 1, animations: {
            self.sendMessageIcon.image = UIImage(named: "ChangeSend_fill")
        })

        FireStoreManager.shared.addChat(thread: thread, sender: currentUserEmail, date: FireStoreManager.shared.dateFormatter(value: Date.now), read: false, content: textField.text ?? "n/a") { chat in
            self.chats.append(chat)

            DispatchQueue.main.async {
                self.textField.text = ""
                self.sendMessageIcon.image = UIImage(named: "Send_fill")
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

        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatAlertCell.identifier, for: indexPath) as? ChatAlertCell else { return UITableViewCell() }
            cell.setupUI()
            cell.backgroundColor = .clear

            return cell

        } else {
            if item.sender == currentUserEmail {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFeedCell.identifier, for: indexPath) as? MyFeedCell else { return UITableViewCell() }

                cell.myChatContent.text = item.content
                cell.myChatTime.text = item.date

                DispatchQueue.main.async {
                    cell.setupUI()
                }
                cell.backgroundColor = .clear
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: YourFeedCell.identifier, for: indexPath) as? YourFeedCell else { return UITableViewCell() }

                cell.yourChatContent.text = item.content
                cell.yourChatTime.text = item.date

                DispatchQueue.main.async {
                    cell.setupUI()
                }

                cell.backgroundColor = .clear
                return cell
            }
        }
    }
}

// MARK: - TableView Delegate

extension ChatDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110
        }

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

extension ChatDetailViewController {
    func makeBackButton() {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(tappedBackButton))
        backBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        navigationItem.leftBarButtonItem = backBarButtonItem
    }

    @objc func tappedBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
