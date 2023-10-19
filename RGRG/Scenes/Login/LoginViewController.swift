//
//  LoginViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    var loginIdPass:Bool = false
    var loginPwPass:Bool = false
    
    let bodyContainer = {
        let stactview = UIView()
        return stactview
    }()
    
    let imageArea = {
        let view = UIView()
        return view
    }()
    
    let mainImage = {
        let title = UIImageView()
        return title
    }()
    
    let methodArea = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    let idLine = {
        let line = CustomMemberInfoBox(id:"LoginID", placeHolder: "ID", condition:"^[a-zA-Z0-9]{3,}$", cellHeight:70)
        return line
    }()
    
    let passwordLine = {
        let line = CustomMemberInfoBox( id:"LoginPW",placeHolder: "Password", condition:"^[a-zA-Z0-9]{7,}$", cellHeight:70)
        line.inputBox.isSecureTextEntry = true
        return line
    }()
    
    let loginButton = {
        let button = CtaLargeButton(titleText: "로그인")
        return button
    }()
    
    let signupButton = {
        let button = UIButton()
        return button
    }()
    
    let apiLoginArea = {
        let view = UIView()
        return view
    }()
    
    //오버라이딩 : 재정의
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        passValueCheck()
    }
}


extension LoginViewController {
    
    @objc func gotoSignupPage(){
        let signupVC = SignUpViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc func moveToMain(){
        //tapbar 보이도록 수정 .. !
        let movePage = TabBarController()
        self.navigationController?.pushViewController(movePage, animated: true)
    }
    
    func passValueCheck(){
        func updateUI(){
            guard self.loginIdPass && self.loginPwPass else {
                return
            }
            loginButton.backgroundColor = UIColor.black
        }
        idLine.passHandler = { pass in
            self.loginIdPass = pass
            updateUI()
        }
        passwordLine.passHandler = { pass in
            self.loginPwPass = pass
            updateUI()
        }
        
    }
    
    
    
    func setupUI(){
        
        //bodyContainer의 높이를 알수는 없는걸까 ?
//        let  screenHeigth = UIScreen.main.bounds.height
//        let bodyContainerHeigth = bodyContainer.frame.height
//
//        print("screenHeigth",screenHeigth)
//        print("bodyContainerHeigt",bodyContainerHeigth)
        
        view.addSubview(bodyContainer)
        bodyContainer.addSubview(imageArea)
        imageArea.addSubview(mainImage)
        bodyContainer.addSubview(methodArea)
        methodArea.addArrangedSubview(idLine)
        methodArea.addArrangedSubview(passwordLine)
        loginButton.addTarget(self, action: #selector(moveToMain), for: .touchUpInside)
        methodArea.addArrangedSubview(loginButton)
        methodArea.addArrangedSubview(signupButton)
        
        
//        bodyContainer.layer.borderWidth = 1
//        bodyContainer.layer.borderColor = UIColor.systemBlue.cgColor
        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
        }
        
        //        imageArea.backgroundColor = UIColor.systemRed
        imageArea.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        //        mainImage.layer.borderWidth = 1
        mainImage.backgroundColor = UIColor.systemGray5
        mainImage.image = UIImage(named: "LoginMain")
        mainImage.contentMode = .scaleAspectFill
        mainImage.snp.makeConstraints { make in
            //            make.top.equalToSuperview().offset(100)
            make.height.equalToSuperview().dividedBy(2)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
//        methodArea.backgroundColor = UIColor.systemBlue
        methodArea.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        idLine.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(5)
            make.bottom.equalTo(passwordLine.snp.top).offset(-20)
        }
        
        passwordLine.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(5)
            make.bottom.equalTo(loginButton.snp.top).offset(-20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(5)
            make.bottom.equalTo(signupButton.snp.top)
        }
        
//        signupButton.layer.borderWidth = 1
        signupButton.setTitle("회원가입", for: .normal)
        signupButton.setTitleColor(UIColor.black, for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        signupButton.addTarget(self, action: #selector(gotoSignupPage), for: .touchUpInside)
        signupButton.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(6)
            make.bottom.equalTo(bodyContainer.snp.bottom).offset(-30)
        }
    }
}
