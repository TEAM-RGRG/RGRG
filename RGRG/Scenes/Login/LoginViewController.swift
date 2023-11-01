//
//  LoginViewController.swift
//  RGRG
//
//  Created by kiakim iMac on 2023/10/11.
//

import FirebaseAuth
import FirebaseCore
import SnapKit
import UIKit

enum MemberInfoBox: String {
    case loginEmail
    case loginPW
    case email
    case pw
    case pwCheck
    case userName
}

class LoginViewController: UIViewController {
    var loginIdPass: Bool = false
    var loginPwPass: Bool = false
    
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
        
    let emailLine = {
        let line = CustomMemberInfoBox(id: .loginEmail, placeHolder: "Email", condition: "^[A-Za-z0-9+_.-]+@(.+)$", cellHeight: 70, style: "Login")
        return line
    }()
    
    let passwordLine = {
        let line = CustomMemberInfoBox(id: .loginPW, placeHolder: "Password", condition: "^[a-zA-Z0-9]{7,}$", cellHeight: 70, style: "Login")
//        line.inputBox.isSecureTextEntry = true
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
    
    // 오버라이딩 : 재정의
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgrgColor4
        
        emailLine.inputBox.text = "test123@123.com"
        passwordLine.inputBox.text = "test1234"
        
        setupUI()
        passValueCheck()
        makeBackButton()
    }
}

extension LoginViewController {
    @objc func gotoSignupPage() {
        let signupVC = SignUpViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc func tapLogin() {
        signInUser()
    }
    
    func signInUser() {
        let email = emailLine.inputBox.text ?? ""
        let password = passwordLine.inputBox.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
            if authResult == nil {
                if self.loginIdPass, self.loginPwPass {
                    showAlert(title: "로그인 실패", message: "일치하는 회원정보가 없습니다.")
                } else {
                    showAlert(title: "", message: "작성 형식을 확인해주세요")
                }
                if let errorCode = error {
                    print(errorCode)
                }
            } else if authResult != nil {
                moveToMain()
            }
        }
    }
    
    func moveToMain() {
        let movePage = TabBarController()
        navigationController?.pushViewController(movePage, animated: true)
    }
    
    func passValueCheck() {
        emailLine.passHandler = { pass in
            self.loginIdPass = pass
            print("loginIdPass", self.loginIdPass)
        }
        passwordLine.passHandler = { pass in
            self.loginPwPass = pass
            print("loginPwPass", self.loginPwPass)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
    
        present(alertController, animated: true, completion: nil)
    }
    
    func setupUI() {
        // bodyContainer의 높이를 알수는 없는걸까 ?
        //        let  screenHeigth = UIScreen.main.bounds.height
        //        let bodyContainerHeigth = bodyContainer.frame.height
        //
        //        print("screenHeigth",screenHeigth)
        //        print("bodyContainerHeigt",bodyContainerHeigth)
        
        view.addSubview(bodyContainer)
        bodyContainer.addSubview(imageArea)
        imageArea.addSubview(mainImage)
        bodyContainer.addSubview(methodArea)
        methodArea.addArrangedSubview(emailLine)
        methodArea.addArrangedSubview(passwordLine)
        loginButton.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
        methodArea.addArrangedSubview(loginButton)
        methodArea.addArrangedSubview(signupButton)
        
        //        bodyContainer.layer.borderWidth = 1
        //        bodyContainer.layer.borderColor = UIColor.systemBlue.cgColor
        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(45)
            make.right.equalToSuperview().inset(45)
        }
        
        //        imageArea.layer.borderWidth = 1
        imageArea.layer.borderColor = UIColor.systemGray5.cgColor
        imageArea.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        //        mainImage.layer.borderWidth = 1
        mainImage.layer.borderColor = UIColor.systemGray5.cgColor
        mainImage.image = UIImage(named: "LoginMain")
        mainImage.contentMode = .scaleAspectFit
        mainImage.snp.makeConstraints { make in
            //            make.top.equalToSuperview().offset(100)
            make.height.equalToSuperview().dividedBy(2)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().inset(60)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        //        methodArea.backgroundColor = UIColor.systemBlue
        methodArea.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        emailLine.snp.makeConstraints { make in
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
        
        let attributedTitle = NSAttributedString(string: "회원가입", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        signupButton.setAttributedTitle(attributedTitle, for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        signupButton.addTarget(self, action: #selector(gotoSignupPage), for: .touchUpInside)
        signupButton.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(10)
            make.bottom.equalTo(bodyContainer.snp.bottom).offset(-60)
        }
    }
}

extension LoginViewController {
    func makeBackButton() {
        let backButton = CustomBackButton(title: "Back", style: .plain, target: self, action: #selector(tappedBackButton))
        navigationItem.backBarButtonItem = backButton
    }

    @objc func tappedBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
