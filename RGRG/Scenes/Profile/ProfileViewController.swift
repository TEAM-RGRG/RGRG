//
//  ProfileViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    let profileTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()


    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureUI()
    }
}

extension ProfileViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        configureProfileTable()
    }

    func configureProfileTable() {
        view.addSubview(profileTableView)
        profileTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(ProfileTableViewCell_Profile.self, forCellReuseIdentifier: "ProfileCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = profileTableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell_Profile
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 321
        } else {
            return 57
        }
    }
}
