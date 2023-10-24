//
//  ProfileTableViewCell_Profile.swift
//  RGRG
//
//  Created by 이수현 on 10/13/23.
//

import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import SnapKit
import UIKit

protocol ProfileCellDelegate: ProfileViewController {
    func editProfileButtonPressed()
}

class ProfileCell: UITableViewCell {
    weak var delegate: ProfileCellDelegate?

    let sampleUserName = "sampleUser"
    let sampleEmail = "xxxxxxxx@xxxxx.xxx"

    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.frame = CGRect(x: 0, y: 0, width: 93, height: 93)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1.3
        imageView.layer.cornerRadius = imageView.frame.height / 2
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
        setLabelStackView()
        setEditButton()

        [profileImage, labelStackView, editProfileButton].forEach { contentView.addSubview($0) }

        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(26)
            make.height.width.equalTo(93)
        }
        labelStackView.snp.makeConstraints { make in
            make.left.equalTo(profileImage.snp.right).offset(15)
            make.centerY.equalTo(profileImage)
        }

        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(53)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }

    func setLabelStackView() {
        [profileUserNameLabel, profileEmailLabel].forEach { labelStackView.addArrangedSubview($0) }

        profileUserNameLabel.text = sampleUserName
        profileEmailLabel.text = sampleEmail
    }

    func setEditButton() {
        editProfileButton.configureButton(title: "프로필 수정", cornerValue: 3, backgroundColor: .RGRGColor1!)
        editProfileButton.addTarget(self, action: #selector(editProfileButtonPressed(_:)), for: .touchUpInside)
    }

    @objc func editProfileButtonPressed(_ sender: UIButton) {
        delegate?.editProfileButtonPressed()
    }
}
