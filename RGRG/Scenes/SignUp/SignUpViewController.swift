//
//  SignUpViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit



class SignUpViewController: UIViewController {
    
    
    
    let bodyContainer = {
        let stactview = UIView()
        return stactview
    }()
    
    let mainImage = {
        let image = UIImageView()
        return image
    }()
    
    let idLine = {
        let line = CustomLoginCell(id:"ID",infoText: "영문 숫자 3자 이상",placeHolder: "ID", condition:"^[a-zA-Z0-9]{3,}$")
        return line
    }()
    
    let passwordLine = {
        let line = CustomLoginCell(id:"PW",infoText: "영문 숫자 7자 이상",placeHolder: "Password", condition:"^[a-zA-Z0-9]{7,}$")
        line.inputBox.isSecureTextEntry = true
        return line
    }()
    
    
    let passwordCheckLine = {
        let line = CustomLoginCell(id:"PWcheck",infoText: "다시 확인해주세요", placeHolder: "Password Check", condition:"")
        line.inputBox.isSecureTextEntry = true
        return line
    }()
    
    let nickNameLine = {
        let line = CustomLoginCell(id:"nickName",infoText: "영문 숫자 한글 2자 이상",placeHolder: "닉네임", condition:"^[a-zA-Z0-9가-힣]{2,}$")
        return line
    }()
    
    
    let signupButton = {
        let button = CtaLargeButton(titleText: "회원가입")
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
}


extension SignUpViewController {
    func setupUI() {
        view.addSubview(bodyContainer)
        //        bodyStackContainer.axis = .vertical
        bodyContainer.layer.borderColor = UIColor.systemBlue.cgColor
//                bodyContainer.layer.borderWidth = 1
        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
            
        }
        
        bodyContainer.addSubview(mainImage)
        mainImage.image = UIImage(named: "SignupMain")
        mainImage.contentMode = .scaleAspectFill
        mainImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        bodyContainer.addSubview(idLine)
        idLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        
        
        bodyContainer.addSubview(passwordLine)
        passwordLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(idLine.snp.bottom).offset(20)
        }
        
        bodyContainer.addSubview(passwordCheckLine)
        passwordCheckLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passwordLine.snp.bottom).offset(20)
        }
        
        bodyContainer.addSubview(nickNameLine)
        nickNameLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passwordCheckLine.snp.bottom).offset(20)
        }
        
        bodyContainer.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
    }
}
