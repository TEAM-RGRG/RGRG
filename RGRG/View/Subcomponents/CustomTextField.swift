//
//  CustomTextField.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/18/23.
//

import UIKit

final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextField {
    func settingCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func settingBorder(borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    func settingPlaceholder(description: String) {
        placeholder = description
    }
    
    func settingLeftPadding() {
        leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        leftViewMode = .always
    }
}
