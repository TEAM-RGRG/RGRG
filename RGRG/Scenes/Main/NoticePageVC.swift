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
    let topFrame: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.addBottomBorder(color: UIColor.black, width: 2.0)
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var noticeListTable: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let userName = ["페이커쨩", "탑농부", "5시퇴근", "칼서렌즐", "아잘못눌럿다"]
    
    let tier = ["Iron", "Silver", "Gold", "Platinum", "Bronze"]
    
    let mainPlayTime = ["#8:00~11:00", "#8:00~11:00", "#8:00~11:00", "#11:00~01:00", "#10:00~12:00"]
    
    let partyTier = ["#골드", "#플레티넘", "#상관없음", "#마스터", "#실버"]
    
    let partyPosition = ["#정글", "#서폿", "#상관없음", "#서폿", "#상관없음"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.isHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
 title = "알림"
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        configureUI()
        
        noticeListTable.register(userInfoCell.self, forCellReuseIdentifier: "userInfoCell")
        noticeListTable.delegate = self
        noticeListTable.dataSource = self
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(topFrame)
//        topFrame.addSubview(pageTitleLabel)
//        topFrame.addSubview(backButton)
        view.addSubview(contentView)
        contentView.addSubview(noticeListTable)
        
        
        
        
        // 커스텀 백버튼 추가
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
//        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
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
}
    
extension NoticePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! userInfoCell
        cell.userNameLabel.text = userName[indexPath.row]
        cell.tierLabel.text = tier[indexPath.row]
//        cell.partyTimeLabel.text = mainPlayTime[indexPath.row]
//        cell.partyTierLabel.text = partyTier[indexPath.row]
//        cell.partyPositionLabel.text = partyPosition[indexPath.row]
       
        cell.selectionStyle = .none
        
        return cell
    }
}

extension CALayer {
    func addBottomBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: bounds.height - width, width: bounds.width, height: width)
        addSublayer(border)
    }
}

class userInfoCell: UITableViewCell {
    let cellFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 6
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 26
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
        View.layer.borderColor = UIColor.systemGray2.cgColor
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

    let mostChampionFrame: UIView = {
        let View = UIView()
        return View
    }()
    
    let firstMostChampionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return imageView
    }()
    
    let secondMostChampionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return imageView
    }()
    
    let thirdMostChampionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return imageView
    }()
    
    let acceptRequestButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("수락", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1.0)
        button.layer.cornerRadius = 18
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 2
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray5
        
        contentView.addSubview(cellFrameView)
        cellFrameView.addSubview(profileImage)
        cellFrameView.addSubview(positionImageFrame)
        positionImageFrame.addSubview(positionImage)
        
        cellFrameView.addSubview(userNameLabel)
        cellFrameView.addSubview(tierLabelFrame)
        tierLabelFrame.addSubview(tierLabel)
        cellFrameView.addSubview(mostChampionFrame)
        
        mostChampionFrame.addSubview(firstMostChampionImage)
        mostChampionFrame.addSubview(secondMostChampionImage)
        mostChampionFrame.addSubview(thirdMostChampionImage)
        
        cellFrameView.addSubview(acceptRequestButton)
        
        cellFrameView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
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
        
        mostChampionFrame.snp.makeConstraints {
            $0.top.equalTo(tierLabelFrame.snp.top).offset(0)
            $0.height.equalTo(24)
            $0.width.equalTo(76)
            $0.trailing.equalTo(cellFrameView.snp.trailing).offset(-100)
//            $0.bottom.lessThanOrEqualTo(cellFrameView.snp.bottom).offset(-10)
        }
        
        firstMostChampionImage.snp.makeConstraints {
            $0.top.equalTo(mostChampionFrame.snp.top).offset(0)
            $0.height.width.equalTo(24)
            $0.leading.equalTo(mostChampionFrame.snp.leading).offset(0)
        }
        
        secondMostChampionImage.snp.makeConstraints {
            $0.top.equalTo(mostChampionFrame.snp.top).offset(0)
            $0.height.width.equalTo(24)
            $0.leading.equalTo(firstMostChampionImage.snp.trailing).offset(2)
        }
        
        thirdMostChampionImage.snp.makeConstraints {
            $0.top.equalTo(mostChampionFrame.snp.top).offset(0)
            $0.height.width.equalTo(24)
            $0.leading.equalTo(secondMostChampionImage.snp.trailing).offset(2)
        }
        
        acceptRequestButton.snp.makeConstraints {
            $0.top.equalTo(cellFrameView.snp.top).offset(22)
            $0.trailing.equalTo(cellFrameView.snp.trailing).offset(-13)
            $0.bottom.equalTo(cellFrameView.snp.bottom).offset(-22)
            $0.width.equalTo(73)
//            $0.width.equalTo(90)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
