//
//  SearchOptionVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/18.
//

import SnapKit
import UIKit

class SearchOptionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 

    let contentView: UIView = {
        let view = UIView()
        return view
    }()

    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.setTitle("선택 완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        return button
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()

    let upperSectionItemCount = 7 // 윗쪽 섹션의 항목 개수
    let lowerSectionItemCount = 5 // 아랫쪽 섹션의 항목 개수

    let tierName = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond"]
    let positionName = ["Top", "Jug", "Mid", "Sup", "Bot"]
    
    var selectedTierIndexPath: IndexPath?
    var selectedSection: Int?
    
    var selectedPositionIndexPath: IndexPath?
    var positionSelectedSection: Int?

    
    
// MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(PositionCell.self, forCellWithReuseIdentifier: "PositionCell")
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = createCompositionalLayout()

    }

    override func viewWillAppear(_ animated: Bool) {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [
                .custom { _ in
                    360
                }
            ]
        }
    }

    func configureUI() {
        view.backgroundColor = .white

        view.addSubview(contentView)
        contentView.addSubview(collectionView)
        view.addSubview(confirmationButton)

        contentView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().offset(0)
            $0.bottom.equalTo(confirmationButton.snp.top).offset(-20)
        }

        collectionView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.top.equalTo(contentView.snp.top).offset(0)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-10)
            $0.bottom.equalTo(contentView.snp.bottom).offset(0)
        }

        confirmationButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(41)
            $0.trailing.equalToSuperview().offset(-41)
            $0.height.equalTo(46)
            $0.centerX.equalTo(view)
        }
    }

    
    
    
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
            // 코포지셔널 레이아웃 생성
            let layout = UICollectionViewCompositionalLayout{

                // 만들게 되면 튜플형태로 들어옴
                (sectionInedex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) ->
                NSCollectionLayoutSection? in

                // 아이템에 대한 사이즈 - absolute 는 고정값, estimate 는 추측, fraction 은 퍼센트
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.2), heightDimension: .absolute(35))

                // 위에서 만든 아이템 사이즈로 아이템 만들기
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // 아이템 간격설정
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)


                // 그룹 사이즈
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)

                // 그룹 사이즈로 그룹 만들기
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)

                // 그룹으로 섹션 만들기
                let section = NSCollectionLayoutSection(group: group)


                // 섹션에 대한 간격
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)


                return section
            }
            return layout
        }

    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    // 각 섹션당 항목 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return upperSectionItemCount
        } else {
            return lowerSectionItemCount
        }
    }

    // 헤더 뷰 구현
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            if indexPath.section == 0 {
                headerView.titleLabel.text = "윗쪽 섹션 헤더"
            } else {
                headerView.titleLabel.text = "아랫쪽 섹션 헤더"
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    
    
 
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 { // 윗쪽 섹션
            // 이전에 선택한 셀이 있다면 선택 해제
            if let previousIndexPath = selectedTierIndexPath {
                if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? CollectionViewCell {
                    previousCell.tierLabel.layer.borderColor = UIColor.systemGray4.cgColor
                }

            }

            // 선택한 셀의 indexPath 저장
            selectedTierIndexPath = indexPath

            // 선택한 셀의 스타일 변경
            if let selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                selectedCell.tierLabel.layer.borderColor = UIColor.systemBlue.cgColor
            }

        } else { // 아랫쪽 섹션
            // 이전에 선택한 셀이 있다면 선택 해제
            if let previousIndexPath = selectedPositionIndexPath {
                if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? PositionCell {
                    previousCell.positionFrame.layer.borderColor = UIColor.systemGray4.cgColor
                }

            }

            // 선택한 셀의 indexPath 저장
            selectedPositionIndexPath = indexPath

            // 선택한 셀의 스타일 변경
            if let selectedCell = collectionView.cellForItem(at: indexPath) as? PositionCell {
                selectedCell.positionFrame.layer.borderColor = UIColor.systemBlue.cgColor
            }
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let cellWidth = collectionView.bounds.width / CGFloat(5)
           let cellHeight = collectionView.bounds.height / CGFloat(10)
           return CGSize(width: cellWidth, height: cellHeight)
       }

    
 

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.tierLabel.text = tierName[indexPath.row]
            
            if let tierText = cell.tierLabel.text {
                       switch tierText {
                       case "Iron":
                           cell.tierLabel.textColor = .iron
                       case "Bronze":
                           cell.tierLabel.textColor = .bronze
                       case "Silver":
                           cell.tierLabel.textColor = .silver
                       case "Gold":
                           cell.tierLabel.textColor = .gold
                       case "Platinum":
                           cell.tierLabel.textColor = .platinum
                       case "Emerald":
                           cell.tierLabel.textColor = .emerald
                       case "Diamond":
                           cell.tierLabel.textColor = .diamond
                       default:
                           cell.tierLabel.textColor = .black
                       }
                   }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PositionCell", for: indexPath) as! PositionCell
            cell.positionLabel.text = positionName[indexPath.row]
            
            if let position = cell.positionLabel.text {
                       if position == "Top" {
                           cell.positionImage.image = UIImage(named: "탑w")?.withRenderingMode(.alwaysTemplate)
                       } else if position == "Jug" {
                           cell.positionImage.image = UIImage(named: "정글w")?.withRenderingMode(.alwaysTemplate)
                       } else if position == "Mid" {
                           cell.positionImage.image = UIImage(named: "미드w")?.withRenderingMode(.alwaysTemplate)
                       } else if position == "Sup" {
                           cell.positionImage.image = UIImage(named: "서폿w")?.withRenderingMode(.alwaysTemplate)
                       } else if position == "Bot" {
                           cell.positionImage.image = UIImage(named: "바텀w")?.withRenderingMode(.alwaysTemplate)
                       }
                   }
            return cell
        }
    }


    
    

    class CollectionViewCell: UICollectionViewCell {
        let cellFrameView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 10
            return view
        }()

        let tierLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            label.textColor = .black
            label.layer.cornerRadius = 12
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.systemGray4.cgColor
            label.textAlignment = .center
            return label
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

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
}


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
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let positionImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "미드w")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleToFill
//        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

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
//                $0.edges.equalToSuperview().inset(10)
        }
        
        positionLabel.snp.makeConstraints {
            $0.top.equalTo(positionFrame.snp.top).offset(2)
            $0.leading.equalTo(positionFrame.snp.leading).offset(19)
//                $0.edges.equalToSuperview().inset(10)
        }
        
        positionImage.snp.makeConstraints {
            $0.top.equalTo(positionFrame.snp.top).offset(2)
            $0.height.width.equalTo(20)
            $0.leading.equalTo(positionLabel.snp.trailing).offset(3)
//                $0.edges.equalToSuperview().inset(10)
        }
    }
}





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
