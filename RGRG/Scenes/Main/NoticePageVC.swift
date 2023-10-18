//
//  NoticePageVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/18.
//

import Foundation
import SnapKit
import UIKit



class NoticePageVC: UIViewController {
    
    let pageTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "RGRG"
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.textColor = UIColor.RGRGColor2
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.RGRGColor2, for: .normal)
//        button.backgroundColor = UIColor.RGRGColor2
//        button.layer.cornerRadius = (10)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 목록"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.RGRGColor2
        return label
    }()
    
    let listUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.RGRGColor2
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
//        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var noticeListTable: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
   

    
    let neckName = ["스오나서스", "탑농사잘됨", "5시퇴근", "칼서렌즐", "아잘못눌럿다"]
    
    let intro = ["즐겜하실 분 구합니다.", "매너겜 하실 분 구합니다.", "아무나 오세요", "트롤링만 하지 마세요", "아무나 콜"]
    
    let mainPlayTime = ["#8:00~11:00", "#8:00~11:00", "#8:00~11:00", "#11:00~01:00", "#10:00~12:00"]
    
    let partyTier = ["#골드", "#플레티넘", "#상관없음", "#마스터", "#실버"]
    
    let partyPosition = ["#정글", "#서폿", "#상관없음", "#서폿", "#상관없음"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
        
        noticeListTable.register(userInfoCell.self, forCellReuseIdentifier: "userInfoCell")
        noticeListTable.delegate = self
        noticeListTable.dataSource = self
    }
    
    
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        
        // ToDoListPageViewController 대신 해당 페이지의 루트 뷰 컨트롤러로 감싸진 내비게이션 컨트롤러를 만듭니다.
//        let ViewController = ViewController() // ToDoListPageViewController의 인스턴스 생성
//        let navigationController = UINavigationController(rootViewController: ViewController)
//
//        navigationController.modalPresentationStyle = .fullScreen
//        present(navigationController, animated: true, completion: nil) // 내비게이션 컨트롤러를 표시
    }
    
    
    
    
    func configureUI() {
        view.backgroundColor = .black
        
        
        view.addSubview(pageTitleLabel)
        view.addSubview(backButton)
        view.addSubview(noticeLabel)
        view.addSubview(listUnderline)
        view.addSubview(contentView)
        contentView.addSubview(noticeListTable)
        
        
        
        pageTitleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.leading.equalToSuperview().offset(25)
            $0.centerX.equalTo(view)
        }
        
        backButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(25)
//            $0.trailing.equalTo(pageTitleLabel.snp.leading).offset(-25)
//            $0.height.equalTo(40)
        }
        
        
        noticeLabel.snp.makeConstraints{
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(14)
        }
        
        listUnderline.snp.makeConstraints{
            $0.top.equalTo(noticeLabel.snp.bottom).offset(10)
            $0.height.equalTo(2)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        contentView.snp.makeConstraints{
            $0.top.equalTo(listUnderline.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-50)
//            $0.height.equalTo(200)
//            $0.width.equalTo(80)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            
        }
        
        noticeListTable.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
}
    
extension NoticePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neckName.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! userInfoCell
        cell.neckNameLabel.text = neckName[indexPath.row]
        cell.introLabel.text = intro[indexPath.row]
        cell.partyTimeLabel.text = mainPlayTime[indexPath.row]
        cell.partyTierLabel.text = partyTier[indexPath.row]
        cell.partyPositionLabel.text = partyPosition[indexPath.row]
       
        cell.selectionStyle = .none
        
        return cell
    }
}




class userInfoCell: UITableViewCell {
    
    let cellFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.RGRGColor5
        view.layer.cornerRadius = 10
        return view
    }()
    
    let profileFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let profileImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return imageView
    }()

    
    let neckNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    let introLabel: UILabel = {
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
    
    let acceptRequestButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitle("수락", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 45
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.RGRGColor2?.cgColor
//        button.addTarget(self, action: #selector(createPartybuttonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        
        contentView.addSubview(cellFrameView)
//        cellFrameView.addSubview(profileFrame)
        cellFrameView.addSubview(profileImage)
        cellFrameView.addSubview(neckNameLabel)
        cellFrameView.addSubview(introLabel)
        cellFrameView.addSubview(partyTimeLabel)
        cellFrameView.addSubview(partyTierLabel)
        cellFrameView.addSubview(partyPositionLabel)
        cellFrameView.addSubview(acceptRequestButton)
        
        
        cellFrameView.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        
        
//        profileFrame.snp.makeConstraints{
//            $0.top.leading.bottom.equalTo(cellFrameView.snp.top).offset(0)
//        }
        
        profileImage.snp.makeConstraints{
            $0.top.equalTo(cellFrameView.snp.top).offset(10)
            $0.leading.equalTo(cellFrameView.snp.leading).offset(10)
        }
        
        neckNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(7)
            $0.leading.equalTo(cellFrameView.snp.leading).offset(5)
            $0.trailing.equalTo(introLabel.snp.leading).offset(-5)
            $0.bottom.equalTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        introLabel.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(25)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        partyTimeLabel.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(15)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        partyTierLabel.snp.makeConstraints {
            $0.top.equalTo(partyTimeLabel.snp.bottom).offset(15)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        partyPositionLabel.snp.makeConstraints {
            $0.top.equalTo(partyTimeLabel.snp.bottom).offset(15)
            $0.leading.equalTo(partyTierLabel.snp.trailing).offset(10)
            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        acceptRequestButton.snp.makeConstraints{
            $0.top.equalTo(cellFrameView.snp.top).offset(10)
            $0.trailing.bottom.equalTo(cellFrameView).offset(-10)
            $0.width.equalTo(90)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

