//
//  PartyInfoIWroteViewController.swift
//  RGRG
//
//  Created by 이수현 on 11/8/23.
//

import SnapKit
import UIKit

// MARK: 프로퍼티 생성

class PartyInfoIWroteViewController: UIViewController {
    var currentUser: User?

    var partyList: [PartyInfo] = []

    let tierColors: [String: UIColor] = [
        "Iron": .iron,
        "Bronze": .bronze,
        "Silver": .silver,
        "Gold": .gold,
        "Platinum": .platinum,
        "Emerald": .emerald,
        "Diamond": .diamond,
    ]

    let containerView = UIView()

    var partyTable: UITableView = {
        var tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .rgrgColor5
        return tableView
    }()

    let noticeLabel = CustomLabel()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

// MARK: ViewController 생명주기

extension PartyInfoIWroteViewController {
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        FirebaseUserManager.shared.getUserInfo(complition: { user in
            self.currentUser = user
        })
        PartyManager.shared.loadMyParty { [weak self] parties in
            self?.partyList = parties // [PartyInfo] = [PartyInfo]
            if self?.partyList.isEmpty == false {
                self?.noticeLabel.textColor = UIColor.clear
            }
            DispatchQueue.main.async {
                self?.partyTable.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpTableView()
    }
}

// MARK: UI 구성

extension PartyInfoIWroteViewController {
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(partyTable)
        view.addSubview(noticeLabel)

        setupLabel()

        partyTable.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        noticeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setupNavigationBar() {
        navigationItem.title = "내가 쓴 글"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .rgrgColor4
    }

    func setupLabel() {
        noticeLabel.text = "내가 쓴 글이 존재하지 않아요."
        noticeLabel.font = .myBoldSystemFont(ofSize: 14)
        noticeLabel.textColor = UIColor(hex: "#767676")
    }
}

extension PartyInfoIWroteViewController {
    func getColorForTier(_ tier: String) -> UIColor {
        switch tier {
        case "Iron":
            return UIColor.iron
        case "Bronze":
            return UIColor.bronze
        case "Silver":
            return UIColor.silver
        case "Gold":
            return UIColor.gold
        case "Platinum":
            return UIColor.platinum
        case "Emerald":
            return UIColor.emerald
        case "Diamond":
            return UIColor.diamond
        case "Master":
            return UIColor.master
        case "GrandMaster":
            return UIColor.grandMaster
        case "Challenger":
            return UIColor.challenger
        default:
            return UIColor.black
        }
    }
}

// MARK: TableView

extension PartyInfoIWroteViewController: UITableViewDelegate, UITableViewDataSource {
    func setUpTableView() {
        partyTable.register(PartyTableViewCell.self, forCellReuseIdentifier: "PartyTableViewCell")
        partyTable.delegate = self
        partyTable.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = partyList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as? PartyTableViewCell else { return UITableViewCell() }

        cell.userNameLabel.text = item.title
        cell.profileImage.image = UIImage(named: item.profileImage)
        cell.profileImage.layer.masksToBounds = true
        cell.positionImage.image = UIImage(named: item.position)

        cell.firstPositionImage.image = UIImage(named: item.hopePosition[0] ?? "Mid")
        cell.secondPositionImage.image = UIImage(named: item.hopePosition[1] ?? "Mid")

        cell.tierLabel.text = item.tier
        cell.tierLabel.textColor = getColorForTier(item.tier)

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = partyList[indexPath.row]
        let detailController = PartyInfoDetailVC()
        detailController.party = item
        detailController.user = currentUser
        detailController.partyID = item.thread ?? "n/a"
        navigationController?.pushViewController(detailController, animated: true)
    }
}
