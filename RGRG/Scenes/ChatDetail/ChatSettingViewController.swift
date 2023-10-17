//
//  ChatSettingViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/17/23.
//

import UIKit
import SwiftUI
import SnapKit

class ChatSettingViewController: UIViewController {
    static let identifier = "ChatSettingViewController"
    
    let tableView = CustomTableView(frame: .zero, style: .insetGrouped)
}

extension ChatSettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }
    }
}

extension ChatSettingViewController {
    func setupUI() {
        confirmTableView()
        registerCell()
    }
    
    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func registerCell() {
        tableView.register(ChatSettingCell.self, forCellReuseIdentifier: ChatSettingCell.identifier)
    }
}

//MARK: - TableView Datasource

extension ChatSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatSettingCell.identifier, for: indexPath) as? ChatSettingCell else { return UITableViewCell() }
        cell.backgroundColor = .systemPink
        return cell
    }
}

//MARK: - TableView Delegate
extension ChatSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}


// MARK: - SwiftUI Preview

@available(iOS 13.0, *)
struct ChatSettingViewControllerRepresentble: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ChatSettingViewControllerRepresentble>) {}

    func makeUIView(context: Context) -> UIView { ChatSettingViewController().view }
}

@available(iOS 13.0, *)
struct ChatSettingVCPreview: PreviewProvider {
    static var previews: some View { ChatSettingViewControllerRepresentble()
    }
}
