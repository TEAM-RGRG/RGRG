//
//  CustomLabel.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/16/23.
//

import UIKit

final class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomLabel {
    func setupLabelColor(color: UIColor) {
        textColor = color
    }

    func settingTextFont(size: CGFloat, weight: UIFont.Weight) {
        font = .systemFont(ofSize: size, weight: weight)
    }

    func settingBackgroundColor(color: UIColor) {
        backgroundColor = color
    }

    func settingText(_ text: String) {
        self.text = text
    }
}
