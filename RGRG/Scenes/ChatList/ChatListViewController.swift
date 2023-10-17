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
    let tableView = CustomTableView(frame: .zero, style: .insetGrouped)

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
        print("### \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

//MARK: - SwiftUI Preview

 @available(iOS 13.0, *)
 struct ChatListViewControllerRepresentble: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ChatListViewControllerRepresentble>) {
    }

    func makeUIView(context: Context) -> UIView { ChatListViewController().view }
 }

 @available(iOS 13.0, *)
 struct ChatListVCPreview: PreviewProvider {
    static var previews: some View { ChatListViewControllerRepresentble()
    }
 }
