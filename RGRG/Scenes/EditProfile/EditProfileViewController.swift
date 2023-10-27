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
        imageView.frame = CGRect(x: 0, y: 0, width: 132, height: 132)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.rgrgColor3.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = .rgrgColor7
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

    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()

    let mostChampButton = CustomButton()

    let firstImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.rgrgColor7.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()

    let secondImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.rgrgColor7.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()

    let thirdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.rgrgColor7.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()

    let mostChampImgStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16.3
        stackView.distribution = .fillEqually
        return stackView

    }()

    let doneEditButton = CustomButton()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension EditProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
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
        setupButtons()
        setShadow()

        [profileImage, userNameTitle, userNameTextField, buttonStackView, tierTitle, positionTitle, mostChampButton, mostChampImgStackView, doneEditButton].forEach { view.addSubview($0) }
        [firstImage, secondImage, thirdImage].forEach { mostChampImgStackView.addArrangedSubview($0) }
        [tierButton, positionButton].forEach { buttonStackView.addArrangedSubview($0) }

        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(132)
        }

        userNameTitle.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(51)
            make.height.equalTo(22)
        }

        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTitle.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(46)
            make.height.equalTo(52)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(70)
            make.left.right.equalToSuperview().inset(46)
            make.height.equalTo(52)
        }

        tierTitle.snp.makeConstraints { make in
            make.bottom.equalTo(tierButton.snp.top).offset(-8)
            make.left.equalTo(userNameTitle)
            make.height.equalTo(22)
        }

        positionTitle.snp.makeConstraints { make in
            make.bottom.equalTo(tierButton.snp.top).offset(-8)
            make.left.equalTo(positionButton).offset(4)
        }

        mostChampButton.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(40)
            make.left.equalTo(tierTitle)
            make.height.equalTo(22)
        }

        mostChampImgStackView.snp.makeConstraints { make in
            make.top.equalTo(mostChampButton.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(46)
            make.height.equalTo(68)
            make.width.equalTo(237)
        }

        doneEditButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().offset(-26)
            make.height.equalTo(60)
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

    func setupButtons() {
        [tierButton, positionButton].forEach {
            $0.layer.borderColor = UIColor.rgrgColor6.cgColor
            $0.layer.borderWidth = 2
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
        }

        doneEditButton.backgroundColor = .rgrgColor4
        doneEditButton.layer.cornerRadius = 10
        doneEditButton.setTitle("수정 완료", for: .normal)

        mostChampButton.backgroundColor = .clear
        mostChampButton.setTitle("선호 챔피언", for: .normal)
        mostChampButton.titleLabel?.font = .myBoldSystemFont(ofSize: 16)
        mostChampButton.setImage(UIImage(named: "polygon"), for: .normal)
        mostChampButton.setTitleColor(UIColor(hex: "#505050"), for: .normal)
    }

    func setShadow() {
        [userNameTextField, tierButton, positionButton].forEach {
            $0.setupShadow(alpha: 0.05, offset: CGSize(width: 2, height: 3), radius: 12, opacity: 1)
        }
        
        doneEditButton.setupShadow(alpha: 0.25, offset: CGSize(width: 0, height: 4), radius: 4, opacity: 1)
    }

    func setNavigationController() {
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
