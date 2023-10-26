//
//  EditProfileViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import FirebaseAuth
import SnapKit
import UIKit

class EditProfileViewController: UIViewController {
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 165, height: 165)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        return imageView
    }()

    let userNameTitle = CustomLabel()
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요"
        return textField
    }()

    let noticeLabel = CustomLabel()

    let tierTitle = CustomLabel()
    let tierButton = CustomButton()

    let positionTitle = CustomLabel()
    let positionButton = CustomButton()

    let mostChampButton = CustomButton()

    let firstImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()

    let secondImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()

    let thirdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()

    let doneEditButton = CustomButton()

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

    override func viewWillAppear(_ animated: Bool) {
        setImage()
    }
}

extension EditProfileViewController {
    func configureUI() {
        view.backgroundColor = .rgrgColor5

        setupLabels()
        setupTextFields()

        [profileImage, userNameTitle, userNameTextField, noticeLabel].forEach { view.addSubview($0) }

        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(31)
            make.width.height.equalTo(165)
            make.centerX.equalToSuperview()
        }

        userNameTitle.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(35)
        }

        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTitle.snp.bottom).offset(11)
            make.left.right.equalToSuperview().inset(35)
            make.height.equalTo(53)
        }

        noticeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.top.equalTo(userNameTextField.snp.bottom).offset(11)
        }
    }

    func setupLabels() {
        userNameTitle.text = "유저 이름"
        tierTitle.text = "티어"
        positionTitle.text = "포지션"

        [userNameTitle, tierTitle, positionTitle].forEach {
            $0.textColor = UIColor(hex: "#505050")
            $0.font = UIFont(name: "NotoSansKR-Bold", size: 16)
        }

        noticeLabel.text = "닉네임을 입력해주세요!"
        noticeLabel.textColor = UIColor.red
        noticeLabel.font = UIFont(name: "NotoSansKR-Bold", size: 12)
    }

    func setupTextFields() {
        userNameTextField.layer.cornerRadius = 10
        userNameTextField.layer.backgroundColor = UIColor.white.cgColor
    }

    func setNaviGationContorller() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "프로필 수정"
    }
}

extension EditProfileViewController {
    @objc func confirmButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension EditProfileViewController {
    func setImage() {
        StorageManager.shared.getImage("icons", "2") { [weak self] image in
            self?.profileImage.image = image
        }
    }
}

// 페이징 네이션

// 인디케이터 뷰
