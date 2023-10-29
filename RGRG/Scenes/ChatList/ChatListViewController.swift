//
//  ChatListViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import SnapKit
import UIKit

class ChatListViewController: UIViewController {
    let db = FireStoreManager.db
    var channels: [Channel] = []
    var currentUserEmail = ""

    let vc = ChatDetailViewController()

    let tableView = CustomTableView(frame: .zero, style: .plain)
    let blankMessage = CustomLabel(frame: .zero)
    let rightBarButtonItem = CustomBarButton()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ChatListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        if let currentUser = Auth.auth().currentUser {
            currentUserEmail = currentUser.email ?? "n/a"
        } else {
            print("### 유저를 몰라")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "쪽지"
        tabBarController?.navigationItem.rightBarButtonItem?.isHidden = false
        tabBarController?.navigationController?.navigationBar.isHidden = false
        FireStoreManager.shared.loadChannels(collectionName: "channels", writerName: currentUserEmail, filter: currentUserEmail) { channel in
            self.channels = channel

            if self.channels.isEmpty == true {
                self.blankMessage.isHidden = false
            } else {
                self.blankMessage.isHidden = true
            }

            self.channels = self.removeDuplication(in: self.channels)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        channels.removeAll()
    }
}

// MARK: - Setting UI

extension ChatListViewController {
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        confirmNavigation()
        confirmTableView()
        registerCell()
        showBlankListMessage()
    }
}

// MARK: - Confirm TableView

extension ChatListViewController {
    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(hex: "#F4F4F4")
        tableView.separatorStyle = .none

        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }

    func registerCell() {
        tableView.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.identifier)
    }

    func showBlankListMessage() {
        view.addSubview(blankMessage)
        blankMessage.text = "받은 쪽지가 없어요."
        blankMessage.textAlignment = .center
        blankMessage.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        blankMessage.textColor = UIColor(hex: "#767676")

        blankMessage.snp.makeConstraints { make in
            make.top.equalTo(view).offset(406)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
}

// MARK: - Confirm Navigation

extension ChatListViewController {
    func confirmNavigation() {
        tabBarController?.navigationItem.title = "쪽지"
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 24)!]
        tabBarController?.navigationController?.navigationBar.barTintColor = UIColor(hex: "#0C356A")
        tabBarController?.navigationController?.navigationBar.shadowImage = nil
        makeRightBarButton()
        makeBlankLeftButton()
    }

    func makeRightBarButton() {
        // 액션 만들기 >> 메뉴 만들기 >> UIBarButtonItem 만들기
        let latestSortAction = rightBarButtonItem.makeSingleAction(title: "최신 메시지 순", state: .off) { _ in
            FireStoreManager.shared.addChannel(channelTitle: "테스트1", requester: "testuser2@naver.com", writer: self.currentUserEmail, channelID: UUID().uuidString, date: FireStoreManager.shared.dateFormatter(value: Date.now), users: [self.currentUserEmail, "testuser2@naver.com"], requesterProfile: "Ashe", writerProfile: "Teemo") { channel in
                print("### 성공적으로 저장됨.")
                self.channels.append(channel)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("### 최신순으로 정렬하기 알파입니다.")
        }

        let bookMarkAction = rightBarButtonItem.makeSingleAction(title: "안 읽은 메시지 순", state: .off) { _ in

            print("### 즐겨찾기으로 정렬하기 알파입니다.")
        }

        let menu = [latestSortAction, bookMarkAction]

        let uiMenu = rightBarButtonItem.makeUIMenu(title: "채팅방 정렬", opetions: .displayInline, uiActions: menu)

        navigationItem.rightBarButtonItem?.changesSelectionAsPrimaryAction = false

        rightBarButtonItem.image = UIImage(named: "chatpopupIcon")
        rightBarButtonItem.menu = uiMenu
        rightBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        tabBarController?.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func makeBlankLeftButton() {
        tabBarController?.navigationItem.leftBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - UITableViewDataSource

extension ChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier, for: indexPath) as? ChatListCell else { return UITableViewCell() }

        let item = channels[indexPath.row]
        cell.userProfileName.text = item.requester
        cell.currentChat.text = item.currentMessage
        cell.setupUI()
        cell.backgroundColor = .clear

        let background = UIView()
        background.backgroundColor = .clear
        cell.selectedBackgroundView = background

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = channels[indexPath.row]
        vc.thread = item.channelID
        vc.navigationItem.title = item.requester
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
}

// MARK: - Removing Duplication Chatting List

extension ChatListViewController {
    func removeDuplication(in array: [Channel]) -> [Channel] {
        let set = Set(array)
        let duplicationRemovedArray = Array(set)
        return duplicationRemovedArray
    }
}
