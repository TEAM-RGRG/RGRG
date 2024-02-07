//
//  UesrInfoCell.swift
//  RGRG
//
//  Created by 준우의 MacBook 16 on 11/20/23.
//

import UIKit

#warning("UI 코드 중복 제거 및 공용 컴포넌트 활용할 것")
class UserInfoCell: UITableViewCell {
    // TODO: 공용 컴포넌트 작업
    let cellFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // TODO: 공용 컴포넌트 작업
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
    
    // TODO: 공용 컴포넌트 작업
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
    
    // TODO: 공용 컴포넌트 작업
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

    // TODO: 공용 컴포넌트 작업
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // TODO: 공용 컴포넌트 작업
    let tierLabelFrame: UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        View.layer.borderColor = UIColor.systemGray2.cgColor
        View.layer.borderWidth = 2
        View.layer.cornerRadius = 13
        return View
    }()
    
    // TODO: 공용 컴포넌트 작업
    let tierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    // TODO: 공용 컴포넌트 작업
    let mostChampionFrame: UIView = {
        let View = UIView()
        return View
    }()
    
    // TODO: 공용 컴포넌트 작업
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
    
    // TODO: 공용 컴포넌트 작업
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
    
    // TODO: 공용 컴포넌트 작업
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
    
    // TODO: 공용 컴포넌트 작업
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
        
        contentView.backgroundColor = .rgrgColor5
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserInfoCell {
    func setupUI() {
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
        }
    }
}
