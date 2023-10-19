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

    let superStackView = CustomStackView(frame: .zero)
    let trailingStackView = CustomStackView(frame: .zero)

    let profileIconImageView = CustomImageView(frame: .zero)
    let chatAlertIconView = UIView(frame: .zero)

    let profileNameLabel = CustomLabel(frame: .zero)
    let chatDescriptionLabel = CustomLabel(frame: .zero)
    let timeLabel = CustomLabel(frame: .zero)
    let alertCountLabel = CustomLabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatListCell {
    func setupUI() {
        confirmProfileIcon()
        confirmStackView()
        confirmProfileNameLabel()
        confirmChatDescriptionLabel()
        confirmTrailingStackView()
        confirmTimeLabel()
        confirmAlertIcon()
    }

    func confirmProfileIcon() {
        contentView.addSubview(profileIconImageView)
        profileIconImageView.image = UIImage(systemName: "sun.max")
        profileIconImageView.backgroundColor = .systemBlue
        profileIconImageView.tintColor = .white
        profileIconImageView.layer.masksToBounds = true
        profileIconImageView.configurelayer(corner: 30)

        profileIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView).offset(10)
            make.top.equalTo(contentView).inset(10)
            make.width.equalTo(60)
        }
    }

    func confirmStackView() {
        contentView.addSubview(superStackView)
        superStackView.configure(axis: .vertical, alignment: .fill, distribution: .fillProportionally, spacing: 0)
        [profileNameLabel, chatDescriptionLabel].forEach {
            superStackView.addArrangedSubview($0)
        }

        superStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileIconImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.top.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-70)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    func confirmProfileNameLabel() {
        profileNameLabel.text = "김준우"
        profileNameLabel.font = .systemFont(ofSize: 25, weight: .bold)
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
    }

    func confirmChatDescriptionLabel() {
        chatDescriptionLabel.text = "Hello_WorldHello_WorldHello_WorldHello_WorldHello_WorldHello_WorldHello_WorldHello_WorldHello_WorldHello_WorldHello_World"
        chatDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        chatDescriptionLabel.numberOfLines = 2
        chatDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
    }
}

extension ChatListCell {
    func confirmTrailingStackView() {
        contentView.addSubview(trailingStackView)
        trailingStackView.configure(axis: .vertical, alignment: .center, distribution: .fillProportionally, spacing: 0)
        [timeLabel, chatAlertIconView].forEach {
            trailingStackView.addArrangedSubview($0)
        }
        trailingStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(superStackView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(contentView).offset(10)
        }
    }

    func confirmTimeLabel() {
        timeLabel.text = "10월 17일"
        timeLabel.textAlignment = .center
        timeLabel.font = .systemFont(ofSize: 12, weight: .bold)
        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }

    func confirmAlertIcon() {
        chatAlertIconView.addSubview(alertCountLabel)
        chatAlertIconView.backgroundColor = .systemRed
        chatAlertIconView.layer.cornerRadius = 15
        alertCountLabel.text = "0"
        alertCountLabel.setupLabelColor(color: .white)
        alertCountLabel.textAlignment = .center
        alertCountLabel.font = .systemFont(ofSize: 12, weight: .bold)

        chatAlertIconView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }

        alertCountLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(10)
        }
    }
}

// MARK: - SwiftUI Preview

@available(iOS 13.0, *)
struct ChatListCellRepresentble: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ChatListCellRepresentble>) {}

    func makeUIView(context: Context) -> UIView { ChatListCell().contentView
    }
}

@available(iOS 13.0, *)
struct ChatListCellPreview: PreviewProvider {
    static var previews: some View { ChatListCellRepresentble().frame(height: 80)
    }
}
