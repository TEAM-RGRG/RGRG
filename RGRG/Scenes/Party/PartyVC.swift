//
//  PartyVC.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

#warning("UI 코드 중복 제거 및 공용 컴포넌트 활용할 것")
class PartyVC: UIViewController, SendSelectedOptionDelegate {
    var tempList: [String] = []
    let testButton = CustomButton(frame: .zero)
    
    var selectedTier: [String] = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond", "Master", "GrandMaster", "Challenger"]
    var selectedPosition: [String] = ["Top", "Jungle", "Mid", "Bottom", "Support"]
    
    let tierName: [String] = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond", "Master", "GrandMaster", "Challenger"]
    let positionName: [String] = ["Top", "Jungle", "Mid", "Bottom", "Support"]
    
    var selectiedTierArray: [String] = []
    
    var currentUser: UserInfo?
    var partyList: [PartyInfo] = []
    
    let tierColors: [String: UIColor] = [
        "Iron": .iron,
        "Bronze": .bronze,
        "Silver": .silver,
        "Gold": .gold,
        "Platinum": .platinum,
        "Emerald": .emerald,
        "Diamond": .diamond,
        "": .rgrgColor7
    ]
    
    deinit {
        print("### NotificationViewController deinitialized")
    }
    
    let topFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pageTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "RGRG"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
        return label
    }()
    
    let createButtonFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    let createPartybutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "PlusInCircle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createPartybuttonTapped), for: .touchUpInside)
        return button
    }()
    
    let noticePagebutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.addTarget(self, action: #selector(noticePagebuttonTapped), for: .touchUpInside)
        return button
    }()
    
    let optionFrame: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 10
        return view
    }()
    
    var tierOptionLabel: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 16)
        button.setTitle("티어 ", for: .normal)
        button.setTitleColor(.rgrgColor7, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .rgrgColor7
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.rgrgColor5.cgColor
        button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var positionOptionLabel: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 16)
        button.setTitle("포지션 ", for: .normal)
        button.setTitleColor(.rgrgColor7, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .rgrgColor7
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.rgrgColor5.cgColor
        button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
        return button
    }()

    let contentView = UIView()
    
    lazy var partyListTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .rgrgColor5
        tableView.separatorStyle = .none
        return tableView
    }()
}

// MARK: - ViewController 생명 주기

extension PartyVC {
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.isHidden = true
        task()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        partyListTableView.register(PartyCell.self, forCellReuseIdentifier: "PartyTableViewCell")
        partyListTableView.delegate = self
        partyListTableView.dataSource = self
        
        FBPartyManager.shared.updatePartyStatus {
            self.task()
        }
    }
}

// MARK: - UI 구성

extension PartyVC {
    func configureUI() {
        view.backgroundColor = .rgrgColor5
        
        view.addSubview(topFrame)
    
        topFrame.addSubview(pageTitleLabel)
        topFrame.addSubview(noticePagebutton)
        
        topFrame.addSubview(optionFrame)
        
        optionFrame.addArrangedSubview(tierOptionLabel)
        optionFrame.addArrangedSubview(positionOptionLabel)
        
        view.addSubview(contentView)
        contentView.addSubview(partyListTableView)
        view.addSubview(createPartybutton)
        
        topFrame.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(144)
        }
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(topFrame.snp.top).offset(56)
            $0.leading.equalTo(topFrame.snp.leading).offset(20)
        }
        
        noticePagebutton.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.top).offset(0)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(24)
        }
        
        createPartybutton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-112)
            $0.trailing.equalToSuperview().offset(-29)
            $0.height.equalTo(44)
            $0.width.equalTo(44)
        }
 
        optionFrame.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(15)
            $0.height.equalTo(30)
            $0.leading.equalTo(topFrame.snp.leading).offset(20)
            $0.trailing.equalTo(topFrame.snp.trailing).offset(-165)
        }
        
        tierOptionLabel.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(78)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(topFrame.snp.bottom).offset(0)
            $0.bottom.equalTo(view.snp.bottom).offset(-45)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(-0)
        }
        
        partyListTableView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(6)
            $0.leading.equalTo(contentView.snp.leading).offset(0)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-0)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
    
    func updateOptionLabel(tier: String, position: String) {
        if tier != "", position != "" {
            tierOptionLabel.setTitle(" \(tier) ", for: .normal)
            positionOptionLabel.setTitle(" \(position) ", for: .normal)
            
            if let tierColor = tierColors[tier] {
                tierOptionLabel.setTitleColor(tierColor, for: .normal)
            }
            tierOptionLabel.layer.borderColor = UIColor.rgrgColor3.cgColor
            tierOptionLabel.tintColor = .rgrgColor3
            positionOptionLabel.tintColor = .rgrgColor3
            positionOptionLabel.setTitleColor(.rgrgColor3, for: .normal)
            positionOptionLabel.layer.borderColor = UIColor.rgrgColor3.cgColor
            
            selectedTier = [tier]
            selectedPosition = [position]
        } else if tier != "", position == "" {
            // 티어만 선택된 경우
            tierOptionLabel.setTitle(" \(tier) ", for: .normal)
            positionOptionLabel.setTitle("포지션 ", for: .normal)
            
            if let tierColor = tierColors[tier] {
                tierOptionLabel.setTitleColor(tierColor, for: .normal)
            }
            tierOptionLabel.layer.borderColor = UIColor.rgrgColor3.cgColor
            tierOptionLabel.tintColor = .rgrgColor3
            positionOptionLabel.tintColor = .rgrgColor7
            positionOptionLabel.setTitleColor(.rgrgColor7, for: .normal)
            positionOptionLabel.layer.borderColor = UIColor.rgrgColor7.cgColor
            
            selectedTier = [tier]
            selectedPosition = ["Top", "Jungle", "Mid", "Bottom", "Support"]
        } else if tier == "", position != "" {
            // 포지션만 선택된 경우
            tierOptionLabel.setTitle("티어 ", for: .normal)
            positionOptionLabel.setTitle(" \(position) ", for: .normal)
            
            if let tierColor = tierColors[tier ?? "Gold"] {
                tierOptionLabel.setTitleColor(tierColor, for: .normal)
            }
            tierOptionLabel.layer.borderColor = UIColor.rgrgColor7.cgColor
            tierOptionLabel.tintColor = .rgrgColor7
            positionOptionLabel.tintColor = .rgrgColor3
            positionOptionLabel.setTitleColor(.rgrgColor3, for: .normal)
            positionOptionLabel.layer.borderColor = UIColor.rgrgColor3.cgColor
            
            selectedTier = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond", "Master", "GrandMaster", "Challenger"]
            selectedPosition = [position]
        } else if tier == "", position == "" {
            // 둘 다 nil인 경우
            tierOptionLabel.setTitle("티어 ", for: .normal)
            positionOptionLabel.setTitle("포지션 ", for: .normal)
            
            tierOptionLabel.setTitleColor(.rgrgColor7, for: .normal)
            tierOptionLabel.layer.borderColor = UIColor.rgrgColor7.cgColor
            tierOptionLabel.tintColor = .rgrgColor7
            positionOptionLabel.tintColor = .rgrgColor7
            positionOptionLabel.setTitleColor(.rgrgColor7, for: .normal)
            positionOptionLabel.layer.borderColor = UIColor.rgrgColor7.cgColor
            
            selectedTier = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond", "Master", "GrandMaster", "Challenger"]
            selectedPosition = ["Top", "Jungle", "Mid", "Bottom", "Support"]
        }
    }
}

// MARK: - 함수

extension PartyVC {
    func task() {
        FBUserManager.shared.getUserInfo(complition: { user in
            self.currentUser = user
            
            guard let currentUser = self.currentUser else { return }
                
            FBPartyManager.shared.loadParty(iBlocked: currentUser.iBlocked, youBlocked: currentUser.youBlocked) { [weak self] parties in
                self?.partyList = parties
                    
                DispatchQueue.main.async {
                    self?.partyListTableView.reloadData()
                }
            }
        })
    }
    
    @objc func createPartybuttonTapped() {
        let CreatePartyVC = PartyCreateVC()
        CreatePartyVC.user = currentUser
        navigationController?.pushViewController(CreatePartyVC, animated: true)
    }
    
    @objc func noticePagebuttonTapped() {
        let NoticePageVC = NoticePageVC()
        navigationController?.pushViewController(NoticePageVC, animated: true)
    }
    
    @objc func searchOptionButtonTapped() {
        let searchOptionVC = PartyOptionVC()
        searchOptionVC.delegate = self
        present(searchOptionVC, animated: true, completion: nil)
    }
}

// MARK: - TableView

extension PartyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = partyList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as? PartyCell else { return UITableViewCell() }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = partyList[indexPath.row]
        var blockArray: [String] = []
        let detailController = PartyDetailVC()
        detailController.party = item
        detailController.user = currentUser
        detailController.partyID = item.thread ?? "n/a"
        detailController.viewWillAppear(true)
       
        detailController.eventHandler = { [weak self] str in
            self?.tempList.append(str)
        }
        
        if tempList.contains(item.writer) == true {
            print("##### 된다.")
            showAlert()
        } else {
            print("##### 안 된다.")
            navigationController?.pushViewController(detailController, animated: true)
        }
    }
}

extension PartyVC {
    func showAlert() {
        let alert = UIAlertController(title: "차단한 사용자", message: "차단한 사용자입니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension PartyVC {
    func sendSelectedOption(tier: String, position: String) {
        updateOptionLabel(tier: tier, position: position)
        if tier == "" {
            if position == "" {
                FBPartyManager.shared.updateParty(tier: tierName, position: positionName, iBlocked: currentUser?.iBlocked ?? [], youBlocked: currentUser?.youBlocked ?? []) { [weak self] parties in
                    self?.partyList = parties // [PartyInfo] = [PartyInfo]
                    DispatchQueue.main.async {
                        self?.partyListTableView.reloadData()
                    }
                }
            } else {
                FBPartyManager.shared.updateParty(tier: tierName, position: [position], iBlocked: currentUser?.iBlocked ?? [], youBlocked: currentUser?.youBlocked ?? []) { [weak self] parties in
                    self?.partyList = parties // [PartyInfo] = [PartyInfo]
                    DispatchQueue.main.async {
                        self?.partyListTableView.reloadData()
                    }
                }
            }
        } else {
            if position == "" {
                FBPartyManager.shared.updateParty(tier: [tier], position: positionName, iBlocked: currentUser?.iBlocked ?? [], youBlocked: currentUser?.youBlocked ?? []) { [weak self] parties in
                    self?.partyList = parties // [PartyInfo] = [PartyInfo]
                    DispatchQueue.main.async {
                        self?.partyListTableView.reloadData()
                    }
                }
            } else {
                FBPartyManager.shared.updateParty(tier: [tier], position: [position], iBlocked: currentUser?.iBlocked ?? [], youBlocked: currentUser?.youBlocked ?? []) { [weak self] parties in
                    self?.partyList = parties // [PartyInfo] = [PartyInfo]
                    DispatchQueue.main.async {
                        self?.partyListTableView.reloadData()
                    }
                }
            }
        }
    }
}
