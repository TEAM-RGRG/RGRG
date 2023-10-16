//
//  EditProfileViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

class EditProfileViewController: UIViewController {
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()

    let userNameTextFieldTitle = CustomLabel()
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요"
        return textField
    }()

    let noticeLabel = CustomLabel()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension EditProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setNaviGationContorller()
        configureUI()
    }
}

extension EditProfileViewController {
    func setNaviGationContorller() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "프로필 수정"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(confirmButtonPressed))
    }

    func setupLabel() {
        userNameTextFieldTitle.text = "닉네임"

        noticeLabel.text = "닉네임을 입력해주세요!"
        noticeLabel.setupLabelColor(color: .red)
    }

    func configureUI() {
        setupLabel()

        [profileImage, userNameTextFieldTitle, userNameTextField, noticeLabel].forEach { view.addSubview($0) }

        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(31)
            make.width.height.equalTo(165)
            make.centerX.equalToSuperview()
        }

        userNameTextFieldTitle.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(35)
        }

        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextFieldTitle.snp.bottom).offset(11)
            make.left.right.equalToSuperview().inset(35)
            make.height.equalTo(53)
        }

        noticeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.top.equalTo(userNameTextField.snp.bottom).offset(11)
        }
    }
}

extension EditProfileViewController {
    @objc func confirmButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
