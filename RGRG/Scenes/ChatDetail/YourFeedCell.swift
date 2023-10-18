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

    let yourProfileImageView = CustomImageView(frame: .zero)
    let yourChatLabel = CustomLabel(frame: .zero)
    let timeLabel = CustomLabel(frame: .zero)

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
        contentView.backgroundColor = .systemPurple
        confirmProfileImageView()
        confirmChatLabel()
        confirmTimeLabel()
    }

    func confirmProfileImageView() {
        contentView.addSubview(yourProfileImageView)
        yourProfileImageView.settingImageView(image: "person")
        yourProfileImageView.settingContentMode(contentMode: .scaleAspectFit)
        yourProfileImageView.changeColor(tintColor: .white, backgroundColor: .black)
        yourProfileImageView.configurelayer(corner: 30)

        yourProfileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView).offset(5)
            make.trailing.equalTo(contentView).offset(-10)
            make.width.height.equalTo(65)
        }
    }

    func confirmChatLabel() {
        contentView.addSubview(yourChatLabel)
        yourChatLabel.settingText("Hello WorldHello WorldHello WorldHello WorldHello")
        yourChatLabel.numberOfLines = 0
        yourChatLabel.settingBackgroundColor(color: .white)

        yourChatLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(60)
            make.trailing.equalTo(yourProfileImageView.snp.leading).offset(-10)
        }
    }

    func confirmTimeLabel() {
        contentView.addSubview(timeLabel)
        timeLabel.settingText("12:18")
        timeLabel.setupLabelColor(color: .systemGray6)
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(yourChatLabel.snp.leading).offset(-10)
            make.bottom.equalTo(yourChatLabel.snp.bottom)
        }
    }
}
