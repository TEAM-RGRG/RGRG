//
//  DeveloperCell.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 11/7/23.
//

import SnapKit
import UIKit

class DeveloperCell: UITableViewCell {
    static let identifier = "DeveloperCell"

    let developerName = CustomLabel(frame: .zero)
    let developerEmail = CustomLabel(frame: .zero)
}

extension DeveloperCell {
    func setupUI() {
        addView()
        confirmName()
        confirmEmail()
    }

    func confirmCell(data: Developer) {
        developerName.text = data.name
        developerName.textColor = .black
        developerEmail.text = data.email
        developerEmail.textColor = .black
    }
}

extension DeveloperCell {
    func addView() {
        [developerName, developerEmail].forEach {
            contentView.addSubview($0)
        }
    }

    func confirmName() {
        developerName.font = UIFont(name: AppFontName.bold, size: 20)
        developerName.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(12)
            make.height.greaterThanOrEqualTo(30)
            make.width.greaterThanOrEqualTo(30)
        }
    }

    func confirmEmail() {
        developerEmail.font = UIFont(name: AppFontName.bold, size: 16)
        developerEmail.snp.makeConstraints { make in
            make.top.equalTo(developerName.snp.bottom).offset(10)
            make.leading.equalTo(contentView).offset(12)
            make.height.greaterThanOrEqualTo(30)
            make.width.greaterThanOrEqualTo(30)
        }
    }
}
