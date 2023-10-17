//
//  LoginViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    let bodyContainer = {
        let stactview = UIView()
        return stactview
    }()
    
    let mainImage = {
        let title = UIImageView()
        return title
    }()
    
    let idLine = {
        let line = CustomLoginCell(id:"LoginID", placeHolder: "ID", condition:"^[a-zA-Z0-9]{3,}$", cellHeight:70)
        return line
    }()
    
    let passwordLine = {
        let line = CustomLoginCell( id:"LoginPW",placeHolder: "Password", condition:"^[a-zA-Z0-9]{3,}$", cellHeight:70)
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
        
    }
    
    @objc func gotoSignupPage(){
        let signupVC = SignUpViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
        //        self.present(signupVC, animated: true)
    }
    
    
}


extension LoginViewController {
    func setupUI(){
        
        view.addSubview(bodyContainer)
        //        bodyStackContainer.axis = .vertical
        bodyContainer.layer.borderColor = UIColor.systemBlue.cgColor
        //        bodyStackContainer.layer.borderWidth = 1
        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            
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
        //        passwordLine.backgroundColor = UIColor.blue
        passwordLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(idLine.snp.bottom).offset(20)
        }
        
        bodyContainer.addSubview(loginButton)
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
        //                apiLoginArea.layer.borderWidth = 1
        apiLoginArea.layer.cornerRadius = 10
        apiLoginArea.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signupButton.snp.bottom).offset(15)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
    }
    
    
    
    
}
