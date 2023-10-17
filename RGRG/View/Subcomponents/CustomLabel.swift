//
//  CustomLabel.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/16/23.
//

import UIKit

class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabelColor(color: UIColor) {
        textColor = color
    }
}
