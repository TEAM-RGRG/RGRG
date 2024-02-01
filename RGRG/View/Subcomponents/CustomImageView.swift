//
//  CustomImageView.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/16/23.
//

import UIKit

final class CustomImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomImageView {
    func configurelayer(corner radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func settingImageView(image name: String) {
        image = UIImage(systemName: name)
    }

    func settingContentMode(contentMode: UIView.ContentMode) {
        self.contentMode = contentMode
    }

    func changeColor(tintColor: UIColor, backgroundColor: UIColor) {
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
    }
}
