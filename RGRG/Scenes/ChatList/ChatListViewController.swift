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
    var channels: [Channel] = []
    var currentUser: User?

    let vc = ChatDetailViewController()

    let tableView = CustomTableView(frame: .zero, style: .plain)
    let blankMessage = CustomLabel(frame: .zero)
    let rightBarButtonItem = CustomBarButton()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ChatListViewController {
    func task(tag: Int) {
        FirebaseUserManager.shared.getUserInfo { [weak self] user in
            guard let self = self else { return }
            currentUser = user

            guard let currentUser = currentUser else { return }

            FireStoreManager.shared.loadChannels(collectionName: "channels", filter: currentUser.uid) { channel, _ in

                self.channels = channel

                if self.channels.isEmpty == true {
                    self.blankMessage.isHidden = false
                } else {
                    self.blankMessage.isHidden = true
                }

                DispatchQueue.main.async {
                    if tag == 1 {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        FireStoreManager.shared.loadWholeChannels()
        FireStoreManager.shared.updateChannelsStatus { value in

            if self.channels.isEmpty == true {
                self.blankMessage.isHidden = false
            } else {
                self.blankMessage.isHidden = true
            }

            switch value {
            case 1:
                self.task(tag: 1)
                print("##### 111 \(value)")

            case 2:
                print("##### 222 \(value)")
                self.task(tag: 2)
                for i in 0 ..< self.channels.count {
                    self.tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .none)
                }
            case 3:
                print("##### 333 \(value)")
                self.channels.removeAll()
                self.task(tag: 1)
                self.tableView.reloadData()

            default:
                break
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "쪽지"
        tabBarController?.navigationItem.rightBarButtonItem?.isHidden = false
        tabBarController?.navigationController?.navigationBar.isHidden = false

        if channels.isEmpty == true {
            blankMessage.isHidden = false
        } else {
            blankMessage.isHidden = true
        }

        task(tag: 1)
    }

    override func viewDidDisappear(_ animated: Bool) {
//        channels.removeAll()
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
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.rgrgColor4]
        tabBarController?.navigationController?.navigationBar.shadowImage = nil
//        makeRightBarButton()
        makeBlankLeftButton()
    }

    func makeRightBarButton() {
        // 액션 만들기 >> 메뉴 만들기 >> UIBarButtonItem 만들기
        let latestSortAction = rightBarButtonItem.makeSingleAction(title: "최신 메시지 순", attributes: .keepsMenuPresented, state: .off) { _ in
            print("### 최신순으로 정렬하기 알파입니다.")
        }

        let bookMarkAction = rightBarButtonItem.makeSingleAction(title: "안 읽은 메시지 순", attributes: .keepsMenuPresented, state: .off) { _ in
            print("### 안 읽은 메시지 순으로 정렬하기 알파입니다.")
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

        // 내가 호스트일 때,
        if currentUser?.uid == item.host {
            cell.setupUI()
            FirebaseUserManager.shared.getUserInfo(searchUser: item.guest) { guest in
                cell.userProfileName.text = guest.userName
                cell.userProfileImage.image = UIImage(named: guest.profilePhoto)
            }
            cell.currentChat.text = item.currentMessage
            cell.userProfileImage.layer.masksToBounds = true

            if item.guestSender == false {
                cell.chatAlert.isHidden = true
            } else {
                cell.chatAlert.isHidden = false
            }

            // 내가 게스트일 때,
        } else {
            cell.setupUI()
            FirebaseUserManager.shared.getUserInfo(searchUser: item.host) { host in
                cell.userProfileName.text = host.userName
                cell.userProfileImage.image = UIImage(named: host.profilePhoto)
            }
            cell.currentChat.text = item.currentMessage
            cell.userProfileImage.layer.masksToBounds = true

            if item.hostSender == false {
                cell.chatAlert.isHidden = true
            } else {
                cell.chatAlert.isHidden = false
            }
        }

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
        vc.channelInfo = item
        vc.currentUserUid = currentUser?.uid ?? "N/A"

        if currentUser?.uid == item.host {
            FirebaseUserManager.shared.getUserInfo(searchUser: item.guest) { guest in
                self.vc.navigationItem.title = guest.userName
            }

        } else {
            FirebaseUserManager.shared.getUserInfo(searchUser: item.host) { host in
                self.vc.navigationItem.title = host.userName
            }
        }

        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
}

// MARK: - Timer

extension ChatListViewController {
    @objc func updateChannelsStatus(_ sender: Timer) {
        tableView.reloadData()
    }
}
