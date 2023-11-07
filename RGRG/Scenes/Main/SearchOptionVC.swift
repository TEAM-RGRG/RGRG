//
//  SearchOptionVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/18.
//

import SnapKit
import UIKit

class SearchOptionVC: UIViewController {
    var selectedTierOption: String?
    var selectedPositionOption: String?
    var onConfirmation: (([String], [String]) -> Void)?

    let tierName = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond"]
    let positionName = ["Top", "Jug", "Mid", "Bot", "Sup"]

    var selectedDic: [String: String] = ["tier": "", "position": ""]

    var selectedTierIndexPath: IndexPath?
    var selectedSection: Int?

    var selectedPositionIndexPath: IndexPath?
    var positionSelectedSection: Int?

    let contentView: UIView = {
        let view = UIView()
        return view
    }()

    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.setTitle("선택 완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.rgrgColor4
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(confirmationButtonTapped), for: .touchUpInside)
        return button
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()

    @objc func confirmationButtonTapped() {
        if let selectedTier = selectedTierOption,
           let selectedPosition = selectedPositionOption
        {
            print("%%%%%%%%%%%%%\(selectedTierOption)%%%%%%%%%%%%%%%")
            onConfirmation?([selectedTier], [selectedPosition])
        }

        saveSelectedCellInfo()
        dismiss(animated: true, completion: nil)
    }

    func saveSelectedCellInfo() {
        let defaults = UserDefaults.standard
        defaults.set(selectedTierIndexPath?.row, forKey: "selectedTierIndex")
        defaults.set(selectedPositionIndexPath?.row, forKey: "selectedPositionIndex")
    }

    func loadSelectedCellInfo() {
        let defaults = UserDefaults.standard
        if let tierIndex = defaults.value(forKey: "selectedTierIndex") as? Int,
           let positionIndex = defaults.value(forKey: "selectedPositionIndex") as? Int
        {
            selectedTierIndexPath = IndexPath(row: tierIndex, section: 0)
            selectedPositionIndexPath = IndexPath(row: positionIndex, section: 1)
        }
    }
}

// MARK: viewController의 생명주기

extension SearchOptionVC {
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpCollectionView()
        loadSelectedCellInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [
                .custom { _ in
                    305
                }
            ]
        }
    }
}

// MARK: UI configure

extension SearchOptionVC {
    func configureUI() {
        view.backgroundColor = .white

        view.addSubview(contentView)
        contentView.addSubview(collectionView)
        view.addSubview(confirmationButton)

        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.bottom.equalTo(confirmationButton.snp.top).offset(-20)
        }

        collectionView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.top.equalTo(contentView.snp.top).offset(0)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-10)
            $0.bottom.equalTo(contentView.snp.bottom).offset(0)
        }

        confirmationButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(46)
            $0.centerX.equalTo(view)
        }
    }
}

extension SearchOptionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setUpCollectionView() {
        collectionView.register(TierCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(PositionCell.self, forCellWithReuseIdentifier: "PositionCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.collectionViewLayout = createCompositionalLayout()

        if let selectedTierIndexPath = selectedTierIndexPath {
            collectionView.selectItem(at: selectedTierIndexPath, animated: false, scrollPosition: [])
        }
        if let selectedPositionIndexPath = selectedPositionIndexPath {
            collectionView.selectItem(at: selectedPositionIndexPath, animated: false, scrollPosition: [])
        }
    }

    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        // 코포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout {
            // 만들게 되면 튜플형태로 들어옴
            (_: Int, _: NSCollectionLayoutEnvironment) ->
                NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .absolute(35))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)

            let section = NSCollectionLayoutSection(group: group)

            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

            section.boundarySupplementaryItems = [header]

            return section
        }
        return layout
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    // 헤더 뷰 구현
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            if indexPath.section == 0 {
                headerView.titleLabel.text = "티어"
                headerView.backgroundColor = .white
            } else {
                headerView.titleLabel.text = "희망 포지션"
                headerView.backgroundColor = .white
            }
            return headerView
        }
        return UICollectionReusableView()
    }

    // 각 섹션당 항목 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        } else {
            return 5
        }
    }

    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }

    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / CGFloat(5)
        let cellHeight = collectionView.bounds.height / CGFloat(10)
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let cell = collectionView.cellForItem(at: indexPath) as? TierCell {
                cell.tierLabel.layer.borderColor = UIColor.rgrgColor3.cgColor
                selectedDic["tier"] = cell.tierLabel.text
                print("~~~~~~~~~~~~~~~~~\(selectedDic)")
            }
        }
        if indexPath.section == 1 {
            if let cell = collectionView.cellForItem(at: indexPath) as? PositionCell {
                cell.positionFrame.layer.borderColor = UIColor.rgrgColor3.cgColor
                selectedDic["position"] = cell.positionLabel.text
            }
        }
        if indexPath.section == 0 {
            if indexPath == selectedTierIndexPath {
                // 이미 선택된 셀을 다시 탭한 경우, 선택 해제
                selectedTierIndexPath = nil
                selectedTierOption = "default"
                UserDefaults.standard.removeObject(forKey: "selectedTierIndexPath")
                print("%%%%%%%%%%%%%%\(selectedTierOption)%%%%%%%%%")

                if let selectedCell = collectionView.cellForItem(at: indexPath) as? TierCell {
                    selectedCell.tierLabel.layer.borderColor = UIColor.systemGray4.cgColor

                    print("%%%%%%%%%%%%%%\(selectedTierOption)%%%%%%%%%")
                }
            } else {
                if let previousIndexPath = selectedTierIndexPath {
                    if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? TierCell {
                        previousCell.tierLabel.layer.borderColor = UIColor.systemGray4.cgColor
                    }
                }

                selectedTierIndexPath = indexPath

                if let selectedCell = collectionView.cellForItem(at: indexPath) as? TierCell {
                    selectedCell.tierLabel.layer.borderColor = UIColor.systemBlue.cgColor
                    selectedTierOption = tierName[indexPath.row]
                }
            }
        } else {
            if indexPath == selectedPositionIndexPath {
                // 이미 선택된 셀을 다시 탭한 경우, 선택 해제
                selectedPositionIndexPath = nil
                selectedPositionOption = "default"
                UserDefaults.standard.removeObject(forKey: "selectedPositionIndexPath")

                if let selectedCell = collectionView.cellForItem(at: indexPath) as? PositionCell {
                    selectedCell.positionFrame.layer.borderColor = UIColor.systemGray4.cgColor
                }
            } else {
                if let previousIndexPath = selectedPositionIndexPath {
                    if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? PositionCell {
                        previousCell.positionFrame.layer.borderColor = UIColor.systemGray4.cgColor
                    }
                }

                selectedPositionIndexPath = indexPath

                if let selectedCell = collectionView.cellForItem(at: indexPath) as? PositionCell {
                    selectedCell.positionFrame.layer.borderColor = UIColor.systemBlue.cgColor
                    selectedPositionOption = positionName[indexPath.row]
                }
            }
        }
    }

//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        <#code#>
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! TierCell
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

            if let selectedTierIndexPath = selectedTierIndexPath, selectedTierIndexPath == indexPath {
                cell.tierLabel.layer.borderColor = UIColor.systemBlue.cgColor
            } else {
                cell.tierLabel.layer.borderColor = UIColor.systemGray4.cgColor
            }

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PositionCell", for: indexPath) as! PositionCell
            cell.positionLabel.text = positionName[indexPath.row]

            if let position = cell.positionLabel.text {
                if position == "Top" {
                    cell.positionImage.image = UIImage(named: "Top")?.withRenderingMode(.alwaysTemplate)
                } else if position == "Jug" {
                    cell.positionImage.image = UIImage(named: "Jungle")?.withRenderingMode(.alwaysTemplate)
                } else if position == "Mid" {
                    cell.positionImage.image = UIImage(named: "Mid")?.withRenderingMode(.alwaysTemplate)
                } else if position == "Sup" {
                    cell.positionImage.image = UIImage(named: "Support")?.withRenderingMode(.alwaysTemplate)
                } else if position == "Bot" {
                    cell.positionImage.image = UIImage(named: "Bottom")?.withRenderingMode(.alwaysTemplate)
                }
            }

            if let selectedPositionIndexPath = selectedPositionIndexPath, selectedPositionIndexPath == indexPath {
                cell.positionFrame.layer.borderColor = UIColor.systemBlue.cgColor
            } else {
                cell.positionFrame.layer.borderColor = UIColor.systemGray4.cgColor
            }

            return cell
        }
    }
}
