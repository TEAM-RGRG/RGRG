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
    func setupShadow() {
        layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.10)
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
    }
}

