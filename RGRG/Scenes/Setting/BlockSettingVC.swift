//
//  BlockSettingViewController.swift
//  RGRG
//
//  Created by 이수현 on 11/14/23.
//

import SnapKit
import UIKit

class BlockSettingVC: UIViewController {
    var currentUser: UserInfo?
    var blockList: [String] = []

    let container = UIView()

    let blockTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .rgrgColor5
        return tableView
    }()
}

extension BlockSettingVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        setNavigation()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        task()
    }
}

extension BlockSettingVC {
    func task() {
        Task {
            UserBlockManager.shared.getBlockedUser(complition: { blockList in
                self.blockList = blockList

                DispatchQueue.main.async {
                    self.blockTable.reloadData()
                }
            })
        }
    }

    func setNavigation() {
        navigationItem.title = "차단목록 관리"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .rgrgColor4
    }

    func configureUI() {
        container.backgroundColor = .rgrgColor5
        view.backgroundColor = .white

        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }

        container.addSubview(blockTable)
        blockTable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension BlockSettingVC: UITableViewDelegate, UITableViewDataSource {
    func setTable() {
        blockTable.delegate = self
        blockTable.dataSource = self
        blockTable.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell

        cell.backgroundColor = .white

        let item = blockList[indexPath.row]

        FBUserManager.shared.requestUserInfo(searchUser: item, complition: { user in
            cell.textLabel?.text = user.userName
        })

        cell.textLabel?.textColor = .black
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "차단을 해제하시겠습니까?", message: "차단을 해제하면 차단된 친구의 글 정보를 다시 받아볼 수 있습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: { _ in
                UserBlockManager.shared.unBlockUser(ind: indexPath.row)
                self.blockList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            let cancel = UIAlertAction(title: "취소", style: .destructive)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true)

        } else if editingStyle == .insert {}
    }
}
