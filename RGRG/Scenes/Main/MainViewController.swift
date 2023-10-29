//
//  MainViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    let testButton = CustomButton(frame: .zero)

    var partyList: [PartyInfo] = []
    
    deinit {
        print("### NotificationViewController deinitialized")
    }
    
    let pageTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "RGRG"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
        return label
    }()
    
    let buttonFrame: UIStackView = {
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
        button.layer.cornerRadius = 29
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createPartybuttonTapped), for: .touchUpInside)
        return button
    }()
    
    let noticePagebutton: UIButton = {
        let button = UIButton()
//        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setImage(UIImage(systemName: "bell")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageEdgeInsets = .init(top: -10, left: -10, bottom: -10, right: -10)
        button.tintColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
//        button.setTitle("알림 확인", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = UIColor.RGRGColor2
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(noticePagebuttonTapped), for: .touchUpInside)
        return button
    }()
    
    let optionFrame: UIView = {
        let view = UIView()
//        view.backgroundColor = .black
        return view
    }()
    
    let searchOptionButton: UIButton = {
        var button = UIButton()
//            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
//            button.setTitle("필터", for: .normal)
//            button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setImage(UIImage(named: "optionIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
//            button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
//            button.tintColor = .white
//            button.backgroundColor = .white
//            button.layer.cornerRadius = (8)
        button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let searchOptionButton2: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("티어", for: .normal)
        button.setTitleColor(.systemGray3, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
//        button.setImage(UIImage(named: "optionIcon")? .withRenderingMode(.alwaysTemplate), for: .normal)
//            button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
//            button.tintColor = .white
//            button.backgroundColor = .white
        button.layer.cornerRadius = 13
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tierOptionLable1: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("티어", for: .normal)
        button.setTitleColor(.systemGray3, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
//        button.setImage(UIImage(named: "optionIcon")? .withRenderingMode(.alwaysTemplate), for: .normal)
//            button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
//            button.tintColor = .white
//            button.backgroundColor = .white
        button.layer.cornerRadius = 13
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let positionOptionLable1: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("포지션", for: .normal)
        button.setTitleColor(.systemGray3, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
//        button.setImage(UIImage(named: "optionIcon")? .withRenderingMode(.alwaysTemplate), for: .normal)
//            button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
//            button.tintColor = .white
//            button.backgroundColor = .white
        button.layer.cornerRadius = 13
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let emptyViewForOption: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgrgColor5
        return view
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
//        view.backgroundColor = .black
//        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var patryListTable: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        return tableView
    }()
    
//    struct PartyData {
//        let title: String
//        let info: String
//        let time: String
//        let tier: String
//        let position: String
//    }
//
//    var SetPartyRoomData: [PartyData] = []
//
//    let refreshControl = UIRefreshControl()
    
    // 더미 데이터
    let partyTitle = ["매너 파티", "같이 할 사람 구해요", "저녁 8시팀 구함", "즐겜유저 콜", "음주롤 모임"]
    let partyInfo = ["즐겜하실 분 구합니다.", "매너겜 하실 분 구합니다.", "아무나 오세요", "트롤링만 하지 마세요", "아무나 콜"]
    let partyTier = ["#골드", "#플레티넘", "#상관없음", "#마스터", "#실버"]
    let partyPosition = ["#정글", "#서폿", "#상관없음", "#서폿", "#상관없음"]
    
    @objc func createPartybuttonTapped() {
        let CreatePartyVC = CreatePartyVC()
        navigationController?.pushViewController(CreatePartyVC, animated: true)
    }
    
    @objc func noticePagebuttonTapped() {
        let NoticePageVC = NoticePageVC()
        navigationController?.pushViewController(NoticePageVC, animated: true)
    }
    
    @objc func searchOptionButtonTapped() {
        let SearchOptionVC = SearchOptionVC()
        
        SearchOptionVC.modalPresentationStyle = .pageSheet
        present(SearchOptionVC, animated: true, completion: nil)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(pageTitleLabel)
        view.addSubview(noticePagebutton)
        
        view.addSubview(listUnderline)
        view.addSubview(optionFrame)

        optionFrame.addSubview(tierOptionLable1)
        optionFrame.addSubview(positionOptionLable1)
        view.addSubview(contentView)
        contentView.addSubview(patryListTable)
        view.addSubview(createPartybutton)
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            //            $0.leading.equalToSuperview().offset(25)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        
        noticePagebutton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
//            $0.leading.equalTo(createPartybutton.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        createPartybutton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-120)
            $0.trailing.equalToSuperview().offset(-35)
            $0.height.equalTo(60)
            $0.width.equalTo(60)
        }
 
        optionFrame.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(15)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-15)
            //            $0.height.equalTo(40)
        }
        
        tierOptionLable1.snp.makeConstraints {
            $0.top.equalTo(optionFrame.snp.top).offset(5)
            $0.leading.equalTo(optionFrame.snp.leading).offset(10)
            $0.height.equalTo(29)
            $0.width.equalTo(76)
        }
        
        positionOptionLable1.snp.makeConstraints {
            $0.top.equalTo(optionFrame.snp.top).offset(5)
            $0.leading.equalTo(tierOptionLable1.snp.trailing).offset(12)
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(optionFrame.snp.bottom).offset(10)
            $0.bottom.equalTo(view.snp.bottom).offset(-45)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(-0)
        }
        
        patryListTable.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.leading.equalTo(contentView.snp.leading).offset(0)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-0)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
}

extension MainViewController {
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.isHidden = true
        
        PartyManager.shared.loadParty { [weak self] parties in
            self?.partyList = parties // [PartyInfo] = [PartyInfo]
            print("### \(self?.partyList)")
            DispatchQueue.main.async {
                self?.patryListTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupButton()
        
        configureUI()
        
        patryListTable.register(PartyTableViewCell.self, forCellReuseIdentifier: "PartyTableViewCell")
//        self.navigationController?.navigationBar.isHidden = true;
        patryListTable.delegate = self
        patryListTable.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = partyList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as? PartyTableViewCell else { return UITableViewCell() }
        cell.userNameLabel.text = item.userName
        
        StorageManager.shared.getImage("icons", item.profileImage) { image in
            DispatchQueue.main.async {
                cell.profileImage.image = image
                cell.profileImage.layer.masksToBounds = true
            }
        }
        
        StorageManager.shared.getImage("position_w", item.position) { image in
            DispatchQueue.main.async {
                cell.positionImage.image = image
            }
        }
        
        cell.tierLabel.text = item.tier
        cell.tierLabel.textColor = getColorForTier(item.tier)
        
        StorageManager.shared.getImage("position_w", item.hopePosition["first"]!) { image in
            DispatchQueue.main.async {
                cell.firstPositionImage.image = image
            }
        }
        
        StorageManager.shared.getImage("position_w", item.hopePosition["second"]!) { image in
            DispatchQueue.main.async {
                cell.secondPositionImage.image = image
            }
        }
       
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
        // PartyInfoDetailVC 클래스의 초기화 메서드가 옵셔널을 반환하지 않는 경우
        let detailController = PartyInfoDetailVC()
        detailController.party = item
        navigationController?.pushViewController(detailController, animated: true)
    }
}

class PartyTableViewCell: UITableViewCell {
    let cellFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let profileImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 27
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()

    let positionImageFrame: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .gray
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 8.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return view
    }()
    
    let positionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "미드w") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let tierLabelFrame: UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        View.layer.borderColor = UIColor.systemGray3.cgColor
        View.layer.borderWidth = 2
        View.layer.cornerRadius = 13
        return View
    }()
    
    let tierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let positionFrame: UIView = {
        let View = UIView()
        return View
    }()
    
    let fitstRequiredPositionFrame: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemGray4
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 12
        return view
    }()
    
    let firstPositionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "미드w") {
            imageView.image = image
        }
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let secondRequiredPositionFrame: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemGray4
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 12
        return view
    }()
    
    let secondPositionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "미드w") {
            imageView.image = image
        }
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(cellFrameView)
        cellFrameView.addSubview(profileImage)
        cellFrameView.addSubview(positionImageFrame)
        positionImageFrame.addSubview(positionImage)
        
        cellFrameView.addSubview(userNameLabel)
        cellFrameView.addSubview(tierLabelFrame)
        tierLabelFrame.addSubview(tierLabel)
        
        cellFrameView.addSubview(positionFrame)
        
        positionFrame.addSubview(fitstRequiredPositionFrame)
        fitstRequiredPositionFrame.addSubview(firstPositionImage)
        positionFrame.addSubview(secondRequiredPositionFrame)
        secondRequiredPositionFrame.addSubview(secondPositionImage)
        
        cellFrameView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(14)
            $0.leading.equalTo(cellFrameView.snp.leading).offset(16)
            $0.height.width.equalTo(52)
            $0.bottom.equalTo(cellFrameView.snp.bottom).offset(-14)
        }
        
        positionImageFrame.snp.makeConstraints {
            $0.trailing.equalTo(profileImage.snp.trailing).offset(5)
            $0.height.width.equalTo(17)
            $0.bottom.equalTo(profileImage.snp.bottom).offset(0)
        }
        
        positionImage.snp.makeConstraints {
            $0.trailing.equalTo(positionImageFrame.snp.trailing).offset(-2)
            $0.height.width.equalTo(13)
            $0.bottom.equalTo(positionImageFrame.snp.bottom).offset(-2)
        }

        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(14)
            $0.leading.equalTo(profileImage.snp.trailing).offset(18)
        }
        
        tierLabelFrame.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.bottom.equalTo(cellFrameView.snp.bottom).offset(-14)
        }
        
        tierLabel.snp.makeConstraints {
            $0.top.equalTo(tierLabelFrame.snp.top).offset(4)
            $0.leading.equalTo(tierLabelFrame.snp.leading).offset(12)
            $0.trailing.equalTo(tierLabelFrame.snp.trailing).offset(-12)
            $0.bottom.equalTo(tierLabelFrame.snp.bottom).offset(-4)
        }
        
        positionFrame.snp.makeConstraints {
            $0.top.equalTo(tierLabelFrame.snp.top).offset(0)
            $0.height.equalTo(24)
            $0.width.equalTo(76)
            $0.trailing.equalTo(cellFrameView.snp.trailing).offset(-100)
//            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        fitstRequiredPositionFrame.snp.makeConstraints {
            $0.top.equalTo(positionFrame.snp.top).offset(0)
            $0.height.width.equalTo(24)
            $0.leading.equalTo(positionFrame.snp.leading).offset(0)
        }
        
        firstPositionImage.snp.makeConstraints {
            $0.top.equalTo(fitstRequiredPositionFrame.snp.top).offset(3)
            $0.height.width.equalTo(18)
            $0.leading.equalTo(fitstRequiredPositionFrame.snp.leading).offset(3)
        }
        
        secondRequiredPositionFrame.snp.makeConstraints {
            $0.top.equalTo(positionFrame.snp.top).offset(0)
            $0.height.width.equalTo(24)
            $0.leading.equalTo(fitstRequiredPositionFrame.snp.trailing).offset(5)
        }
        
        secondPositionImage.snp.makeConstraints {
            $0.top.equalTo(secondRequiredPositionFrame.snp.top).offset(3)
            $0.height.width.equalTo(18)
            $0.leading.equalTo(secondRequiredPositionFrame.snp.leading).offset(3)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
