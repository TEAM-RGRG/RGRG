//
//  SignUpViewController.swift
//  RGRG
//
//  Created by kiakim on 2023/10/11.
//

import SnapKit
import UIKit



class SignUpViewController: UIViewController {
    
    var idPass:Bool = false
    var pwPass:Bool = false
    var pwCheckPass:Bool = false
    var nickNamePass:Bool = false
    
    let bodyContainer = {
        let stactview = UIView()
        return stactview
    }()
    
    let mainImage = {
        let image = UIImageView()
        return image
    }()
    
    let idLine = {
        let line = CustomMemberInfoBox(id:"ID",infoText: "영문 숫자 3자 이상",placeHolder: "ID", condition:"^[a-zA-Z0-9]{3,}$")
        return line
    }()
    
    let passwordLine = {
        let line = CustomMemberInfoBox(id:"PW",infoText: "영문 숫자 7자 이상",placeHolder: "Password", condition:"^[a-zA-Z0-9]{7,}$")
        line.inputBox.isSecureTextEntry = true
        return line
    }()
    
    
    let passwordCheckLine = {
        let line = CustomMemberInfoBox(id:"PWcheck",infoText: "다시 확인해주세요", placeHolder: "Password Check", condition:"")
        line.inputBox.isSecureTextEntry = true
        return line
    }()
    
    let nickNameLine = {
        let line = CustomMemberInfoBox(id:"nickName",infoText: "영문 숫자 한글 2자 이상",placeHolder: "닉네임", condition:"^[a-zA-Z0-9가-힣]{2,}$")
        
        return line
    }()
    
    
    let signupButton = {
        let button = CtaLargeButton(titleText: "회원가입")
        return button
    }()
    
    
    
    //한번만 불림, 이미 실행됨
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        passValueCheck()
    }
    
}


extension SignUpViewController {
    @objc func movetoLogin(){
        let movePage = LoginViewController()
        self.navigationController?.pushViewController(movePage, animated: true)
    }
    
    func passValueCheck(){
        
        func updateUI(){
            
            guard self.idPass && self.pwPass && pwCheckPass && self.nickNamePass else{
                return
            }
            signupButton.backgroundColor = UIColor.black
        }
        
        //idPass값이 안바뀌는 것처럼 보이는건, ViewDidLoad에서 이미 그려졌기 때문
        //클로져는 독립젹인 코드블럭이기에 이 안에서는 업데이트가 가능
        idLine.passHandler = { pass in
            self.idPass = pass
            updateUI()
        }
        passwordLine.passHandler = { pass in
            self.pwPass = pass
            updateUI()
        }
        passwordCheckLine.passHandler = { pass in
            self.pwCheckPass = pass
            updateUI()
        }
        nickNameLine.passHandler = { pass in
            self.nickNamePass = pass
            updateUI()
            
        }
        
        
    }
    
    
    
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
        signupButton.addTarget(self, action: #selector(movetoLogin), for: .touchUpInside)
        signupButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
    }
}
