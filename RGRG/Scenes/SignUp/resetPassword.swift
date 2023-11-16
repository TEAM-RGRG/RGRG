//
//  resetPassword.swift
//  RGRG
//
//  Created by kiakim on 11/7/23.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth


class resetPassword: UIViewController {
    
    var emailPass: Bool = false
    
    let bodyContainer = {
        let view = UIView()
        return view
    }()
    let emailLabel = {
        let label = UILabel()
        label.text = "Email을 입력해주세요"
        return label
    }()
    let emailLine = {
        let line = CustomMemberInfoBox(id: .resetPW, conditionText: "Email 형식 확인", passText: "사용가능 한 email입니다.", placeHolder: "Email", condition: "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+$", style: "resetPW")
        return line
    }()

    let sendButton = {
        let button = CtaLargeButton(titleText: "이 주소로 메일을 발송할까요 ?")
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        title = "비밀번호 찾기"
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgrgColor5
        setupUI()
        checkEmailPass()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
       
    }
    
    func checkEmailPass(){
        emailLine.passHandler = { pass in
            self.emailPass = pass
            self.sendButton.isHidden = pass ? false : true
            // 애니메이션 효과 넣어주고싶다 .. !
        }
    }
    
    @objc func sendResetPWemail(){
        let userEmail = emailLine.inputBox.text
        print("check", userEmail) // 옵셔널이니까 언래핑 후 사용해야겠다.
        
        Auth.auth().sendPasswordReset(withEmail: userEmail ?? "") { error in
            if let error = error {
                print("비밀번호 재설정 이메일 보내기 오류: \(error.localizedDescription)")
            } else {
                print("\(userEmail) 주소로 비밀번호 재설정 이메일이 전송되었습니다.")
                self.showAlert(title: "이메일이 발송되었습니다", message: "")
                
            }
        }
        
        
    }
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


extension resetPassword {
    func setupUI(){
        view.addSubview(bodyContainer)
        bodyContainer.addSubview(emailLabel)
        bodyContainer.addSubview(emailLine)
        bodyContainer.addSubview(sendButton)
        

        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(2)
            make.left.equalToSuperview().offset(51)
            make.right.equalToSuperview().inset(51)
            make.centerY.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.right.equalToSuperview()
        }
        
        emailLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        
        sendButton.backgroundColor = UIColor.rgrgColor3
        sendButton.addTarget(self, action: #selector(sendResetPWemail), for: .touchUpInside)
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(emailLine.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
        }
        
    }
}
