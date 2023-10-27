//
//  ProfileViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import FirebaseAuth
import FirebaseCore
import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    var user: User?

    let profileView = UIView()
    let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        imageView.layer.borderColor = UIColor.RGRGColor3?.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.backgroundColor = .rgrgColor7
        return imageView
    }()

    let userNameLabel = CustomLabel()
    let emailLabel = CustomLabel()

    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    let positionImageView = CustomImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))

    let positionImageOuterView: UIView = {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        newView.layer.borderColor = UIColor(hex: "#ADADAD", alpha: 1).cgColor
        newView.backgroundColor = UIColor(hex: "#767676", alpha: 1)
        newView.layer.borderWidth = 1
        newView.layer.cornerRadius = newView.frame.height / 2
        return newView
    }()

    let tierView: UIView = {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 124, height: 35))
        newView.layer.borderColor = UIColor(hex: "#ADADAD", alpha: 1).cgColor
        newView.layer.borderWidth = 1
        newView.layer.cornerRadius = newView.frame.height / 2
        return newView
    }()

    let tierLabel = CustomLabel()

    let myWritingButton = CustomButton()
    let settingButton = CustomButton()

    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = -2
        return stackView
    }()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupProfileView()
        setImageTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        FirebaseUserManager.shared.getUserInfo { user in
            self.user = user
            DispatchQueue.main.async {
                self.setupLabels()
                self.setupImages()
            }
        }
    }
}

extension ProfileViewController {
    func configureUI() {
        view.backgroundColor = .RGRGColor5

        [profileView].forEach { view.addSubview($0) }

        profileView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(204)
        }
    }

    func setupProfileView() {
        profileView.backgroundColor = .white
        profileView.layer.cornerRadius = 10

        profileView.setupShadow(alpha: 0.10, offset: CGSize(width: 0, height: 1), radius: 5, opacity: 1)
        setupButtons()

        [userNameLabel, emailLabel].forEach { labelStackView.addArrangedSubview($0) }
        [myWritingButton, settingButton].forEach { buttonStackView.addArrangedSubview($0) }

        positionImageOuterView.addSubview(positionImageView)
        tierView.addSubview(tierLabel)

        positionImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(23.33)
        }

        [profileImageView, labelStackView, positionImageOuterView, tierView, buttonStackView].forEach { profileView.addSubview($0) }

        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27)
            make.top.equalToSuperview().offset(16)
            make.height.width.equalTo(75)
        }

        tierLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        labelStackView.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.centerY.equalTo(profileImageView)
        }

        positionImageOuterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(profileImageView.snp.bottom).offset(14)
            make.height.width.equalTo(35)
        }

        tierView.snp.makeConstraints { make in
            make.left.equalTo(positionImageOuterView.snp.right).offset(8)
            make.centerY.equalTo(positionImageOuterView)
            make.height.equalTo(35)
            make.width.equalTo(124)
        }

        buttonStackView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }

//    func setupShadow() {
//        profileView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.10)
//        profileView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        profileView.layer.shadowRadius = 5
//        profileView.layer.shadowOpacity = 1
//    }

    func setImageTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toEditProfile))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
}

extension ProfileViewController {
    func setupLabels() {
        userNameLabel.text = user?.userName
        userNameLabel.font = .myBoldSystemFont(ofSize: 20)

        emailLabel.text = user?.email
        emailLabel.font = .mySystemFont(ofSize: 14)
        emailLabel.textColor = UIColor(hex: "#767676")

        tierLabel.text = user?.tier
        tierLabel.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        tierLabel.textColor = UIColor(hex: "#767676")
    }

    func setupImages() {
        StorageManager.shared.getImage("icons", user?.profilePhoto ?? "Default") {
            self.profileImageView.image = $0
            self.profileImageView.contentMode = .scaleAspectFill
        }
        StorageManager.shared.getImage("position_w", user?.position ?? "support") {
            self.positionImageView.image = $0
            self.profileImageView.contentMode = .scaleAspectFit
        }
    }

    func setupButtons() {
        myWritingButton.snp.makeConstraints { $0.height.equalTo(44) }
        settingButton.snp.makeConstraints { $0.height.equalTo(44) }

        var plainConfigure = UIButton.Configuration.plain()
        plainConfigure.imagePadding = 4
        var tintedConfigure = UIButton.Configuration.tinted()
        tintedConfigure.background.strokeColor = .rgrgColor2
        tintedConfigure.background.strokeWidth = 2

        myWritingButton.setImage(UIImage(named: "widget"), for: .normal)
        myWritingButton.setTitle("내가 쓴 글", for: .normal)
        myWritingButton.addTarget(self, action: #selector(myWritingButtonPressed), for: .touchUpInside)
        settingButton.setImage(UIImage(named: "gear"), for: .normal)
        settingButton.setTitle("환경 설정", for: .normal)
        settingButton.addTarget(self, action: #selector(settingButtonPressed), for: .touchUpInside)

        myWritingButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner)
        settingButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner)

        [myWritingButton, settingButton].forEach {
            $0.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
            $0.setTitleColor(UIColor(hex: "505050", alpha: 1), for: .normal)

            $0.layer.borderColor = UIColor.rgrgColor5.cgColor
            $0.layer.borderWidth = 2
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10

            $0.configuration = plainConfigure
        }
    }
}

extension ProfileViewController {
    @objc func myWritingButtonPressed() {
        // 추가 구현기능
        print("추가 구현 예정")
    }

    @objc func settingButtonPressed() {
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }

    @objc func toEditProfile() {
        let editProfileVC = EditProfileViewController()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
}
