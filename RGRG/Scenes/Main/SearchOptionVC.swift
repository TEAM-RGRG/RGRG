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
    
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    
    let timeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 3
        return textField
    }()
    
    let tierLabel: UILabel = {
        let label = UILabel()
        label.text = "티어"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let positionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 3
        return textField
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
    }
    
    
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        
        // ToDoListPageViewController 대신 해당 페이지의 루트 뷰 컨트롤러로 감싸진 내비게이션 컨트롤러를 만듭니다.
//        let ViewController = ViewController() // ToDoListPageViewController의 인스턴스 생성
//        let navigationController = UINavigationController(rootViewController: ViewController)
//
//        navigationController.modalPresentationStyle = .fullScreen
//        present(navigationController, animated: true, completion: nil) // 내비게이션 컨트롤러를 표시
    }
    
    
    
    
    func configureUI() {
        view.backgroundColor = UIColor.RGRGColor5
        
        view.addSubview(pageTitleLabel)
        view.addSubview(backButton)
        view.addSubview(timeLabel)
        view.addSubview(timeTextField)
        view.addSubview(tierLabel)
        view.addSubview(tierTextField)
        view.addSubview(positionLabel)
        view.addSubview(positionTextField)

        
        
        
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
        timeLabel.snp.makeConstraints{
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(25)
        }
        
        timeTextField.snp.makeConstraints{
            $0.top.equalTo(timeLabel.snp.bottom).offset(5)
            $0.height.equalTo(25)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().offset(25)
        }
        
        // 티어 옵션
        tierLabel.snp.makeConstraints{
            $0.top.equalTo(timeTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(25)
        }
        
        tierTextField.snp.makeConstraints{
            $0.top.equalTo(tierLabel.snp.bottom).offset(5)
            $0.height.equalTo(25)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().offset(25)
        }
        
        
        // 포지션 옵션
        positionLabel.snp.makeConstraints{
            $0.top.equalTo(tierTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(25)
        }
        
        positionTextField.snp.makeConstraints{
            $0.top.equalTo(positionLabel.snp.bottom).offset(5)
            $0.height.equalTo(25)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().offset(25)
        }
        
        
        // 소개글


       
        
//        patryListTable.snp.makeConstraints{
//            $0.top.equalTo(contentView.snp.top).offset(10)
//        }
    }
}

