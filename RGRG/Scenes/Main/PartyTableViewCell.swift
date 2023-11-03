//
//  PartyTableViewCell.swift
//  RGRG
//
//  Created by t2023-m0064 on 10/31/23.
//

import Foundation
import SnapKit
import UIKit


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
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 26
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
        View.layer.borderWidth = 1
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
        
        contentView.backgroundColor = .rgrgColor5
        
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
            $0.top.equalTo(contentView.snp.top).offset(6)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-6)
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
            $0.width.equalTo(130)
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
            $0.leading.equalTo(tierLabelFrame.snp.trailing).offset(10)
//            $0.trailing.equalTo(cellFrameView.snp.trailing).offset(-100)
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
