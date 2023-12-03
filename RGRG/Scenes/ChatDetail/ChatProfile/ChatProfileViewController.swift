//
//  ChatProfileViewController.swift
//  RGRG
//
//  Created by 준우의 MacBook 16 on 11/26/23.
//

import SnapKit
import UIKit

class ChatProfileViewController: UIViewController {
    var channelInfo: Channel?
    var currentUserID: String?
    var userInfo: User?

    let userNameGuideLabel = CustomLabel(frame: .zero)
    let userTierGuideLabel = CustomLabel(frame: .zero)
    let userPositionGuideLabel = CustomLabel(frame: .zero)
    let userMostChampionsGuideLabel = CustomLabel(frame: .zero)

    let userProfileImageView = CustomImageView(frame: .zero)
    let userNameLabel = CustomLabel(frame: .zero)
    let userTierLabel = CustomLabel(frame: .zero)
    let userPositionImageView = CustomImageView(frame: .zero)

    let userChampionStackView = CustomStackView(frame: .zero)
    let userFirstChampion = CustomImageView(frame: .zero)
    let userSecondChampion = CustomImageView(frame: .zero)
    let userThirdChampion = CustomImageView(frame: .zero)
}

// MARK: - View Life Cycle

extension ChatProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("#### ChatProfileVC: \(channelInfo)")
        print("#### CurrentUser: \(currentUserID)")
        requestUserData()
    }
}

// MARK: - Setting Up UI

extension ChatProfileViewController {
    func setupUI() {
        view.backgroundColor = .white
        addView()

        confirmProfileImageView()

        confirmNameGuideLabel()
        confirmNameLabel()

        confirmTierGuidLabel()
        confirmTierLabel()

        confirmPositionGuideLabel()
        confirmPositionImageView()

        confirmChampionGuideLabel()
        confirmChampionStackView()
    }

    func addView() {
        // View에 등록
        [userProfileImageView, userNameLabel, userTierLabel, userPositionImageView, userChampionStackView].forEach {
            view.addSubview($0)
        }

        // View에 등록
        [userNameGuideLabel, userTierGuideLabel, userPositionGuideLabel, userMostChampionsGuideLabel].forEach {
            view.addSubview($0)
        }

        // StackView에 등록
        [userFirstChampion, userSecondChampion, userThirdChampion].forEach {
            userChampionStackView.addArrangedSubview($0)
        }
    }
}

// MARK: - Confirm UI

extension ChatProfileViewController {
    func confirmProfileImageView() {
        if let user = userInfo {
            userProfileImageView.image = UIImage(named: user.profilePhoto)
            userProfileImageView.layer.cornerRadius = 100
            userProfileImageView.layer.masksToBounds = true
            userProfileImageView.layer.borderWidth = 2
            userProfileImageView.layer.borderColor = UIColor.black.cgColor

            userProfileImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view).offset(40)
                make.height.width.equalTo(200)
            }
        }
    }

    func confirmNameGuideLabel() {
        userNameGuideLabel.text = "유저 이름"
        userNameGuideLabel.font = UIFont(name: AppFontName.bold, size: 16)

        userNameGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(userProfileImageView.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(50)
            make.width.height.greaterThanOrEqualTo(22)
        }
    }

    func confirmNameLabel() {
        if let user = userInfo {
            userNameLabel.text = user.userName
            userNameLabel.font = UIFont(name: AppFontName.bold, size: 20)

            userNameLabel.snp.makeConstraints { make in
                make.top.equalTo(userNameGuideLabel.snp.bottom).offset(5)
                make.leading.equalTo(userNameGuideLabel)
                make.width.height.greaterThanOrEqualTo(30)
            }
        }
    }

    func confirmTierGuidLabel() {
        userTierGuideLabel.text = "티어"
        userTierGuideLabel.font = UIFont(name: AppFontName.bold, size: 16)

        userTierGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(50)
            make.width.height.greaterThanOrEqualTo(12)
        }
    }

    func confirmTierLabel() {
        if let user = userInfo {
            userTierLabel.text = user.tier
            userTierLabel.font = UIFont(name: AppFontName.medium, size: 20)

            userTierLabel.snp.makeConstraints { make in
                make.top.equalTo(userTierGuideLabel.snp.bottom).offset(5)
                make.leading.equalTo(userTierGuideLabel)
                make.width.height.greaterThanOrEqualTo(16)
            }
        }
    }

    func confirmPositionGuideLabel() {
        userPositionGuideLabel.text = "포지션"
        userPositionGuideLabel.font = UIFont(name: AppFontName.bold, size: 16)

        userPositionGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(userTierLabel.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(50)
            make.width.height.greaterThanOrEqualTo(12)
        }
    }

    func confirmPositionImageView() {
        if let user = userInfo {
            userPositionImageView.image = UIImage(named: user.position)
            userPositionImageView.backgroundColor = .systemOrange
            userPositionImageView.contentMode = .scaleAspectFit
            userPositionImageView.layer.cornerRadius = 10
            userPositionImageView.layer.masksToBounds = true

            userPositionImageView.snp.makeConstraints { make in
                make.top.equalTo(userPositionGuideLabel.snp.bottom).offset(5)
                make.leading.equalTo(userPositionGuideLabel)
                make.width.height.equalTo(40)
            }
        }
    }

    func confirmChampionGuideLabel() {
        userMostChampionsGuideLabel.text = "선호 챔피언"
        userMostChampionsGuideLabel.font = UIFont(name: AppFontName.bold, size: 16)

        userMostChampionsGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(userPositionImageView.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(50)
            make.width.height.greaterThanOrEqualTo(12)
        }
    }

    func confirmChampionStackView() {
        if let user = userInfo {
            var cornerValue: CGFloat = 40

            userChampionStackView.configure(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 30)

            userFirstChampion.image = UIImage(named: user.mostChampion[0])
            userFirstChampion.layer.cornerRadius = cornerValue
            userFirstChampion.layer.masksToBounds = true

            userSecondChampion.image = UIImage(named: user.mostChampion[1])
            userSecondChampion.layer.cornerRadius = cornerValue
            userSecondChampion.layer.masksToBounds = true

            userThirdChampion.image = UIImage(named: user.mostChampion[2])
            userThirdChampion.layer.cornerRadius = cornerValue
            userThirdChampion.layer.masksToBounds = true

            userChampionStackView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(userMostChampionsGuideLabel.snp.bottom).offset(5)
                make.leading.equalTo(view).offset(40)
                make.height.equalTo(80)
            }
        }
    }
}

// MARK: - Request User Data

extension ChatProfileViewController {
    func requestUserData() {
        var user = ""

        if currentUserID == channelInfo?.host {
            user = channelInfo?.guest ?? "n/a"
        } else {
            user = channelInfo?.host ?? "n/a"
        }

        FirebaseUserManager.shared.getUserInfo(searchUser: user) { [weak self] requestUser in
            guard let self = self else { return }
            print("#### ChatProfileVC Search: \(requestUser)")
            userInfo = requestUser

            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }
}
