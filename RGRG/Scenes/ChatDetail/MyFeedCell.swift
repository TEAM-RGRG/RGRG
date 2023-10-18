//
//  MyFeedCell.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/17/23.
//

import SnapKit
import UIKit

class MyFeedCell: UITableViewCell {
    static let identifier = "MyFeedCell"

    let myProfileImageView = CustomImageView(frame: .zero)
    let myChatLabel = CustomLabel(frame: .zero)
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

extension MyFeedCell {
    func setupUI() {
        contentView.backgroundColor = .systemRed
        confirmProfileImageView()
        confirmChatLabel()
        confirmTimeLabel()
    }

    func confirmProfileImageView() {
        contentView.addSubview(myProfileImageView)
        myProfileImageView.image = UIImage(systemName: "person")
        myProfileImageView.contentMode = .scaleAspectFit
        myProfileImageView.tintColor = .white
        myProfileImageView.backgroundColor = .black
        myProfileImageView.layer.cornerRadius = 30

        myProfileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView).offset(5)
            make.leading.equalTo(contentView).offset(10)
            make.width.height.equalTo(65)
        }
    }

    func confirmChatLabel() {
        contentView.addSubview(myChatLabel)
        myChatLabel.settingText("Hello WorldHello WorldHello WorldHello WorldHello")
        myChatLabel.numberOfLines = 0
        myChatLabel.settingBackgroundColor(color: .white)

        myChatLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(myProfileImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-60)
        }
    }

    func confirmTimeLabel() {
        contentView.addSubview(timeLabel)
        timeLabel.settingText("12:18")
        timeLabel.setupLabelColor(color: .systemGray6)
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(myChatLabel.snp.trailing).offset(10)
            make.bottom.equalTo(myChatLabel.snp.bottom)
        }
    }
}
