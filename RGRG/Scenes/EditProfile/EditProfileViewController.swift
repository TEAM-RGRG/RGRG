//
//  EditProfileViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

class EditProfileViewController: UIViewController {
    let sampleUserName = "sampleUser"

    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 165, height: 165)
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
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

    func setupUserNameTextField() {
        userNameTextField.text = sampleUserName
    }

    func configureUI() {

        setupLabel()
        setupUserNameTextField()

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
