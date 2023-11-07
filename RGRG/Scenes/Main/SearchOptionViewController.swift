//
//  SearchOptionViewController.swift
//  RGRG
//
//  Created by 이수현 on 11/7/23.
//

import SnapKit
import UIKit

protocol SendSelectedOptionDelegate {
    func sendSelectedOption(tier: String, position: String)
}

class SearchOptionViewController: UIViewController {
    var delegate: SendSelectedOptionDelegate?

    let tierName = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond"]
    let positionName = ["Top", "Jug", "Mid", "Bot", "Sup"]
    let positionFullName = ["Top", "Jungle", "Mid", "Bottom", "Support"]

    var selectedOption: [String: String] = ["tier": "", "position": ""]
    var selectedTier: String = ""
    var selectedPosition: String = ""

    let tierTitleLabel = CustomLabel()

    let tierCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()

    let positionTitleLabel = CustomLabel()

    let positionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()

    let confirmButton = CustomButton()
}

// MARK: viewController의 생명주기

extension SearchOptionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
//        loadSelectedCellInfo()
        tierCollectionView.reloadData()
        positionCollectionView.reloadData()
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

extension SearchOptionViewController {
    func setupTitleLabels() {
        tierTitleLabel.settingText("티어")
        positionTitleLabel.settingText("포지션")

        [tierTitleLabel, positionTitleLabel].forEach {
            $0.setupLabelColor(color: UIColor(hex: "505050"))
            $0.font = .myBoldSystemFont(ofSize: 16)
        }
    }

    func setupButton() {
        confirmButton.titleLabel?.font = .myBoldSystemFont(ofSize: 15)
        confirmButton.setTitle("선택 완료", for: .normal)
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.backgroundColor = UIColor.rgrgColor4
        confirmButton.layer.cornerRadius = 10
        confirmButton.addTarget(self, action: #selector(confirmationButtonTapped), for: .touchUpInside)
    }

    func configureUI() {
        setupTitleLabels()
        setupButton()

        view.backgroundColor = .white

        [tierTitleLabel, tierCollectionView, positionTitleLabel, positionCollectionView, confirmButton].forEach { view.addSubview($0) }

        tierTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(25)
            make.height.equalTo(21)
        }

        tierCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tierTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(65)
        }

        positionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(tierCollectionView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(25)
            make.height.equalTo(21)
        }

        positionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(positionTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(65)
        }

        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(46)
            $0.centerX.equalTo(view)
        }
    }
}

// MARK: functions

extension SearchOptionViewController {
    @objc func confirmationButtonTapped() {
        
        delegate?.sendSelectedOption(tier: selectedTier, position: selectedPosition)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: collectionview

extension SearchOptionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setUpCollectionView() {
        tierCollectionView.register(TierCell.self, forCellWithReuseIdentifier: "tierCell")
        positionCollectionView.register(PositionCell.self, forCellWithReuseIdentifier: "positionCell")

        tierCollectionView.dataSource = self
        tierCollectionView.delegate = self

        positionCollectionView.dataSource = self
        positionCollectionView.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tierCollectionView {
            return 7
        } else {
            return 5
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tierCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tierCell", for: indexPath) as! TierCell
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "positionCell", for: indexPath) as! PositionCell
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
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tierCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? TierCell {
                cell.tierLabel.layer.borderColor = UIColor.rgrgColor3.cgColor
                selectedOption["tier"] = tierName[indexPath.row]
                selectedTier = tierName[indexPath.row]
            }
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? PositionCell {
                cell.positionFrame.layer.borderColor = UIColor.rgrgColor3.cgColor
                selectedOption["position"] = positionName[indexPath.row]
                selectedPosition = positionFullName[indexPath.row]
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == tierCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? TierCell {
                cell.tierLabel.layer.borderColor = UIColor.systemGray4.cgColor
            }
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? PositionCell {
                cell.positionFrame.layer.borderColor = UIColor.systemGray4.cgColor
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView == tierCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? TierCell {
                if cell.isSelected {
                    collectionView.deselectItem(at: indexPath, animated: true)
                    cell.tierLabel.layer.borderColor = UIColor.systemGray4.cgColor
                    selectedOption["tier"] = ""
                    selectedTier = ""

                    return false
                } else {
                    return true
                }
            }

        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? PositionCell {
                if cell.isSelected {
                    collectionView.deselectItem(at: indexPath, animated: true)
                    cell.positionFrame.layer.borderColor = UIColor.systemGray4.cgColor
                    selectedOption["position"] = ""
                    selectedPosition = ""
                    return false
                } else {
                    return true
                }
            }
        }

        return true
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let interval: CGFloat = 5
        let width: CGFloat = (collectionView.frame.width - interval * 3 - 19 * 2) / 4
        return CGSize(width: width, height: 24)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
}
