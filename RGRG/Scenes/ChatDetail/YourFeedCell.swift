//
//  YourFeedCell.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/17/23.
//

import SnapKit
import UIKit

class YourFeedCell: UITableViewCell {
    static let identifier = "YourFeedCell"

    let baseView = UIView(frame: .zero)
    let yourProfileImage = CustomImageView(frame: .zero)
    let yourChatContent = CustomLabel(frame: .zero)
    let yourChatTime = CustomLabel(frame: .zero)
}

extension YourFeedCell {
    func setupUI() {
        confirmBaseView()
        confirmProfileImage()
        confirmYourChatContent()
        confirmYourCahtTime()
    }
}

extension YourFeedCell {
    func confirmBaseView() {
        contentView.addSubview(baseView)
        
        baseView.backgroundColor = .systemGray3

        baseView.roundCorners(topLeft: 10, topRight: 10, bottomLeft: 2, bottomRight: 10)

        let borderLayer = CAShapeLayer()
        borderLayer.path = (baseView.layer.mask! as! CAShapeLayer).path! // Reuse the Bezier path
        borderLayer.strokeColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1
        borderLayer.frame = baseView.bounds
        baseView.layer.addSublayer(borderLayer)

        baseView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.leading.equalTo(contentView).offset(52)
            make.trailing.equalTo(contentView).offset(-154)
        }
    }

    func confirmProfileImage() {
        contentView.addSubview(yourProfileImage)
        yourProfileImage.image = UIImage(systemName: "bell")
        yourProfileImage.backgroundColor = .systemPink
        yourProfileImage.layer.cornerRadius = 17

        yourProfileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(contentView).offset(12)
            make.width.height.equalTo(34)
        }
    }

    func confirmYourChatContent() {
        baseView.addSubview(yourChatContent)

        yourChatContent.text = "Hello _ world"
        yourChatContent.numberOfLines = 0
        yourChatContent.textAlignment = .natural
        yourChatContent.font = .systemFont(ofSize: 16)

        yourChatContent.snp.makeConstraints { make in
            make.top.equalTo(baseView).offset(8)
            make.bottom.equalTo(baseView).offset(-8)
            make.leading.equalTo(baseView).offset(10)
            make.trailing.equalTo(baseView).offset(-10)
        }
    }

    func confirmYourCahtTime() {
        contentView.addSubview(yourChatTime)

        yourChatTime.text = "09:00 PM"
        yourChatTime.font = .systemFont(ofSize: 12)

        yourChatTime.snp.makeConstraints { make in
            make.leading.equalTo(baseView.snp.trailing).offset(4)
            make.bottom.equalTo(baseView)
            make.height.equalTo(16)
            make.width.greaterThanOrEqualTo(43)
        }
    }
}
