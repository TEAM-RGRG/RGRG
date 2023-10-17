//
//  ChatListViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import SwiftUI
import UIKit

class ChatListViewController: UIViewController {
    let tableView = CustomTableView(frame: .zero, style: .grouped)
    let rightBarButtonItem = CustomBarButton()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ChatListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ChatListViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        makeRightBarButton()
        confirmTableView()
        registerCell()
    }

    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        tableView.backgroundColor = .systemOrange
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
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
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier, for: indexPath) as? ChatListCell else { return UITableViewCell() }

        cell.backgroundColor = .white
        return cell
    }
}

// MARK: - TableView Delegate

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatDetailViewController()
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

// MARK: - SwiftUI Preview

@available(iOS 13.0, *)
struct ChatListViewControllerRepresentble: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ChatListViewControllerRepresentble>) {}

    func makeUIView(context: Context) -> UIView { ChatListViewController().view }
}

@available(iOS 13.0, *)
struct ChatListVCPreview: PreviewProvider {
    static var previews: some View { ChatListViewControllerRepresentble()
    }
}
