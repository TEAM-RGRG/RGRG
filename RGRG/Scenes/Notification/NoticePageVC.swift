//
//  NoticePageVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/18.
//

import Foundation
import SnapKit
import UIKit

#warning("UI 코드 중복 제거 및 공용 컴포넌트 활용할 것")
class NoticePageVC: UIViewController {
    let userName = ["페이커쨩", "탑농부", "5시퇴근", "칼서렌즐", "아잘못눌럿다"]
    
    let tier = ["Iron", "Silver", "Gold", "Platinum", "Bronze"]
    
    let mainPlayTime = ["#8:00~11:00", "#8:00~11:00", "#8:00~11:00", "#11:00~01:00", "#10:00~12:00"]
    
    let partyTier = ["#골드", "#플레티넘", "#상관없음", "#마스터", "#실버"]
    
    let partyPosition = ["#정글", "#서폿", "#상관없음", "#서폿", "#상관없음"]
    
    let topFrame: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.addBottomBorder(color: UIColor.black, width: 2.0)
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .rgrgColor5
        return view
    }()
    
    lazy var noticeListTable: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .rgrgColor5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
}

// MARK: - View Life Cycle

extension NoticePageVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "알림"
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        configureUI()
        
        noticeListTable.register(UserInfoCell.self, forCellReuseIdentifier: "userInfoCell")
        noticeListTable.delegate = self
        noticeListTable.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        configureUI()
    }
}

// MARK: - Setting UI

extension NoticePageVC {
    func configureUI() {
        view.backgroundColor = .rgrgColor5
        view.addSubview(topFrame)
        view.addSubview(contentView)
        contentView.addSubview(noticeListTable)
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true // 버튼의 가로 크기
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.imageEdgeInsets = .init(top: -18, left: -18, bottom: -18, right: -18)
        
        let customItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customItem

        topFrame.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(-2)
            $0.trailing.equalToSuperview().offset(2)
            $0.height.equalTo(97)
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(topFrame.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
        
        noticeListTable.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
    
// MARK: - UITableViewDataSource

extension NoticePageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! UserInfoCell
        cell.userNameLabel.text = userName[indexPath.row]
        cell.tierLabel.text = tier[indexPath.row]
        
        if let tierText = cell.tierLabel.text {
            switch tierText {
            case "Iron":
                cell.tierLabel.textColor = .iron
            case "Bronze":
                cell.tierLabel.textColor = .bronze
            case "Silver":
                cell.tierLabel.textColor = .silver
            case "Gold":
                cell.tierLabel.textColor = .gold
            case "Platinum":
                cell.tierLabel.textColor = .platinum
            case "Emerald":
                cell.tierLabel.textColor = .emerald
            case "Diamond":
                cell.tierLabel.textColor = .diamond
            default:
                cell.tierLabel.textColor = .black
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NoticePageVC: UITableViewDelegate {}

// MARK: - Add Border of Bottom

extension CALayer {
    func addBottomBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: bounds.height - width, width: bounds.width, height: width)
        addSublayer(border)
    }
}
