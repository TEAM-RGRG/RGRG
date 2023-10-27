//
//  ChatListCell.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/16/23.
//

import SnapKit
import SwiftUI
import UIKit

class ChatListCell: UITableViewCell {
    static let identifier: String = "ChatListCell"

    let baseView = UIView(frame: .zero)
    let userProfileImage = CustomImageView(frame: .zero)
    let userProfileName = CustomLabel(frame: .zero)
    let currentChat = CustomLabel(frame: .zero)
    let chatAlert = UIView(frame: .zero)
}

// MARK: - Setting UI

extension ChatListCell {
    func setupUI() {
        confirmBaseView()
        confirmProfileImage()
        confirmUserName()
        confirmCurrentChat()
        confirmChatAlert()
    }
}

extension ChatListCell {
    func confirmBaseView() {
        contentView.addSubview(baseView)

        baseView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.centerX.equalToSuperview()
            make.leading.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView)
        }

        baseView.layer.cornerRadius = 10
        baseView.backgroundColor = .white
    }

    func confirmProfileImage() {
        baseView.addSubview(userProfileImage)

        userProfileImage.image = UIImage(systemName: "sun.max")
        userProfileImage.backgroundColor = .systemBlue
        userProfileImage.layer.cornerRadius = 26
        
        userProfileImage.layer.borderWidth = 1
        userProfileImage.layer.borderColor = UIColor.black.cgColor

        userProfileImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(baseView).offset(14)
            make.leading.equalTo(baseView).offset(20)
            make.trailing.equalTo(baseView).offset(-305)
        }
    }

    func confirmUserName() {
        baseView.addSubview(userProfileName)

        userProfileName.text = "페이커"
        userProfileName.font = .systemFont(ofSize: 20, weight: .bold)
        userProfileName.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.top).offset(16)
            make.leading.equalTo(baseView).offset(87)
            make.trailing.equalTo(baseView).offset(-70)
            make.bottom.equalTo(baseView).offset(-44)
        }
    }

    func confirmCurrentChat() {
        baseView.addSubview(currentChat)

        currentChat.text = "두 자리 혹시 가능할까요? 이 편지는 "
        currentChat.numberOfLines = 1
        currentChat.font = .systemFont(ofSize: 16)

        currentChat.snp.makeConstraints { make in
            make.top.equalTo(baseView).offset(44)
            make.leading.equalTo(baseView).offset(87)
            make.trailing.equalTo(baseView).offset(-33)
            make.bottom.equalTo(baseView).offset(-20)
        }
    }

    func confirmChatAlert() {
        baseView.addSubview(chatAlert)

        chatAlert.backgroundColor = .systemBlue
        chatAlert.layer.cornerRadius = 4

        chatAlert.snp.makeConstraints { make in
            make.top.equalTo(baseView).offset(36)
            make.leading.equalTo(baseView).offset(357)
            make.trailing.equalTo(baseView).offset(-12)
            make.bottom.equalTo(baseView).offset(-36)
        }
    }
}
