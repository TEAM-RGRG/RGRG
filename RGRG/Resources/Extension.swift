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


