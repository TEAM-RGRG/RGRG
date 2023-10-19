//
//  PartyInfoDetailVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/19.
//

import Foundation
import SnapKit
import UIKit



class PartyInfoDetailVC: UIViewController {
    
    
    
    
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
    
    
    let partyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.RGRGColor2
        return label
    }()
    
    
    let partyNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 3
        return textField
    }()
    
//    let timeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "시간"
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        label.textColor = UIColor.RGRGColor2
//        return label
//    }()
//
//    let timeTextField: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = .white
//        textField.layer.cornerRadius = 3
//        return textField
//    }()
    
    let tierLabel: UILabel = {
        let label = UILabel()
        label.text = "티어 선택"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.RGRGColor2
        return label
    }()
    
    let tierFramView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    let tierPopupButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = (4)
        button.addTarget(self, action: #selector(configPopUpButton), for: .touchUpInside)
        return button
    }()
    
    
//    let tierTextField: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = .white
//        textField.layer.cornerRadius = 3
//        return textField
//    }()
    
    let positionFramView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "포지션 선택"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.RGRGColor2
        return label
    }()
    
    let positionPopupButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = (4)
        button.addTarget(self, action: #selector(positionPopUpButton), for: .touchUpInside)
        return button
    }()
    
    
//    let positionTextField: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = .white
//        textField.layer.cornerRadius = 3
//        return textField
//    }()
    
    let infoTextLabel: UILabel = {
        let label = UILabel()
        label.text = "소개글"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.RGRGColor2
        return label
    }()
    
    let infoTextField: UITextField = {
        let textField = UITextField()
//        textField.backgroundColor = UIColor.RGRGColor2
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.placeholder = "간단한 파티 소개글을 입력해 주세요"
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        return textField
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
    
    
    
    @objc private func configPopUpButton() {
            let popUpButtonClosure = { (action: UIAction) in
                if action.title == "아이언" {
                    self.tierPopupButton.setTitle("아이언", for: .normal)
                }
                else if action.title == "브론즈" {
                    self.tierPopupButton.setTitle("브론즈", for: .normal)
                }
                else if action.title == "실버" {
                    self.tierPopupButton.setTitle("실버", for: .normal)
                }
                else if action.title == "골드" {
                    self.tierPopupButton.setTitle("골드", for: .normal)
                }
                else if action.title == "플레티넘" {
                    self.tierPopupButton.setTitle("플레티넘", for: .normal)
                }
                else if action.title == "에메랄드" {
                    self.tierPopupButton.setTitle("에메랄드", for: .normal)
                }
                else if action.title == "다이아" {
                    self.tierPopupButton.setTitle("다이아", for: .normal)
                }
                else {
                }
                
                return
            }
            
        tierPopupButton.menu = UIMenu(title: "티어선택", children: [
                UIAction(title: "아이언", handler: popUpButtonClosure),
                UIAction(title: "브론즈", handler: popUpButtonClosure),
                UIAction(title: "실버", handler: popUpButtonClosure),
                UIAction(title: "골드", handler: popUpButtonClosure),
                UIAction(title: "플레티넘", handler: popUpButtonClosure),
                UIAction(title: "에메랄드", handler: popUpButtonClosure),
                UIAction(title: "다이아", handler: popUpButtonClosure)
            ])
            
        tierPopupButton.showsMenuAsPrimaryAction = true
        }
    
    
    @objc private func positionPopUpButton() {
            let popUpButtonClosure = { (action: UIAction) in
                if action.title == "탑" {
                    self.positionPopupButton.setTitle("탑", for: .normal)
                }
                else if action.title == "정글" {
                    self.positionPopupButton.setTitle("정글", for: .normal)
                }
                else if action.title == "미드" {
                    self.positionPopupButton.setTitle("미드", for: .normal)
                }
                else if action.title == "바텀" {
                    self.positionPopupButton.setTitle("바텀", for: .normal)
                }
                else if action.title == "서폿" {
                    self.positionPopupButton.setTitle("서폿", for: .normal)
                }
                else if action.title == "무관" {
                    self.positionPopupButton.setTitle("무관", for: .normal)
                }
                else {
                }
                
                return
            }
            
        positionPopupButton.menu = UIMenu(title: "포지션선택", children: [
                UIAction(title: "탑", handler: popUpButtonClosure),
                UIAction(title: "정글", handler: popUpButtonClosure),
                UIAction(title: "미드", handler: popUpButtonClosure),
                UIAction(title: "바텀", handler: popUpButtonClosure),
                UIAction(title: "서폿", handler: popUpButtonClosure),
                UIAction(title: "무관", handler: popUpButtonClosure)
            ])
            
        positionPopupButton.showsMenuAsPrimaryAction = true
        }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
    }
    
    
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(pageTitleLabel)
        view.addSubview(backButton)
        view.addSubview(partyNameLabel)
        view.addSubview(partyNameTextField)
        view.addSubview(tierFramView)
        tierFramView.addArrangedSubview(tierLabel)
        tierFramView.addArrangedSubview(tierPopupButton)
        view.addSubview(positionFramView)
        positionFramView.addArrangedSubview(positionLabel)
        positionFramView.addArrangedSubview(positionPopupButton)
        view.addSubview(infoTextLabel)
        view.addSubview(infoTextField)
        view.addSubview(confirmationButton)
        
        
        
        pageTitleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.leading.equalToSuperview().offset(25)
            $0.centerX.equalTo(view)
        }
        
        // 버튼 스택 프레임
        backButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(25)
//            $0.trailing.equalTo(pageTitleLabel.snp.leading).offset(-25)
//            $0.height.equalTo(40)
        }
        
        // 파티명
        partyNameLabel.snp.makeConstraints{
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(25)
        }
        
        partyNameTextField.snp.makeConstraints{
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(40)
            $0.height.equalTo(25)
            $0.width.equalTo(120)
            $0.leading.equalTo(partyNameLabel.snp.trailing).offset(15)
        }
        
        // 티어 옵션
        tierFramView.snp.makeConstraints{
            $0.top.equalTo(partyNameLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(25)
        }
        
        
        tierLabel.snp.makeConstraints{
            $0.top.equalTo(tierFramView.snp.top).offset(0)
            $0.leading.equalTo(tierFramView.snp.leading).offset(0)
        }
        
        tierPopupButton.snp.makeConstraints{
            $0.top.equalTo(tierLabel.snp.bottom).offset(10)
            $0.height.equalTo(25)
            $0.width.equalTo(120)
            $0.leading.equalTo(tierFramView.snp.leading).offset(0)
        }
        
        
        // 포지션 옵션
        
        positionFramView.snp.makeConstraints{
            $0.top.equalTo(tierFramView.snp.top).offset(0)
            $0.leading.equalTo(tierFramView.snp.trailing).offset(15)
        }
        
        positionLabel.snp.makeConstraints{
            $0.top.equalTo(positionFramView.snp.top).offset(0)
            $0.leading.equalTo(positionFramView.snp.leading).offset(0)
        }
        
        positionPopupButton.snp.makeConstraints{
            $0.top.equalTo(positionLabel.snp.bottom).offset(10)
            $0.height.equalTo(25)
            $0.width.equalTo(120)
            $0.leading.equalTo(positionFramView.snp.leading).offset(0)
        }
        
        
        // 소개글
        infoTextLabel.snp.makeConstraints{
            $0.top.equalTo(tierFramView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(25)
        }
        
        infoTextField.snp.makeConstraints{
            $0.top.equalTo(infoTextLabel.snp.bottom).offset(5)
            $0.height.equalTo(200)
//            $0.width.equalTo(80)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        confirmationButton.snp.makeConstraints{
            $0.top.equalTo(infoTextField.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
            $0.centerX.equalTo(view)
        }
    }
}
