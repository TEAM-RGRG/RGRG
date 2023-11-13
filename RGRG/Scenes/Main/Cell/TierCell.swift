//
//  TierCell.swift
//  RGRG
//
//  Created by 이수현 on 11/7/23.
//

import UIKit

class TierCell: UICollectionViewCell {
    let cellFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()

    let tierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myBoldSystemFont(ofSize: 15)
        label.textColor = .rgrgColor6
        label.layer.cornerRadius = 12
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.rgrgColor6.cgColor
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .clear

        contentView.addSubview(cellFrameView)
        cellFrameView.addSubview(tierLabel)

        cellFrameView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }

        tierLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(85)
            $0.top.equalTo(cellFrameView.snp.top).offset(0)
        }
    }
}
