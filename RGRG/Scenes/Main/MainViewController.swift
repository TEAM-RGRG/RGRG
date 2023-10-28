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
//        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
//        button.setTitle("파티 만들기", for: .normal)
//        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "PlusInCircle2")?.withRenderingMode(.alwaysTemplate), for: .normal)
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
    
//    let emptyViewForButton: UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        return view
//    }()
    
    let optionFrame: UIView = {
        let view = UIView()
//        view.backgroundColor = .black
        return view
    }()
    
//    let searchOptionLabel: UILabel = {
//        let label = UILabel()
//        label.text = "검색 옵션"
//        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
//        label.textColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
//        return label
//    }()
    
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
//        view.addSubview(buttonFrame)
//        buttonFrame.addArrangedSubview(createPartybutton)
//        buttonFrame.addArrangedSubview(noticePagebutton)
//        buttonFrame.addArrangedSubview(emptyViewForButton)
//        view.addSubview(searchOptionLabel)
        
        //        optionFrame.addArrangedSubview(emptyViewForOption
        
        view.addSubview(listUnderline)
        view.addSubview(optionFrame)
//        optionFrame.addSubview(searchOptionButton)
        optionFrame.addSubview(tierOptionLable1)
        optionFrame.addSubview(positionOptionLable1)
        view.addSubview(contentView)
        contentView.addSubview(patryListTable)
        view.addSubview(createPartybutton)
        //        contentView.addSubview(patryListTable)
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            //            $0.leading.equalToSuperview().offset(25)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        
        // 버튼 스택 프레임
//        buttonFrame.snp.makeConstraints {
//            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(35)
//            $0.height.equalTo(50)
//            $0.leading.equalToSuperview().offset(30)
//            $0.trailing.equalToSuperview().offset(-30)
//            //            $0.height.equalTo(40)
//        }
        
        noticePagebutton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
//            $0.leading.equalTo(createPartybutton.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
//        emptyViewForButton.snp.makeConstraints {
//            $0.leading.equalTo(noticePagebutton.snp.trailing).offset(15)
//            $0.height.equalTo(35)
//            $0.width.equalTo(25)
//        }
        
        createPartybutton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-120)
            $0.trailing.equalToSuperview().offset(-35)
            $0.height.equalTo(60)
            $0.width.equalTo(60)
        }
        
//        listUnderline.snp.makeConstraints {
//            $0.top.equalTo(listTitleLabel.snp.bottom).offset(4)
//            $0.height.equalTo(2)
//            $0.leading.equalTo(view.snp.leading).offset(18)
//            $0.trailing.equalTo(view.snp.trailing).offset(-18)
//        }
        
        optionFrame.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(15)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-15)
            //            $0.height.equalTo(40)
        }
        
//        searchOptionButton.snp.makeConstraints{
//            $0.top.equalTo(optionFrame.snp.top).offset(4)
//            $0.leading.equalTo(optionFrame.snp.leading).offset(8)
//            $0.height.equalTo(28)
//            $0.width.equalTo(28)
//        }
        
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        
        configureUI()
        
        patryListTable.register(PartyTableViewCell.self, forCellReuseIdentifier: "PartyTableViewCell")
        
        
        patryListTable.delegate = self
        patryListTable.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as! PartyTableViewCell
        cell.partyTitleLabel.text = partyTitle[indexPath.row]
        cell.partyInfoLabel.text = partyInfo[indexPath.row]
        cell.partyTierLabel.text = partyTier[indexPath.row]
        cell.partyPositionLabel.text = partyPosition[indexPath.row]
       
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // PartyInfoDetailVC 클래스의 초기화 메서드가 옵셔널을 반환하지 않는 경우
        let detailController = PartyInfoDetailVC()
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
        imageView.layer.cornerRadius = 32
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()

    let partyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let partyInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let partyTierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.backgroundColor = .black
        label.layer.cornerRadius = 20
        return label
    }()
    
    let partyPositionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.backgroundColor = .black
        label.layer.cornerRadius = 20
        return label
    }()
    
    let favoriteChampImageFirstOne: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 17
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()
    
    let favoriteChampImageSecondOne: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 17
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()
    
    let favoriteChampImageThirdOne: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 17
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(cellFrameView)
        cellFrameView.addSubview(profileImage)
        cellFrameView.addSubview(partyTitleLabel)
        cellFrameView.addSubview(partyInfoLabel)
        cellFrameView.addSubview(partyTierLabel)
        cellFrameView.addSubview(partyPositionLabel)
        cellFrameView.addSubview(favoriteChampImageFirstOne)
        cellFrameView.addSubview(favoriteChampImageSecondOne)
        cellFrameView.addSubview(favoriteChampImageThirdOne)
        
        cellFrameView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(10)
            $0.leading.equalTo(cellFrameView.snp.leading).offset(15)
            $0.bottom.equalTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        partyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(15)
        }
        
        partyInfoLabel.snp.makeConstraints {
            $0.top.equalTo(partyTitleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(profileImage.snp.trailing).offset(15)
        }
        
        partyTierLabel.snp.makeConstraints {
            $0.top.equalTo(partyInfoLabel.snp.bottom).offset(7)
            $0.leading.equalTo(profileImage.snp.trailing).offset(15)
            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        partyPositionLabel.snp.makeConstraints {
            $0.top.equalTo(partyInfoLabel.snp.bottom).offset(7)
            $0.leading.equalTo(partyTierLabel.snp.trailing).offset(10)
            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        favoriteChampImageFirstOne.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(15)
            $0.trailing.equalTo(favoriteChampImageSecondOne.snp.leading).offset(-3)
            $0.height.width.equalTo(35)
//            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        favoriteChampImageSecondOne.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(15)
            $0.trailing.equalTo(favoriteChampImageThirdOne.snp.leading).offset(-3)
            $0.height.width.equalTo(35)
//            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        favoriteChampImageThirdOne.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(15)
            $0.trailing.equalTo(cellFrameView.snp.trailing).offset(-15)
            $0.height.width.equalTo(35)
//            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainViewController {
    func setupButton() {
        view.addSubview(testButton)
        testButton.configureButton(title: "TEST", cornerValue: 10, backgroundColor: .systemBlue)
        testButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        testButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
    }

    @objc func tappedButton(_ sender: UIButton) {
        print("### \(#function)")
    }
}
