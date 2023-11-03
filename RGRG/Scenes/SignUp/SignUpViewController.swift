//
//  SignUpViewController.swift
//  RGRG
//
//  Created by kiakim on 2023/10/11.
//

import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SnapKit
import UIKit

class SignUpViewController: UIViewController {
    var idPass: Bool = false
    var pwPass: Bool = false
    var pwCheckPass: Bool = false
    var nickNamePass: Bool = false
    
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
        let line = CustomMemberInfoBox(id: .email, conditionText: "Email 형식 확인", passText: "사용가능 한 email입니다.", placeHolder: "Email", condition: "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+$")
        return line
    }()
    
    let passwordLine = {
        let line = CustomMemberInfoBox(id: .pw, conditionText: "영문 숫자 7자 이상", placeHolder: "Password", condition: "^[a-zA-Z0-9]{7,}$")
        line.inputBox.isSecureTextEntry = true
        return line
    }()
    
    let passwordCheckLine = {
        let line = CustomMemberInfoBox(id: .pwCheck, conditionText: "다시 확인해주세요", placeHolder: "Password Check", condition: "")
        line.inputBox.isSecureTextEntry = true
        return line
    }()
    
    let nickNameLine = {
        let line = CustomMemberInfoBox(id: .userName, conditionText: "영문 숫자 한글 2자 이상", passText: "사용가능한 닉네임입니다.", placeHolder: "닉네임", condition: "^[a-zA-Z0-9가-힣]{2,}$")
        return line
    }()
    
    let positionLine = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let tierButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let positionButton = {
        let button = UIButton()
        return button
    }()
    
    let signupButton = {
        let button = CtaLargeButton(titleText: "회원가입")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgrgColor5
        setupUI()
        passValueCheck()
        showTierSelector()
        showPositionSelector()
        
    }
}

extension SignUpViewController {
    @objc func tapSignUP() {
        // ture 값전달할 수 있도록 변경
        if idPass, pwPass, pwCheckPass, nickNamePass {
            createUser()
            movetoLogin()
        } else {
            showAlert(title: "not Yet", message: "필수항목 확인 필요")
        }
    }
    
    func createUser() {
        let email = emailLine.inputBox.text
        let password = passwordLine.inputBox.text
        let userName = nickNameLine.inputBox.text
        let tier = tierButton.titleLabel?.text
        let position = positionButton.titleLabel?.text
        
        Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { result, error in
            if let error = error {
                print("result", error)
            }
            
            if let result = result {
                print("result", result)
                
                let db = Firestore.firestore()
                let userUID = db.collection("users").document(result.user.uid)
                
                userUID.setData([
                    "email": email,
                    "userName": userName,
                    "tier": tier,
                    "position": position,
                    "profilePhoto": "Default",
                    "mostChampion" : ["None","None","None"] //Defaults 이미지
                    
                ]) { error in
                    if let error = error {
                        print("result : Error saving user data: \(error.localizedDescription)")
                    } else {
                        print("result : User data saved successfully.")
                    }
                }
            }
        }
    }
    
    func movetoLogin() {
        let movePage = LoginViewController()
        navigationController?.pushViewController(movePage, animated: true)
    }
    
    func showTierSelector(){
        let optionalClosure = {(action : UIAction) in
            print(action.title)}
        
        tierButton.menu = UIMenu( children : [
            UIAction(title : "Iron", state: .on, handler: optionalClosure),
            UIAction(title : "Bronze", state: .off, handler: optionalClosure),
            UIAction(title : "Silver", state: .off,  handler: optionalClosure),
            UIAction(title : "Gold", state: .off, handler: optionalClosure),
            UIAction(title : "Platinum", state: .off, handler: optionalClosure),
            UIAction(title : "Emerald", state: .off,  handler: optionalClosure),
            UIAction(title : "Diamond", state: .off, handler: optionalClosure),
            UIAction(title : "Master", state: .off, handler: optionalClosure),
            UIAction(title : "Grand Master", state: .off,  handler: optionalClosure),
            UIAction(title : "Challenger", state: .off,  handler: optionalClosure)
        ])
        
        tierButton.showsMenuAsPrimaryAction = true
        tierButton.changesSelectionAsPrimaryAction = true
        tierButton.setupShadow(alpha: 0.25, offset: CGSize(width: 2, height: 3), radius: 4, opacity: 0.5)
        tierButton.layer.borderColor = UIColor.rgrgColor6.cgColor
        tierButton.layer.borderWidth = 2

    }
    
    func showPositionSelector() {
        let optionalClosure = {(action : UIAction) in
            print(action.title)}
        
        positionButton.menu = UIMenu( children : [
            UIAction(title : "Top", state: .on,  handler: optionalClosure),
            UIAction(title : "Jungle", state: .off, handler: optionalClosure),
            UIAction(title : "Mid", state: .off, handler: optionalClosure),
            UIAction(title : "Bottom", state: .off,  handler: optionalClosure),
            UIAction(title : "Support", state: .off,  handler: optionalClosure)
        ])
        
        positionButton.showsMenuAsPrimaryAction = true
        positionButton.changesSelectionAsPrimaryAction = true
        positionButton.setupShadow(alpha: 0.25, offset: CGSize(width: 2, height: 3), radius: 4, opacity: 0.5)
        positionButton.layer.borderColor = UIColor.rgrgColor6.cgColor
        positionButton.layer.borderWidth = 2
    }
    
    func passValueCheck() {
        func updateUI() {
            guard idPass, pwPass, pwCheckPass, nickNamePass else {
                return signupButton.backgroundColor = UIColor.rgrgColor3
            }
            signupButton.backgroundColor = UIColor.black
        }
        
        // idPass값이 안바뀌는 것처럼 보이는건, ViewDidLoad에서 이미 그려졌기 때문
        // 클로져는 독립젹인 코드블럭이기에 이 안에서는 업데이트가 가능
        emailLine.passHandler = { pass in
            self.idPass = pass
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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
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
        positionLine.addArrangedSubview(tierButton)
        positionLine.addArrangedSubview(positionButton)
        
        //        bodyContainer.layer.borderWidth = 1
        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
            //            make.centerY.equalToSuperview()
        }
        
        imageArea.backgroundColor = UIColor.rgrgColor6
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
        
        positionLine.spacing = 20
        positionLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nickNameLine.snp.bottom).offset(20)
            make.height.equalTo(60)
        }
        
        tierButton.layer.cornerRadius = 10
        tierButton.backgroundColor = UIColor.white
        tierButton.setTitleColor(UIColor.black, for: .normal)
        
        tierButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.2)
        }
        
        positionButton.layer.cornerRadius = 10
        positionButton.backgroundColor = UIColor.white
        positionButton.setTitleColor(UIColor.black, for: .normal)
        positionButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.2)
        }
        
        signupButton.addTarget(self, action: #selector(tapSignUP), for: .touchUpInside)
        signupButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
    }
}
