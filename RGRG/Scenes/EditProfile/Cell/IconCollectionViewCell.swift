//
//  IconCollectionViewCell.swift
//  RGRG
//
//  Created by 이수현 on 10/28/23.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    let iconImage = CustomImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setIconImage()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setIconImage() {
        contentView.addSubview(iconImage)
        iconImage.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
