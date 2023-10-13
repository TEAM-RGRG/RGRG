//
//  ProfileTableViewCell_Profile.swift
//  RGRG
//
//  Created by 이수현 on 10/13/23.
//

import UIKit
import SnapKit

class ProfileCell: UITableViewCell {
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let labelStackView: UIStackView = {
      let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        return stackView
    }()
    
    let profileUserNameLabel = CustomLabel()
    let profileEmailLabel = CustomLabel()
    let editProfileButton = CustomButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ProfileCell {
    func configureCellUI() {
        setProfileImageView()
        setLabelStackView()
        setEditButton()
        
        [profileImage, labelStackView, editProfileButton].forEach({contentView.addSubview($0)})
        
        profileImage.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(26)
            make.height.width.equalTo(93)
        })
        labelStackView.snp.makeConstraints({make in
            make.left.equalTo(profileImage.snp.right).offset(15)
            make.centerY.equalTo(profileImage)
        })
        
        editProfileButton.snp.makeConstraints({make in
            make.top.equalTo(profileImage.snp.bottom).offset(53)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(44)
        })
    }
    
    func setProfileImageView() {
        profileImage.image = UIImage(systemName: "photo")
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    func setLabelStackView() {
        [profileUserNameLabel, profileEmailLabel].forEach({labelStackView.addArrangedSubview($0)})
        
        profileUserNameLabel.text = "유저 이름"
        profileEmailLabel.text = "xxxxxxxx@xxxxx.xxx"
    }
    
    func setEditButton() {
        editProfileButton.configureButton(title: "프로필 수정", cornerValue: 3, backgroundColor: .rgrgColor1)
    }
}
