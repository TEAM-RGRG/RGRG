//
//  CustomBackButton.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/24/23.
//

import UIKit

final class CustomBackButton: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        set {
            /* Don't set the menu here */
            /* super.menu = menu */
        }
        get {
            return super.menu
        }
    }
}
