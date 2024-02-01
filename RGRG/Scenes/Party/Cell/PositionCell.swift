//
//  PositionCell.swift
//  RGRG
//
//  Created by 이수현 on 11/7/23.
//
import UIKit

#warning("UI 코드 중복 제거 및 공용 컴포넌트 활용할 것")
class PositionCell: UICollectionViewCell {
    let cellFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()

    let positionFrame: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.rgrgColor6.cgColor
        return view
    }()

    let positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myBoldSystemFont(ofSize: 15)
        label.textColor = .rgrgColor7
        label.textAlignment = .center
        return label
    }()

    let positionImage: UIImageView = {
        var imageView = UIImageView()
        imageView.tintColor = .rgrgColor7
        imageView.contentMode = .scaleToFill
        return imageView
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
        cellFrameView.addSubview(positionFrame)
        positionFrame.addSubview(positionLabel)
        positionFrame.addSubview(positionImage)

        cellFrameView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }

        positionFrame.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(85)
            $0.top.equalTo(cellFrameView.snp.top).offset(0)
        }

        positionLabel.snp.makeConstraints {
            $0.top.equalTo(positionFrame.snp.top).offset(2)
            $0.leading.equalTo(positionFrame.snp.leading).offset(19)
        }

        positionImage.snp.makeConstraints {
            $0.top.equalTo(positionFrame.snp.top).offset(2)
            $0.height.width.equalTo(20)
            $0.leading.equalTo(positionLabel.snp.trailing).offset(3)
        }
    }
}
