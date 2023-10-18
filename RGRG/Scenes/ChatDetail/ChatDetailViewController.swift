//
//  ChatDetailViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import SwiftUI
import UIKit

class ChatDetailViewController: UIViewController {
    let vc = ChatSettingViewController()
    let tableView = CustomTableView(frame: .zero, style: .plain)
    let rightBarButtonItem = CustomBarButton()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ChatDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetUp UI

extension ChatDetailViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        confirmTableView()
        makeRightBarButton()
    }
}

// MARK: - Making TableView

extension ChatDetailViewController {
    func confirmTableView() {
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.backgroundColor = .systemOrange

        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }

    func registerCell() {}
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

// MARK: - TableView DataSource

extension ChatDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - SwiftUI Preview

@available(iOS 13.0, *)
struct ChatDetailViewControllerRepresentble: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ChatDetailViewControllerRepresentble>) {}

    func makeUIView(context: Context) -> UIView { ChatDetailViewController().view }
}

@available(iOS 13.0, *)
struct ChatDetailVCPreview: PreviewProvider {
    static var previews: some View { ChatDetailViewControllerRepresentble()
    }
}
