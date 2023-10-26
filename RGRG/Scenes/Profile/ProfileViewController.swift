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
        imageView.layer.borderColor = UIColor.rgrgColor3.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imageView.frame.height / 2
        return imageView
    }()

    let userNameLabel = CustomLabel()
    let emailLabel = CustomLabel()

    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
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

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupProfileView()
        setupLabels()
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
        view.backgroundColor = .rgrgColor5

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

        setupShadow()

        labelStackView.addArrangedSubview(userNameLabel)
        labelStackView.addArrangedSubview(emailLabel)
        positionImageOuterView.addSubview(positionImageView)
        tierView.addSubview(tierLabel)

        positionImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(23.33)
        }

        [profileImageView, labelStackView, positionImageOuterView, tierView].forEach { profileView.addSubview($0) }

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
    }

    func setupShadow() {
        profileView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.10)
        profileView.layer.shadowOffset = CGSize(width: 0, height: 1)
        profileView.layer.shadowRadius = 5
        profileView.layer.shadowOpacity = 1
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
        tierLabel.font = UIFont(name: "Roboto", size: 20)
        var tierColor: String
        switch user?.tier {
        case "iron":
            tierColor = "Iron"
        case "bronze":
            tierColor = "Bronze"
        case "silver":
            tierColor = "Silver"
        case "gold":
            tierColor = "Gold"
        case "platinum":
            tierColor = "Platinum"
        case "emerald":
            tierColor = "Emerald"
        case "diamond":
            tierColor = "Diamond"
        case "master":
            tierColor = "Master"
        case "grandMaster":
            tierColor = "GrandMaster"
        default:
            tierColor = "Challenger"
        }

        tierLabel.textColor = UIColor(named: tierColor)
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
}
