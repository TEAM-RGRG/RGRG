//
//  ChatAlertCell.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/28/23.
//

import SnapKit
import UIKit

class ChatAlertCell: UITableViewCell {
    static let identifier = "ChatAlertCell"

    let baseView = UIView(frame: .zero)
    let alertContent = CustomLabel(frame: .zero)

//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

extension ChatAlertCell {
    func setupUI() {
        confirmBaseView()
        confirmAlertContent()
    }
}

extension ChatAlertCell {
    func confirmBaseView() {
        contentView.addSubview(baseView)

        baseView.backgroundColor = UIColor(hex: "#D9D9D9")
        baseView.layer.cornerRadius = 10

        baseView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.centerX.equalToSuperview()
            make.leading.equalTo(contentView).offset(12)
            make.bottom.equalTo(contentView).offset(-8)
        }
    }

    func confirmAlertContent() {
        baseView.addSubview(alertContent)
        alertContent.text = """
        계좌번호나 전화번호 등 개인정보를 요구하는 경우 피해가 있을 수 있으니 주의하세요!
        """
        alertContent.textColor = UIColor(hex: "#505050")
        alertContent.textAlignment = .center
        alertContent.font = UIFont(name: "NotoSansKR-VariableFont_wght", size: 14)
        alertContent.numberOfLines = 2

        alertContent.snp.makeConstraints { make in
            make.leading.equalTo(baseView).offset(16)
            make.trailing.equalTo(baseView).offset(-16)
            make.top.equalTo(baseView).offset(9)
            make.bottom.equalTo(baseView).offset(-9)
        }
    }
}
