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
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.textColor = UIColor.RGRGColor2
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
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitle("파티 만들기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.RGRGColor2
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createPartybuttonTapped), for: .touchUpInside)
        return button
    }()
    
    let noticePagebutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.RGRGColor2
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(noticePagebuttonTapped), for: .touchUpInside)
        return button
    }()
    
    let emptyViewForButton: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let optionFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let searchOptionLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 옵션"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = UIColor.RGRGColor2
        return label
    }()
    
        let searchOptionButton: UIButton = {
            var button = UIButton()
//            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
//            button.setTitle("필터", for: .normal)
//            button.setTitleColor(.black, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.adjustsFontForContentSizeCategory = true
            button.setImage(UIImage(named: "optionIcon")? .withRenderingMode(.alwaysTemplate), for: .normal)
            button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
            button.tintColor = UIColor.white
//            button.backgroundColor = .white
//            button.layer.cornerRadius = (8)
            button.addTarget(self, action: #selector(searchOptionButtonTapped), for: .touchUpInside)
            return button
        }()
    
    let timeOptionLable1: UILabel = {
        let label = UILabel()
        label.text = "#시간"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
//        label.backgroundColor = UIColor.RGRGColor2
        label.clipsToBounds = true
        label.layer.cornerRadius = 11
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.RGRGColor2?.cgColor
        return label
    }()
    
    let tierOptionLable1: UILabel = {
        let label = UILabel()
        label.text = "#티어"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
//        label.backgroundColor = UIColor.RGRGColor2
        label.clipsToBounds = true
        label.layer.cornerRadius = 11
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.RGRGColor2?.cgColor
        return label
    }()
    
    let positionOptionLable1: UILabel = {
        let label = UILabel()
        label.text = "#포지션"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
//        label.backgroundColor = UIColor.RGRGColor2
        label.clipsToBounds = true
        label.layer.cornerRadius = 11
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.RGRGColor2?.cgColor
        return label
    }()
    
    let emptyViewForOption: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.RGRGColor5
        return view
    }()
    
    let listUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.RGRGColor2
        return view
    }()
    
    let listTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "파티 목록"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = UIColor.RGRGColor2
        return label
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var patryListTable: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
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
    let partyTime = ["#8:00~11:00", "#8:00~11:00", "#8:00~11:00", "#11:00~01:00", "#10:00~12:00"]
    let partyTier = ["#골드", "#플레티넘", "#상관없음", "#마스터", "#실버"]
    let partyPosition = ["#정글", "#서폿", "#상관없음", "#서폿", "#상관없음"]
    
    
    @objc func createPartybuttonTapped() {
        let CreatePartyVC = CreatePartyVC()
        
        CreatePartyVC.modalPresentationStyle = .fullScreen
        present(CreatePartyVC, animated: true, completion: nil)
    }
    
    @objc func noticePagebuttonTapped() {
        let NoticePageVC = NoticePageVC()
        
        NoticePageVC.modalPresentationStyle = .fullScreen
        present(NoticePageVC, animated: true, completion: nil)
    }
    
    @objc func searchOptionButtonTapped() {
        let SearchOptionVC = SearchOptionVC()
        
        SearchOptionVC.modalPresentationStyle = .pageSheet
        present(SearchOptionVC, animated: true, completion: nil)
    }
    
    func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(pageTitleLabel)
        view.addSubview(buttonFrame)
        buttonFrame.addArrangedSubview(createPartybutton)
        buttonFrame.addArrangedSubview(noticePagebutton)
//        buttonFrame.addArrangedSubview(emptyViewForButton)
        view.addSubview(searchOptionLabel)
        
        
        
        //        optionFrame.addArrangedSubview(emptyViewForOption)
        view.addSubview(listTitleLabel)
        view.addSubview(searchOptionButton)
        view.addSubview(listUnderline)
        view.addSubview(optionFrame)
        optionFrame.addSubview(timeOptionLable1)
        optionFrame.addSubview(tierOptionLable1)
        optionFrame.addSubview(positionOptionLable1)
        view.addSubview(contentView)
        contentView.addSubview(patryListTable)
        //        contentView.addSubview(patryListTable)
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            //            $0.leading.equalToSuperview().offset(25)
            $0.centerX.equalTo(view)
        }
        
        // 버튼 스택 프레임
        buttonFrame.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(35)
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            //            $0.height.equalTo(40)
        }
        
        createPartybutton.snp.makeConstraints {
            //            $0.top.equalTo(buttonFrame.snp.top).offset(10)
            //            $0.leading.equalTo(buttonFrame.snp.leading).offset(15)
            $0.height.equalTo(50)
            $0.width.equalTo(70)
        }
        
        noticePagebutton.snp.makeConstraints {
            //            $0.top.equalTo(buttonFrame.snp.top).offset(10)
            $0.leading.equalTo(createPartybutton.snp.trailing).offset(15)
            $0.trailing.equalTo(buttonFrame.snp.leading).offset(-10)
            $0.height.equalTo(50)
            $0.width.equalTo(70)
        }
        
//        emptyViewForButton.snp.makeConstraints {
//            $0.leading.equalTo(noticePagebutton.snp.trailing).offset(15)
//            $0.height.equalTo(35)
//            $0.width.equalTo(25)
//        }
        
        listTitleLabel.snp.makeConstraints {
            $0.top.equalTo(buttonFrame.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(15)
        }
        
        searchOptionButton.snp.makeConstraints{
            $0.top.equalTo(buttonFrame.snp.bottom).offset(29)
            $0.leading.equalTo(listTitleLabel.snp.trailing).offset(10)
            $0.height.equalTo(28)
            $0.width.equalTo(28)
        }
        
        listUnderline.snp.makeConstraints {
            $0.top.equalTo(listTitleLabel.snp.bottom).offset(4)
            $0.height.equalTo(2)
            $0.leading.equalTo(view.snp.leading).offset(18)
            $0.trailing.equalTo(view.snp.trailing).offset(-18)
        }
        
        optionFrame.snp.makeConstraints {
            $0.top.equalTo(listUnderline.snp.bottom).offset(5)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            //            $0.height.equalTo(40)
        }
        
        timeOptionLable1.snp.makeConstraints {
            $0.top.equalTo(optionFrame.snp.top).offset(5)
            $0.leading.equalTo(optionFrame.snp.leading).offset(9)
            $0.height.equalTo(22)
            $0.width.equalTo(70)
        }
        
        tierOptionLable1.snp.makeConstraints {
            $0.top.equalTo(optionFrame.snp.top).offset(5)
            $0.leading.equalTo(timeOptionLable1.snp.trailing).offset(9)
            $0.height.equalTo(22)
            $0.width.equalTo(70)
        }
        
        positionOptionLable1.snp.makeConstraints {
            $0.top.equalTo(optionFrame.snp.top).offset(5)
            $0.leading.equalTo(tierOptionLable1.snp.trailing).offset(9)
            $0.height.equalTo(22)
            $0.width.equalTo(70)
        }
        
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(optionFrame.snp.bottom).offset(10)
            $0.bottom.equalTo(view.snp.bottom).offset(-45)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            //            $0.height.equalTo(40)
        }
        
        patryListTable.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
    
    
    
    
    
    
}

extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        cell.partyTimeLabel.text = partyTime[indexPath.row]
        cell.partyTierLabel.text = partyTier[indexPath.row]
        cell.partyPositionLabel.text = partyPosition[indexPath.row]
       
        cell.selectionStyle = .none
        
        return cell
    }
}




class PartyTableViewCell: UITableViewCell {
    
    let cellFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.RGRGColor5
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
        imageView.layer.cornerRadius = 30
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()

    
    let partyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let partyInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let partyTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.backgroundColor = .black
        label.layer.cornerRadius = 20
        return label
    }()
    
    let partyTierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.backgroundColor = .black
        label.layer.cornerRadius = 20
        return label
    }()
    
    let partyPositionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.backgroundColor = .black
        label.layer.cornerRadius = 20
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        
        contentView.addSubview(cellFrameView)
        cellFrameView.addSubview(profileImage)
        cellFrameView.addSubview(partyTitleLabel)
        cellFrameView.addSubview(partyInfoLabel)
        cellFrameView.addSubview(partyTimeLabel)
        cellFrameView.addSubview(partyTierLabel)
        cellFrameView.addSubview(partyPositionLabel)
        
        
        cellFrameView.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        
        profileImage.snp.makeConstraints{
            $0.top.equalTo(cellFrameView.snp.top).offset(10)
            $0.leading.equalTo(cellFrameView.snp.leading).offset(10)
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
        
        partyTimeLabel.snp.makeConstraints {
            $0.top.equalTo(partyInfoLabel.snp.bottom).offset(7)
            $0.leading.equalTo(profileImage.snp.trailing).offset(15)
            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        partyTierLabel.snp.makeConstraints {
            $0.top.equalTo(partyInfoLabel.snp.bottom).offset(7)
            $0.leading.equalTo(partyTimeLabel.snp.trailing).offset(10)
            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        partyPositionLabel.snp.makeConstraints {
            $0.top.equalTo(partyInfoLabel.snp.bottom).offset(7)
            $0.leading.equalTo(partyTierLabel.snp.trailing).offset(10)
            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
    }
    
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

