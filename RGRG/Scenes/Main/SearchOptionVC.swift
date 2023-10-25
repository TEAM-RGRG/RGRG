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
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "원하시는 검색 조건을 선택하세요"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
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
        stackView.spacing = 5
        return stackView
    }()
    
    let ironTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Iron", for: .normal)
        //        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        //        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let bronzeTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Bronze", for: .normal)
        //        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        //        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let silverTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Silver", for: .normal)
        //        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        //        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let goldTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Gold", for: .normal)
        //        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        //        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tierButtonSecondFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    let platinumTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Platinum", for: .normal)
        //        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        //        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    let emeraldTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Emerald", for: .normal)
        //        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        //        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let diamondTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Diamond", for: .normal)
        //        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        //        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(tierOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let masterTierbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Iron", for: .normal)
        //        button.setImage(UIImage(named: "emblem-iron"), for: .normal)
        //        button.imageEdgeInsets = .init(top: -95, left: -175, bottom: -95, right: -175)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGray4.cgColor
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

    let EmptyViewInTierFrame: UILabel = {
        let view = UILabel()
        view.text = "빈 배열"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 12, weight: .bold)
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
        label.text = "희망 포지션"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let positionButtonFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    
    
    
    let topPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("Top ", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.systemGray, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "탑w"), for: .normal)
        button.imageEdgeInsets = .init(top: 32, left: 32, bottom: 32, right: 32)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
                button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let junglePositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("Top ", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.systemGray, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "정글w"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        //        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let midPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("Top ", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.systemGray, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "미드w"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        //        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let bottomPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("Top ", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.systemGray, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "바텀w"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        button.clipsToBounds = false
        //        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let positionButtonScondFrame: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    let supportPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("Top ", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.systemGray, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "서폿w"), for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        //        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.setTitle("선택 완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.RGRGColor4
        button.layer.cornerRadius = (10)
        //        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
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
        positionOptionButtonArry.append(topPositionbutton)
        positionOptionButtonArry.append(junglePositionbutton)
        positionOptionButtonArry.append(midPositionbutton)
        positionOptionButtonArry.append(bottomPositionbutton)
        positionOptionButtonArry.append(supportPositionbutton)
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [
                .custom { _ in
                    return 360
                }
            ]
        }
    }
    
    
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func configureUI() {
        view.backgroundColor = .white
        
        //        view.addSubview(infoLabel)
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
        tierButtonSecondFrame.addArrangedSubview(EmptyViewInTierFrame)
        
        view.addSubview(positionLabel)
        view.addSubview(positionButtonFrame)
        positionButtonFrame.addArrangedSubview(topPositionbutton)
        positionButtonFrame.addArrangedSubview(junglePositionbutton)
        positionButtonFrame.addArrangedSubview(midPositionbutton)
        positionButtonFrame.addArrangedSubview(bottomPositionbutton)
        view.addSubview(positionButtonScondFrame)
        positionButtonScondFrame.addArrangedSubview(supportPositionbutton)
        positionButtonScondFrame.addArrangedSubview(EmptyViewInTierFrame)
        positionButtonScondFrame.addArrangedSubview(EmptyViewInTierFrame)
        positionButtonScondFrame.addArrangedSubview(EmptyViewInTierFrame)
        view.addSubview(confirmationButton)
        
        
        //        infoLabel.snp.makeConstraints{
        //            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
        //            $0.leading.equalToSuperview().offset(20)
        //        }
        
        // 티어 옵션
        tierLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.leading.equalToSuperview().offset(25)
        }
        
        tierButtonFirstFrame.snp.makeConstraints{
            $0.top.equalTo(tierLabel.snp.bottom).offset(13)
            $0.height.equalTo(25)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-19)
        }
        
        tierButtonSecondFrame.snp.makeConstraints{
            $0.top.equalTo(tierButtonFirstFrame.snp.bottom).offset(10)
            $0.height.equalTo(25)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-19)
        }
        
        // 포지션 옵션
        positionLabel.snp.makeConstraints{
            $0.top.equalTo(tierButtonSecondFrame.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(25)
        }
        
        positionButtonFrame.snp.makeConstraints{
            $0.top.equalTo(positionLabel.snp.bottom).offset(5)
            $0.height.equalTo(25)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-19)
        }
        
        positionButtonScondFrame.snp.makeConstraints{
            $0.top.equalTo(positionButtonFrame.snp.bottom).offset(5)
            $0.height.equalTo(25)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-19)
        }
        
        ////
//        EmptyViewInTierFrame.snp.makeConstraints{
//            $0.height.width.equalTo(10)
//        }
        
        
        confirmationButton.snp.makeConstraints{
            $0.top.equalTo(positionButtonScondFrame.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(41)
            $0.trailing.equalToSuperview().offset(-41)
            $0.height.equalTo(46)
            //            $0.bottom.equalToSuperview().offset(-25)
            $0.centerX.equalTo(view)
        }
    }
}
    



