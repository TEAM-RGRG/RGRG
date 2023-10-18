//
//  ChatSettingCell.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/18/23.
//

import SnapKit
import UIKit

class ChatSettingCell: UITableViewCell {
    static let identifier = "ChatSettingCell"

    let settingIconImageView = CustomImageView(frame: .zero)
    let settingTitleLabel = CustomLabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatSettingCell {
    func setupUI() {
        contentView.backgroundColor = .systemPurple
        confirmSettingIcon()
        confirmSettingTitle()
    }

    func confirmSettingIcon() {
        contentView.addSubview(settingIconImageView)
        settingIconImageView.settingImageView(image: "bell")
        settingIconImageView.changeColor(tintColor: .white, backgroundColor: .systemBlue)
        settingIconImageView.configurelayer(corner: 30)
        settingIconImageView.settingContentMode(contentMode: .scaleAspectFit)

        settingIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(60)
            make.width.equalTo(60)
        }
    }

    func confirmSettingTitle() {
        contentView.addSubview(settingTitleLabel)
        settingTitleLabel.settingText("나가기")
        settingTitleLabel.settingTextFont(size: 30, weight: .bold)
        settingTitleLabel.setupLabelColor(color: .systemRed)
        settingTitleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
