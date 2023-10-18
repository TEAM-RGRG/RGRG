//
//  ProfileSettingCell.swift
//  RGRG
//
//  Created by 이수현 on 10/13/23.
//

import UIKit

class ProfileSettingCell: UITableViewCell {
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let cellLabel = CustomLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileSettingCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ProfileSettingCell {
    func configureCellUI() {
        setIconImageView()
        
        cellLabel.text = "환경 설정"
        cellLabel.font = .systemFont(ofSize: 17)
        iconImageView.image = UIImage(systemName: "gearshape")
        
        [iconImageView, cellLabel].forEach({contentView.addSubview($0)})
        iconImageView.snp.makeConstraints({make in
            make.left.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        })
        
        cellLabel.snp.makeConstraints({make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(19)
        })
        
    }
    
    func setIconImageView() {
        
    }
    
}

