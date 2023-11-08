//
//  MainViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

// MARK: 프로퍼티 생성

class MainViewController: UIViewController, SendSelectedOptionDelegate {
    func sendSelectedOption(tier: String, position: String) {
        updateOptionLabel(tier: tier, position: position)
        if tier == "" {
            if position == "" {
                PartyManager.shared.updateParty(tier: tierName, position: positionName) { [weak self] parties in
                    self?.partyList = parties // [PartyInfo] = [PartyInfo]
                    DispatchQueue.main.async {
                        self?.patryListTable.reloadData()
                    }
                }
            } else {
                PartyManager.shared.updateParty(tier: tierName, position: [position]) { [weak self] parties in
                    self?.partyList = parties // [PartyInfo] = [PartyInfo]
                    DispatchQueue.main.async {
                        self?.patryListTable.reloadData()
                    }
                }
            }
        } else {
            if position == "" {
                PartyManager.shared.updateParty(tier: [tier], position: positionName) { [weak self] parties in
                    self?.partyList = parties // [PartyInfo] = [PartyInfo]
                    DispatchQueue.main.async {
                        self?.patryListTable.reloadData()
                    }
                }
            } else {
                PartyManager.shared.updateParty(tier: [tier], position: [position]) { [weak self] parties in
                    self?.partyList = parties // [PartyInfo] = [PartyInfo]
                    DispatchQueue.main.async {
                        self?.patryListTable.reloadData()
                    }
                }
            }
        }
    }
 
    let testButton = CustomButton(frame: .zero)
    
    var selectedTier: [String] = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond", "Master", "GrandMaster", "Challenger"]
    var selectedPosition: [String] = ["Top", "Jungle", "Mid", "Bottom", "Support"]
    
    let tierName: [String] = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond", "Master", "GrandMaster", "Challenger"]
    let positionName: [String] = ["Top", "Jungle", "Mid", "Bottom", "Support"]
    
    var selectiedTierArray: [String] = []
    
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
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("티어 ", for: .normal)
        button.setTitleColor(.rgrgColor7, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemGray4
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.rgrgColor7.cgColor
        button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var positionOptionLabel: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("포지션 ", for: .normal)
        button.setTitleColor(.rgrgColor7, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemGray4
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.rgrgColor7.cgColor
        button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let listUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        return view
    }()
    
    let listTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "파티 목록"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var patryListTable: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .rgrgColor5
        tableView.separatorStyle = .none
        return tableView
    }()
}

// MARK: ViewController 생명주기

extension MainViewController {
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.isHidden = true
        partyList.removeAll()
        task()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        patryListTable.register(PartyTableViewCell.self, forCellReuseIdentifier: "PartyTableViewCell")
        patryListTable.delegate = self
        patryListTable.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        partyList.removeAll()
    }
}

// MARK: UI 구성

extension MainViewController {
    func updateOptionLabel(tier: String, position: String) {
        // selectedTier 및 selectedPosition의 값에 따라 tierOptionLabel 업데이트
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

    func configureUI() {
        view.backgroundColor = .rgrgColor5
        
        view.addSubview(topFrame)
        topFrame.addSubview(pageTitleLabel)
        topFrame.addSubview(noticePagebutton)
        
        topFrame.addSubview(optionFrame)

        optionFrame.addArrangedSubview(tierOptionLabel)
        optionFrame.addArrangedSubview(positionOptionLabel)
        
        view.addSubview(contentView)
        contentView.addSubview(patryListTable)
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
        
        patryListTable.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(6)
            $0.leading.equalTo(contentView.snp.leading).offset(0)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-0)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
}

// MARK: - 함수

extension MainViewController {
    func task() {
        Task {
            print("############\(selectedTier)#####\(selectedPosition)##########")
            await FirebaseUserManager.shared.getUserInfo(complition: { user in
                print("### CurrentUser Info ::: \(user)")
                self.currentUser = user
            })
            await PartyManager.shared.loadParty { [weak self] parties in
                self?.partyList = parties // [PartyInfo] = [PartyInfo]
                print("### \(self?.partyList)")
                DispatchQueue.main.async {
                    self?.patryListTable.reloadData()
                }
            }
        }
    }
    
    @objc func createPartybuttonTapped() {
        let CreatePartyVC = CreatePartyVC()
        CreatePartyVC.user = currentUser
        navigationController?.pushViewController(CreatePartyVC, animated: true)
    }
    
    @objc func noticePagebuttonTapped() {
        let NoticePageVC = NoticePageVC()
        navigationController?.pushViewController(NoticePageVC, animated: true)
    }
    
    @objc func searchOptionButtonTapped() {
        let searchOptionVC = SearchOptionViewController()
        searchOptionVC.delegate = self
        present(searchOptionVC, animated: true, completion: nil)
    }
}

// MARK:  - TableView

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = partyList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as? PartyTableViewCell else { return UITableViewCell() }
        
        cell.userNameLabel.text = item.userName
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
        default:
            return UIColor.black
        }
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

// extension MainViewController {
//    func removeAllNavigationStack() {
//        guard let navigationController = navigationController else { return }
//        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
//        let temp = navigationArray.last
//        navigationArray.removeAll()
//        navigationArray.append(temp!) // To remove all previous UIViewController except the last one
//        navigationController.viewControllers = navigationArray
//    }
// }
