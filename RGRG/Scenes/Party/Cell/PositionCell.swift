//
//  PositionCell.swift
//  RGRG
//
//  Created by 이수현 on 11/7/23.
//

import UIKit

final class PositionCell: UICollectionViewCell {
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

    let positionLabel = CustomLabel(frame: .zero)
    let positionImage = CustomImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUP UI

extension PositionCell {
    private func setupUI() {
        contentView.backgroundColor = .clear
        addView()
        createCellFrameView()
        createPositionFrame()
        createPositionLabel()
        createPositionImage()
    }

    private func addView() {
        contentView.addSubview(cellFrameView)
        cellFrameView.addSubview(positionFrame)
        positionFrame.addSubview(positionLabel)
        positionFrame.addSubview(positionImage)
    }
}

// MARK: - Create Components And Make Constraints

extension PositionCell {
    private func createCellFrameView() {
        cellFrameView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
    }

    private func createPositionFrame() {
        positionFrame.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(85)
            $0.top.equalTo(cellFrameView.snp.top).offset(0)
        }
    }

    private func createPositionLabel() {
        positionLabel.font = UIFont.myBoldSystemFont(ofSize: 15)
        positionLabel.textColor = .rgrgColor7
        positionLabel.textAlignment = .center

        positionLabel.snp.makeConstraints {
            $0.top.equalTo(positionFrame.snp.top).offset(2)
            $0.leading.equalTo(positionFrame.snp.leading).offset(19)
        }
    }

    private func createPositionImage() {
        positionImage.tintColor = .rgrgColor7
        positionImage.contentMode = .scaleToFill

        positionImage.snp.makeConstraints {
            $0.top.equalTo(positionFrame.snp.top).offset(2)
            $0.height.width.equalTo(20)
            $0.leading.equalTo(positionLabel.snp.trailing).offset(3)
        }
    }
}
