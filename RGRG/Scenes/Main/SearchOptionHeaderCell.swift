//
//  SearchOptionHeaderCell.swift
//  RGRG
//
//  Created by t2023-m0064 on 11/2/23.
//

import Foundation
import UIKit
import SnapKit

class HeaderView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "콜렉션뷰 헤더"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
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
        backgroundColor = .systemGray5

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.top.bottom.equalToSuperview().inset(5)
        }
    }
}
