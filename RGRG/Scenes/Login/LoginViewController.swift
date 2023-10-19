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
    
    let mainImage = {
        let title = UIImageView()
        return title
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
      let movePage = MainViewController()
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
        
        view.addSubview(bodyContainer)
        bodyContainer.layer.borderColor = UIColor.systemBlue.cgColor
        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
        }
        
        
        bodyContainer.addSubview(mainImage)
        mainImage.image = UIImage(named: "LoginMain")
        //        mainImage.layer.borderWidth = 1
        mainImage.contentMode = .scaleAspectFill
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(200)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        bodyContainer.addSubview(idLine)
        idLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).offset(20)
        }
        
        bodyContainer.addSubview(passwordLine)
        passwordLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(idLine.snp.bottom).offset(20)
        }
        
        bodyContainer.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(moveToMain), for: .touchUpInside)
        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passwordLine.snp.bottom).offset(20)
        }
        
        bodyContainer.addSubview(signupButton)
        signupButton.setTitle("회원가입", for: .normal)
        signupButton.setTitleColor(UIColor.black, for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        signupButton.addTarget(self, action: #selector(gotoSignupPage), for: .touchUpInside)
        signupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(15)
        }
        
        bodyContainer.addSubview(apiLoginArea)
        apiLoginArea.layer.cornerRadius = 10
        apiLoginArea.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signupButton.snp.bottom).offset(15)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
    }
    
    
    
    
}
