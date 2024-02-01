//
//  ProfileVC.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import FirebaseAuth
import FirebaseCore
import SnapKit
import UIKit

#warning("UI 코드 중복 제거 및 공용 컴포넌트 사용할 것")
class ProfileVC: UIViewController, SendUpdatedUserDelegate {
    func sendUpdatedUser(user: UserInfo) {
        profileImageView.image = UIImage(named: user.profilePhoto)
        userNameLabel.text = user.userName
        positionImageView.image = UIImage(named: user.position)
        tierLabel.text = user.tier
        tierLabel.textColor = UIColor(named: user.tier)
    }

    var user: UserInfo?

    let wholeView = UIView()

    let profileView = UIView()
    let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        imageView.layer.borderColor = UIColor.rgrgColor3.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
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

extension ProfileVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupProfileView()
        setImageTapGesture()
        FBUserManager.shared.getUserInfo { user in
            self.user = user
            print("### \(user)")
            DispatchQueue.main.async {
                self.setupLabels()
                self.setupImages()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        tabBarController?.navigationItem.title = "마이페이지"
        tabBarController?.navigationItem.rightBarButtonItem?.isHidden = true
        tabBarController?.navigationItem.hidesBackButton = true
        tabBarController?.navigationController?.navigationBar.isHidden = false
    }
}

extension ProfileVC {
    func configureUI() {
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        view.addSubview(wholeView)

        wholeView.backgroundColor = .rgrgColor5

        wholeView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        [profileView].forEach { wholeView.addSubview($0) }

        profileView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(204)
        }
    }

    func setupProfileView() {
        profileView.backgroundColor = UIColor(hex: "#FFFFFF")
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

        labelStackView.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.centerY.equalTo(profileImageView)
        }

        positionImageOuterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(profileImageView.snp.bottom).offset(14)
            make.height.width.equalTo(35)
        }

        tierLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }

        tierView.snp.makeConstraints { make in
            make.left.equalTo(positionImageOuterView.snp.right).offset(8)
            make.centerY.equalTo(positionImageOuterView)
            make.height.equalTo(35)
            make.right.equalTo(tierLabel).offset(12)
        }

        buttonStackView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }

    func setImageTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toEditProfile))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }

    func setupNavigationBar() {
        tabBarController?.navigationItem.title = "마이페이지"
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.rgrgColor4]

        let backButton = UIButton()
        backButton.setTitle("", for: .normal)

        let customItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customItem
    }
}

extension ProfileVC {
    func setupLabels() {
        userNameLabel.text = user?.userName
        userNameLabel.font = .myBoldSystemFont(ofSize: 20)
        userNameLabel.textColor = UIColor(hex: "#505050")

        emailLabel.text = user?.email
        emailLabel.font = .mySystemFont(ofSize: 14)
        emailLabel.textColor = UIColor(hex: "#767676")

        tierLabel.text = user?.tier
        tierLabel.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        tierLabel.textColor = UIColor(named: user?.tier ?? "Black")
    }

    func setupImages() {
        profileImageView.image = UIImage(named: user?.profilePhoto ?? "Default")
        positionImageView.image = UIImage(named: user?.position ?? "Support")
    }

    func setupButtons() {
        myWritingButton.snp.makeConstraints { $0.height.equalTo(44) }
        settingButton.snp.makeConstraints { $0.height.equalTo(44) }

        var plainConfigure = UIButton.Configuration.plain()
        plainConfigure.imagePadding = 4

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

extension ProfileVC {
    @objc func myWritingButtonPressed() {
        let partyInfoIWroteVC = MyPartyVC()
        navigationController?.pushViewController(partyInfoIWroteVC, animated: true)
    }

    @objc func settingButtonPressed() {
        let settingVC = SettingVC()
        navigationController?.pushViewController(settingVC, animated: true)
    }

    @objc func toEditProfile() {
        let editProfileVC = EditProfileVC()
        editProfileVC.delegate = self
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
}
