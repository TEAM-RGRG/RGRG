//
//  ChatListViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

class ChatListViewController: UIViewController {
    let tableView = CustomTableView(frame: .zero)

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
    }

    func confirmTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemOrange
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
}
