//
//  SignUpViewController.swift
//  RGRG
//
//  Created by kiakim on 2023/10/11.
//

import SnapKit
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth


class SignUpViewController: UIViewController {
    
    var idPass:Bool = false
    var pwPass:Bool = false
    var pwCheckPass:Bool = false
    var nickNamePass:Bool = false
    
    let bodyContainer = {
        let stactview = UIView()
        return stactview
    }()
    
    let imageArea = {
        let view = UIView()
        return view
    }()
    
    let mainImage = {
        let image = UIImageView()
        return image
    }()
    
    
    let methodArea = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    
    let emailLine = {
        let line = CustomMemberInfoBox(id:"Email",infoText: "Email 형식 확인",placeHolder: "Email", condition:"^[A-Za-z0-9+_.-]+@(.+)$")
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
    
    let positionLine = {
        let line = CustomMemberInfoBox(id:"nickName",infoText: "영문 숫자 한글 2자 이상",placeHolder: "Position", condition:"^[a-zA-Z0-9가-힣]{2,}$")
        return line
    }()
    
    
    let signupButton = {
        let button = CtaLargeButton(titleText: "회원가입")
        return button
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "f1f1f1")
        setupUI()
        passValueCheck()
    }
    
}


extension SignUpViewController {
    @objc func tapSignUP(){
        // ture 값전달할 수 있도록 변경
        if self.idPass && self.pwPass && pwCheckPass && self.nickNamePass {
            createUser()
            movetoLogin()
            
        }
    }
    
    func createUser(){
        let email = emailLine.inputBox.text
        let password = passwordLine.inputBox.text
        let userName = nickNameLine.inputBox.text
        print("email",email)
        print("password",password)
        print("userName",userName)

        Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") {result,error in
            if let error = error {
                print(error)
            }
            
            if let result = result {
                print(result)
                print("use 생성 완료 .. !")
            }
        }
    }
    
    func movetoLogin(){
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
        emailLine.passHandler = { pass in
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
        bodyContainer.addSubview(imageArea)
        bodyContainer.addSubview(methodArea)
        imageArea.addSubview(mainImage)
        methodArea.addArrangedSubview(emailLine)
        methodArea.addArrangedSubview(passwordLine)
        methodArea.addArrangedSubview(passwordCheckLine)
        methodArea.addArrangedSubview(nickNameLine)
        methodArea.addArrangedSubview(positionLine)
        methodArea.addArrangedSubview(signupButton)
        
        bodyContainer.layer.borderColor = UIColor.systemBlue.cgColor
        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
        }
        
        imageArea.backgroundColor = UIColor(hex: "D9D9D9")
        imageArea.layer.cornerRadius = 10
        imageArea.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(6)
        }
        
        mainImage.image = UIImage(named: "SignupMain")
        mainImage.contentMode = .scaleAspectFit
        mainImage.snp.makeConstraints { make in
            make.width.equalTo(imageArea.snp.width).multipliedBy(0.8)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        methodArea.spacing = 15
        methodArea.distribution = .fillProportionally
        methodArea.snp.makeConstraints { make in
            make.top.equalTo(imageArea.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
            
        }
        
        emailLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        passwordLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(emailLine.snp.bottom).offset(20)
        }
        
        passwordCheckLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passwordLine.snp.bottom).offset(20)
        }
        
        nickNameLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passwordCheckLine.snp.bottom).offset(20)
        }
        
        signupButton.addTarget(self, action: #selector(tapSignUP), for: .touchUpInside)
        signupButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
    }
}
