//
//  ChampionCell.swift
//  RGRG
//
//  Created by 이수현 on 11/6/23.
//

import UIKit

#warning("UI 코드 중복 제거 및 공용 컴포넌트 사용할 것")
class ChampionCell: UICollectionViewCell {
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

//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                layer.borderColor = UIColor.rgrgColor3.cgColor
//                layer.borderWidth = 3
//                if ChooseChampViewController.selectedChamp.count < 3 {
//                    guard let superView = superview as? UICollectionView else {
//                        print("superview is not a UICollectionView - getIndexPath")
//                        return
//                    }
//                    let indexPath = superView.indexPath(for: self)
//                    ChooseChampViewController.selectedChamp.append(ChooseChampViewController.champName[indexPath?.row ?? 0])
//                    print("~~~~~~~~~~~~~~~~~~~~~~~\(ChooseChampViewController.selectedChamp)")
//                }
//                if ChooseChampViewController.selectedChamp.count == 3 {
//                    isSelected = false
//                }
//            } else {
//                layer.borderColor = UIColor.clear.cgColor
//                layer.borderWidth = 3
//            }
//        }
//    }
}
