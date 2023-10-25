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
    let tableView = CustomTableView(frame: .zero, style: .plain)
    let rightBarButtonItem = CustomBarButton()

    let db = FireStoreManager.db
    var channels: [Channel] = []
    var currentUserEmail = ""

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
            print("### Current ::: \(currentUserEmail)")
        } else {
            print("### 유저를 몰라")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        FireStoreManager.shared.loadChannels(collectionName: "channels", writerName: currentUserEmail, filter: currentUserEmail) { channel in
            self.channels = channel
            self.channels = self.removeDuplication(in: self.channels)

            DispatchQueue.main.async {
                print("### \(self.channels)")
                self.tableView.reloadData()
            }
        }
    }
}

extension ChatListViewController {
    func removeDuplication(in array: [Channel]) -> [Channel] {
        let set = Set(array)
        let duplicationRemovedArray = Array(set)
        return duplicationRemovedArray
    }
}

extension ChatListViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        makeRightBarButton()
        makeBackButton()
        confirmTableView()
        registerCell()
    }

    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        tableView.backgroundColor = .systemOrange

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
}

// MARK: - RightBarButtonItem

extension ChatListViewController {
    func makeRightBarButton() {
        // 액션 만들기 >> 메뉴 만들기 >> UIBarButtonItem 만들기
        let latestSortAction = rightBarButtonItem.makeSingleAction(title: "최신 메시지 순", state: .off) { _ in
            FireStoreManager.shared.addChannel(channelTitle: "테스트1", requester: "testuser1@naver.com", writer: self.currentUserEmail, channelID: UUID().uuidString, date: FireStoreManager.shared.dateFormatter(value: Date.now), users: [self.currentUserEmail, "testuser1@naver.com"]) { channel in
                print("### 성공적으로 저장됨.")
                self.channels.append(channel)
            }
            print("### 최신순으로 정렬하기 알파입니다.")
        }

        let bookMarkAction = rightBarButtonItem.makeSingleAction(title: "즐겨찾기 순", state: .off) { _ in
            print("### 즐겨찾기으로 정렬하기 알파입니다.")
        }

        let menu = [latestSortAction, bookMarkAction]

        let uiMenu = rightBarButtonItem.makeUIMenu(title: "채팅방 정렬", opetions: .displayInline, uiActions: menu)

        navigationItem.rightBarButtonItem?.changesSelectionAsPrimaryAction = false

        tabBarController?.navigationItem.rightBarButtonItem = rightBarButtonItem.makeBarButtonItem(imageName: "ellipsis.circle", menu: uiMenu)
    }
}

// MARK: - TableView Datasource

extension ChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier, for: indexPath) as? ChatListCell else { return UITableViewCell() }
        let item = channels[indexPath.row]
        cell.chatDescriptionLabel.text = item.writer
        if item.requester == currentUserEmail {
            cell.profileNameLabel.text = item.writer
        } else {
            cell.profileNameLabel.text = item.requester
        }

        cell.backgroundColor = .white
        return cell
    }
}

// MARK: - TableView Delegate

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = channels[indexPath.row]
        let vc = ChatDetailViewController()
        vc.thread = item.channelID
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ChatListViewController {
    func makeBackButton() {
        let backButton = CustomBackButton(title: "Back", style: .plain, target: self, action: #selector(tappedBackButton))
        tabBarController?.navigationItem.backBarButtonItem = backButton
    }

    @objc func tappedBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
