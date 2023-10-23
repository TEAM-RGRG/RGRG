//
//  LoginViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import FirebaseAuth
import FirebaseCore
import SnapKit
import UIKit

class SettingViewController: UIViewController {
    let settingList = [
        "알림 설정", "차단 목록", "테마 설정", "앱 아이콘 설정", "로그아웃", "회원탈퇴"
    ]

    let settingTable: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension SettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        configureUI()
        setupSettingTable()
    }
}

extension SettingViewController {
    func configureUI() {
        setupNavigationBar()
        view.backgroundColor = .systemBackground
        view.addSubview(settingTable)

        settingTable.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = "환경 설정"
    }
}

extension SettingViewController {
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func setupSettingTable() {
        settingTable.delegate = self
        settingTable.dataSource = self
        settingTable.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.textLabel?.text = settingList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            signOut()
            
        }
    }
}
