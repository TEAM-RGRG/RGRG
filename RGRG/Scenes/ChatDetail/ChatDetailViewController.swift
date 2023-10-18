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
    let sendMessageButton = CustomButton(frame: .zero)
    let textField = CustomTextField(frame: .zero)

    let model = [0, 1, 2, 3, 4, 5, 6, 7, 8]

    deinit {
        print("### ChatDetailViewController deinitialized")
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
        confirmMessageButton()
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
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
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

// MARK: - TextField

extension ChatDetailViewController {
    func confirmTextField() {
        view.addSubview(textField)
        textField.settingCornerRadius(radius: 10)
        textField.settingBorder(borderWidth: 1, borderColor: .black)
        textField.settingPlaceholder(description: "내용을 입력해주세요")
        textField.settingLeftPadding()

        textField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.leading.equalTo(view).offset(55)
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ChatDetailViewController {
    func confirmMessageButton() {
        view.addSubview(sendMessageButton)
        sendMessageButton.configureButton(image: "paperplane")
        sendMessageButton.layer.cornerRadius = 10
        sendMessageButton.backgroundColor = .systemBlue
        sendMessageButton.tintColor = .white
        sendMessageButton.addTarget(self, action: #selector(tappedSendMessageButton), for: .touchUpInside)

        sendMessageButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.leading.equalTo(textField.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func tappedSendMessageButton(_ sender: UIButton) {
        print("### \(#function)")
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
