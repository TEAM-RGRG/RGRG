//
//  Extension.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/12.
//

import Foundation
import UIKit

extension UIImage {
    func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIView {
    func setupShadow(alpha: CGFloat, offset: CGSize, radius: CGFloat, opacity: Float) {
        layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: alpha)
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}
