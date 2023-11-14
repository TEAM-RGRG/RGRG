//
//  BlockSettingViewController.swift
//  RGRG
//
//  Created by 이수현 on 11/14/23.
//

import SnapKit
import UIKit

class BlockSettingViewController: UIViewController {
    var user: User?

    let blockTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .rgrgColor5
        return tableView
    }()
}

extension BlockSettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        setNavigation()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        FirebaseUserManager.shared.getUserInfo { user in
            self.user = user
        }
    }
}

extension BlockSettingViewController {
    func setNavigation() {
        navigationItem.title = "차단목록 관리"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .rgrgColor4
    }

    func configureUI() {
        view.backgroundColor = .white

        view.addSubview(blockTable)
        blockTable.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}

extension BlockSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func setTable() {
        blockTable.delegate = self
        blockTable.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        return cell
    }
}
