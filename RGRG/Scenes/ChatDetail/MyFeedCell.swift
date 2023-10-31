//
//  MyFeedCell.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/17/23.
//

import SnapKit
import UIKit

class MyFeedCell: UITableViewCell {
    static let identifier = "MyFeedCell"

    lazy var baseView = UIView(frame: .zero)
    lazy var emptyView = UIView(frame: .zero)
    lazy var myChatContent = CustomLabel(frame: .zero)
    lazy var myChatTime = CustomLabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyFeedCell {
    func setupUI() {
        confirmBaseView()
        confirmMyChatContent()
        confirmMyChatTime()
    }
}

extension MyFeedCell {
    func confirmBaseView() {
        contentView.addSubview(baseView)
        baseView.addSubview(myChatContent)
        contentView.addSubview(myChatTime)

        baseView.backgroundColor = UIColor(hex: "#279EFF")
        baseView.roundCorners(topLeft: 10, topRight: 10, bottomLeft: 10, bottomRight: 2)

        let borderLayer = CAShapeLayer()
        borderLayer.path = (baseView.layer.mask! as! CAShapeLayer).path! // Reuse the Bezier path
        borderLayer.strokeColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1
        borderLayer.frame = baseView.bounds
        baseView.layer.addSublayer(borderLayer)

        baseView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.trailing.equalTo(contentView).offset(-12)
            make.bottom.equalTo(contentView).offset(-8)
        }
    }

    func confirmMyChatContent() {
        myChatContent.numberOfLines = 0
        myChatContent.textAlignment = .natural
        myChatContent.font = UIFont(name: AppFontName.regular, size: 16)
        myChatContent.textColor = UIColor(hex: "#FFFFFF")

        myChatContent.snp.makeConstraints { make in
            make.top.equalTo(baseView).offset(4)
            make.bottom.equalTo(baseView).offset(-4)
            make.leading.equalTo(baseView).offset(10)
            make.trailing.equalTo(baseView).offset(-10)
            make.height.greaterThanOrEqualTo(34)
            make.width.lessThanOrEqualTo(208)
        }
    }

    func confirmMyChatTime() {
        myChatTime.font = UIFont(name: "Roboto-Regular", size: 12)

        myChatTime.snp.makeConstraints { make in
            make.trailing.equalTo(baseView.snp.leading).offset(-4)
            make.bottom.equalTo(baseView)
            make.height.equalTo(16)
            make.width.greaterThanOrEqualTo(43)
        }
    }
}
