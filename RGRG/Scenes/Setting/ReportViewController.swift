//
//  ReportViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 11/7/23.
//

import UIKit

class ReportViewController: UIViewController {
    var pageTitle: String?
}

extension ReportViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = pageTitle
    }
}
