//
//  ChatSettingViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/17/23.
//

import UIKit

class ChatSettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }

    override func viewWillAppear(_ animated: Bool) {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }
    }
}
