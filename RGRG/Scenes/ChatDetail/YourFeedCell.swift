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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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

        baseView.backgroundColor = UIColor(hex: "#ADADAD")

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
        }
    }

    func confirmProfileImage() {
        contentView.addSubview(yourProfileImage)
        yourProfileImage.layer.cornerRadius = 17
        yourProfileImage.layer.masksToBounds = true

        yourProfileImage.snp.makeConstraints { make in
            make.bottom.equalTo(baseView)
            make.leading.equalTo(contentView).offset(12)
            make.width.height.equalTo(34)
        }
    }

    func confirmYourChatContent() {
        baseView.addSubview(yourChatContent)
        yourChatContent.numberOfLines = 0
        yourChatContent.textAlignment = .natural
        yourChatContent.font = UIFont(name: "NotoSansKR-VariableFont_wght", size: 16)
        yourChatContent.textColor = UIColor(hex: "#FFFFFF")

        yourChatContent.snp.makeConstraints { make in
            make.top.equalTo(baseView).offset(4)
            make.bottom.equalTo(baseView).offset(-4)
            make.leading.equalTo(baseView).offset(10)
            make.trailing.equalTo(baseView).offset(-10)
            make.height.greaterThanOrEqualTo(34)
            make.width.lessThanOrEqualTo(208)
        }
    }

    func confirmYourCahtTime() {
        contentView.addSubview(yourChatTime)
        yourChatTime.font = UIFont.mySystemFont(ofSize: 12)
        yourChatTime.textColor = .black

        yourChatTime.snp.makeConstraints { make in
            make.leading.equalTo(baseView.snp.trailing).offset(4)
            make.bottom.equalTo(baseView)
            make.height.equalTo(16)
            make.width.greaterThanOrEqualTo(43)
        }
    }
}
