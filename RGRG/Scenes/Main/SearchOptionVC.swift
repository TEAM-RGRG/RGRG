//
//  SearchOptionVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/18.
//

import Foundation
import SnapKit
import UIKit

class SearchOptionVC: UIViewController {
<<<<<<< HEAD
=======
    let pageTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "RGRG"
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.RGRGColor2, for: .normal)
//        button.backgroundColor = UIColor.RGRGColor2
//        button.layer.cornerRadius = (10)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
>>>>>>> ab40d22 ([FEAT]: 파이어베이스 서버 로드)
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "원하시는 검색 조건을 선택하세요"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
<<<<<<< HEAD

=======
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let timeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.RGRGColor2?.cgColor
        return textField
    }()
    
    let timeTildeLabel: UILabel = {
        let label = UILabel()
        label.text = "~"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let secondtimeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.RGRGColor2?.cgColor
        return textField
    }()
    
>>>>>>> ab40d22 ([FEAT]: 파이어베이스 서버 로드)
    let tierLabel: UILabel = {
        let label = UILabel()
        label.text = "티어"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let tierButtonFirstFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    let ironTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let bronzeTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-bronze"), for: .normal)
        button.imageEdgeInsets = .init(top: -80, left: -145, bottom: -80, right: -145)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let silverTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-silver"), for: .normal)
        button.imageEdgeInsets = .init(top: -70, left: -130, bottom: -70, right: -130)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let goldTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-gold"), for: .normal)
        button.imageEdgeInsets = .init(top: -60, left: -125, bottom: -60, right: -125)
        button.tintColor = UIColor.white
//        button.layer.maskedCorners = [.layerMaxXMinYCorner]
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tierButtonSecondFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    let platinumTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-platinum"), for: .normal)
        button.imageEdgeInsets = .init(top: -55, left: -122, bottom: -55, right: -122)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
//        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let emeraldTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-emerald"), for: .normal)
        button.imageEdgeInsets = .init(top: -10, left: -5, bottom: 0, right: -5)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
//        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let diamondTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-diamond"), for: .normal)
        button.imageEdgeInsets = .init(top: -55, left: -110, bottom: -55, right: -110)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
//        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let masterTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-master"), for: .normal)
        button.imageEdgeInsets = .init(top: -55, left: -115, bottom: -55, right: -115)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
//        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tierButtonthirdFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    let grandMasterTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-grandmaster"), for: .normal)
        button.imageEdgeInsets = .init(top: -55, left: -110, bottom: -55, right: -110)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
//        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let challengerTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "emblem-challenger"), for: .normal)
        button.imageEdgeInsets = .init(top: -55, left: -110, bottom: -55, right: -110)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
//        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let firstEmptyViewInTierFrame: UIView = {
        let view = UIView()
        return view
    }()
    
    let secondEmptyViewInTierFrame: UIView = {
        let view = UIView()
        return view
    }()

    let fourthButtonthirdFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    let tierTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 3
        return textField
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "포지션"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let positionButtonFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    let topPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("탑", for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .bottom
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "Position_Top"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
//        button.tintColor = UIColor.white
        button.backgroundColor = .white
//        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let junglePositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "Position_Jungle"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let midPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "Position_Mid"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let bottomPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "Position_Bot"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let supportPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "Position_Support"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = UIColor.white
        button.backgroundColor = .white
//        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.setTitle("확 인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.RGRGColor4
        button.layer.cornerRadius = (10)
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
//    let listUnderline: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.RGRGColor2
//        return view
//    }()
//
//    let buttonFrame: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually
//        stackView.spacing = 10
//        return stackView
//    }()
    
    var tierOptionButtonArry = [UIButton]()
    var positionOptionButtonArry = [UIButton]()
    
    @objc func tierOptionButtonTapped(_ sender: UIButton) {
        for Btn in tierOptionButtonArry {
            if Btn == sender {
                // 만약 현재 버튼이 이 함수를 호출한 버튼이라면
                Btn.isSelected = true
                Btn.backgroundColor = .systemGray5
                Btn.layer.borderColor = UIColor.RGRGColor3?.cgColor
            }
            else {
                // 이 함수를 호출한 버튼이 아니라면
                Btn.isSelected = false
                Btn.backgroundColor = .white
                    Btn.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    @objc func positionOptionButtonTapped(_ sender: UIButton) {
        for Btn in positionOptionButtonArry {
            if Btn == sender {
                // 만약 현재 버튼이 이 함수를 호출한 버튼이라면
                Btn.isSelected = true
                Btn.backgroundColor = .systemGray5
                Btn.layer.borderColor = UIColor.RGRGColor3?.cgColor
            }
            else {
                // 이 함수를 호출한 버튼이 아니라면
                Btn.isSelected = false
                Btn.backgroundColor = .white
                    Btn.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tierOptionButtonArry.append(ironTierbutton)
        tierOptionButtonArry.append(bronzeTierbutton)
        tierOptionButtonArry.append(silverTierbutton)
        tierOptionButtonArry.append(goldTierbutton)
        tierOptionButtonArry.append(platinumTierbutton)
        tierOptionButtonArry.append(emeraldTierbutton)
        tierOptionButtonArry.append(diamondTierbutton)
        tierOptionButtonArry.append(masterTierbutton)
        tierOptionButtonArry.append(grandMasterTierbutton)
        tierOptionButtonArry.append(challengerTierbutton)
        positionOptionButtonArry.append(topPositionbutton)
        positionOptionButtonArry.append(junglePositionbutton)
        positionOptionButtonArry.append(midPositionbutton)
        positionOptionButtonArry.append(bottomPositionbutton)
        positionOptionButtonArry.append(supportPositionbutton)
        
        configureUI()
    }
    
<<<<<<< HEAD
    override func viewWillAppear(_ animated: Bool) {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [
                .custom { _ in
                    return 350
                }
            ]
        }
    }
    
    
    
=======
>>>>>>> ab40d22 ([FEAT]: 파이어베이스 서버 로드)
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(infoLabel)
        view.addSubview(tierLabel)
        
        view.addSubview(tierButtonFirstFrame)
        tierButtonFirstFrame.addArrangedSubview(ironTierbutton)
        tierButtonFirstFrame.addArrangedSubview(bronzeTierbutton)
        tierButtonFirstFrame.addArrangedSubview(silverTierbutton)
        tierButtonFirstFrame.addArrangedSubview(goldTierbutton)
        view.addSubview(tierButtonSecondFrame)
        tierButtonSecondFrame.addArrangedSubview(platinumTierbutton)
        tierButtonSecondFrame.addArrangedSubview(emeraldTierbutton)
        tierButtonSecondFrame.addArrangedSubview(diamondTierbutton)
        tierButtonSecondFrame.addArrangedSubview(firstEmptyViewInTierFrame)
        
        view.addSubview(positionLabel)
        view.addSubview(positionButtonFrame)
        positionButtonFrame.addArrangedSubview(topPositionbutton)
        positionButtonFrame.addArrangedSubview(junglePositionbutton)
        positionButtonFrame.addArrangedSubview(midPositionbutton)
        positionButtonFrame.addArrangedSubview(bottomPositionbutton)
        positionButtonFrame.addArrangedSubview(supportPositionbutton)
        view.addSubview(confirmationButton)
<<<<<<< HEAD
        
        
        infoLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        
        // 티어 옵션
        tierLabel.snp.makeConstraints{
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        tierButtonFirstFrame.snp.makeConstraints{
            $0.top.equalTo(tierLabel.snp.bottom).offset(5)
=======

        pageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.leading.equalToSuperview().offset(25)
            $0.centerX.equalTo(view)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(25)
//            $0.trailing.equalTo(pageTitleLabel.snp.leading).offset(-25)
//            $0.height.equalTo(40)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(15)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        timeTextField.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.height.equalTo(35)
            $0.width.equalTo(130)
            $0.leading.equalToSuperview().offset(10)
        }
        
        timeTildeLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(5)
            $0.leading.equalTo(timeTextField.snp.trailing).offset(5)
        }
        
        secondtimeTextField.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.height.equalTo(35)
            $0.width.equalTo(130)
            $0.leading.equalTo(timeTildeLabel.snp.trailing).offset(5)
        }
        
        // 티어 옵션
        tierLabel.snp.makeConstraints {
            $0.top.equalTo(timeTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(15)
        }
        
        tierButtonFirstFrame.snp.makeConstraints {
            $0.top.equalTo(tierLabel.snp.bottom).offset(10)
>>>>>>> ab40d22 ([FEAT]: 파이어베이스 서버 로드)
            $0.height.equalTo(65)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        tierButtonSecondFrame.snp.makeConstraints {
            $0.top.equalTo(tierButtonFirstFrame.snp.bottom).offset(3)
            $0.height.equalTo(65)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        // 포지션 옵션
<<<<<<< HEAD
        positionLabel.snp.makeConstraints{
            $0.top.equalTo(tierButtonSecondFrame.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        positionButtonFrame.snp.makeConstraints{
            $0.top.equalTo(positionLabel.snp.bottom).offset(5)
=======
        positionLabel.snp.makeConstraints {
            $0.top.equalTo(tierButtonSecondFrame.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(15)
        }
        
        positionButtonFrame.snp.makeConstraints {
            $0.top.equalTo(positionLabel.snp.bottom).offset(10)
//            $0.height.equalTo(180)
//            $0.width.equalTo(120)
>>>>>>> ab40d22 ([FEAT]: 파이어베이스 서버 로드)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
<<<<<<< HEAD
        
        confirmationButton.snp.makeConstraints{
            $0.top.equalTo(positionButtonFrame.snp.bottom).offset(40)
=======
        confirmationButton.snp.makeConstraints {
            $0.top.equalTo(positionButtonFrame.snp.bottom).offset(60)
>>>>>>> ab40d22 ([FEAT]: 파이어베이스 서버 로드)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
            $0.centerX.equalTo(view)
        }
<<<<<<< HEAD
=======
        
        // 소개글

//        patryListTable.snp.makeConstraints{
//            $0.top.equalTo(contentView.snp.top).offset(10)
//        }
>>>>>>> ab40d22 ([FEAT]: 파이어베이스 서버 로드)
    }
}
