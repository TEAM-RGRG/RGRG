//
//  ChatSettingCell.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/18/23.
//

import SnapKit
import SwiftUI
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
        settingIconImageView.image = UIImage(systemName: "bell")
        settingIconImageView.backgroundColor = .systemBlue
        settingIconImageView.tintColor = .white
        settingIconImageView.layer.cornerRadius = 30
        settingIconImageView.contentMode = .scaleAspectFit

        settingIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(60)
            make.width.equalTo(60)
        }
    }
    
    func confirmSettingTitle() {
        contentView.addSubview(settingTitleLabel)
        settingTitleLabel.text = "나가기"
        settingTitleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        settingTitleLabel.setupLabelColor(color: .systemRed)
        settingTitleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - SwiftUI Preview

@available(iOS 13.0, *)
struct ChatSettingCellRepresentble: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ChatSettingCellRepresentble>) {}

    func makeUIView(context: Context) -> UIView { ChatSettingCell().contentView }
}

@available(iOS 13.0, *)
struct ChatSettingCellPreview: PreviewProvider {
    static var previews: some View { ChatSettingCellRepresentble().frame(height: 80)
    }
}
