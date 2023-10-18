//
//  ChatDetailViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

class ChatDetailViewController: UIViewController {
    let vc = ChatSettingViewController()
    let tableView = CustomTableView(frame: .zero, style: .plain)
    
    let rightBarButtonItem = CustomBarButton()
    let textField = CustomTextField(frame: .zero)

    let model = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]

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
        registerCell()
        confirmTextField()
    }
}

// MARK: - Making TableView

extension ChatDetailViewController {
    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        tableView.backgroundColor = .systemOrange

        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
        }
    }

    func registerCell() {
        tableView.register(MyFeedCell.self, forCellReuseIdentifier: MyFeedCell.identifier)
        tableView.register(YourFeedCell.self, forCellReuseIdentifier: YourFeedCell.identifier)
    }
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

//MARK: - TextField
extension ChatDetailViewController {
    func confirmTextField() {
        view.addSubview(textField)
        textField.backgroundColor = .systemOrange
        textField.placeholder = "내용을 입력해주세요"
        textField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.leading.equalTo(view).offset(60)
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - TableView DataSource

extension ChatDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = model[indexPath.row]

        if index % 2 == 0 {
            print("### \(index)")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFeedCell.identifier, for: indexPath) as? MyFeedCell else { return UITableViewCell() }
            cell.backgroundColor = .white
            return cell
        } else {
            print("### \(index)::")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YourFeedCell.identifier, for: indexPath) as? YourFeedCell else { return UITableViewCell() }
            cell.backgroundColor = .systemYellow
            return cell
        }
    }
}

// MARK: - TableView Delegate

extension ChatDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
