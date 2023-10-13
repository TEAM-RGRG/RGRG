//
//  CustomLabel.swift
//  RGRG
//
//  Created by 이수현 on 10/13/23.
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

    func setupLabelColor(color: UIColor) {
        textColor = color
    }
}
