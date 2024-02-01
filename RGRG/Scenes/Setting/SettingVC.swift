//
//  SettingVC.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import FirebaseAuth
import FirebaseCore
import SnapKit
import UIKit

class SettingVC: UIViewController {
    let developInfoVC = DeveloperInfoVC()
    let reportVC = ReportVC()

    let settingList = [
        "차단목록 관리", "로그아웃", "회원탈퇴", "신고하기", "개발자 정보", "버전 정보 : \(VersionManager.info)"
    ]
    var user: UserInfo?
    let settingTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()

    let container = UIView()
    let loginVC = LoginVC()
    let current = Auth.auth().currentUser?.uid

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension SettingVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        configureUI()
        setupSettingTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupSettingTable()
    }
}

extension SettingVC {
    func configureUI() {
        setupNavigationBar()
        container.backgroundColor = .rgrgColor5
        view.backgroundColor = .white

        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }

        container.addSubview(settingTable)
        settingTable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = "환경 설정"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .rgrgColor4
    }
}

extension SettingVC {
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    func deleteUser() {
        if let user = Auth.auth().currentUser {
            user.delete { [self] error in
                if let error = error {
                    print("Firebase Error : ", error)
                } else {
                    print("회원탈퇴 성공!")
                }
            }
        } else {
            print("로그인 정보가 존재하지 않습니다")
        }
    }
}

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
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
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = settingList[indexPath.row]
        if indexPath.row == 0 {
            let blockSettingVC = BlockSettingVC()
            navigationController?.pushViewController(blockSettingVC, animated: true)
        }

        if indexPath.row == 1 {
            let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "로그아웃", style: .cancel, handler: { _ in

                self.signOut()
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                self.removeAllNavigationStack()
            })
            let cancel = UIAlertAction(title: "취소", style: .default)

            alert.addAction(ok)
            alert.addAction(cancel)

            present(alert, animated: true)
        }
        if indexPath.row == 2 {
            let alert = UIAlertController(title: "회원 탈퇴", message: "회원 탈퇴 시 작성한 글은 삭제되지 않습니다. 정말로 삭제하시겠습니까?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "회원 탈퇴", style: .cancel, handler: { _ in
                FBUserManager.shared.getUserInfo { user in
                    self.user = user
                }
                let updatedUser = UserInfo(email: "알 수 없음", userName: "알 수 없음", tier: self.user?.tier ?? "Bronze", position: self.user?.position ?? "Top", mostChampion: self.user?.mostChampion ?? ["None", "None", "None"], uid: self.current ?? "", iBlocked: self.user?.iBlocked ?? ["n/a"], youBlocked: self.user?.youBlocked ?? ["n/a"])
                FBUserManager.shared.updateUserInfo(userInfo: updatedUser)
                FBUpdateManager.shared.partyUserUpdate(user: updatedUser)
                FBUpdateManager.shared.channelsUserUpdate(updateProfile: updatedUser.profilePhoto)

                self.deleteUser()
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                self.removeAllNavigationStack()
            })
            let cancel = UIAlertAction(title: "취소", style: .default)

            alert.addAction(ok)
            alert.addAction(cancel)

            present(alert, animated: true)
        }

        if indexPath.row == 3 {
            reportVC.title = item

            navigationController?.pushViewController(reportVC, animated: true)
        }

        if indexPath.row == 4 {
            developInfoVC.title = item
            developInfoVC.viewWillAppear(true)
            navigationController?.pushViewController(developInfoVC, animated: true)
        }
    }
}

extension SettingVC {
    func removeAllNavigationStack() {
        guard let navigationController = navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!) // To remove all previous UIViewController except the last one
        self.navigationController?.viewControllers = navigationArray
    }
}
