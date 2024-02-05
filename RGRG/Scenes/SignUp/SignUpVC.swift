//  SignUpVC.swift
//  RGRG
//  Created by kiakim on 2023/10/11.

import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SnapKit
import UIKit

var checkValue = false // 얜 왜 여깄음?

#warning("UI 코드 중복 제거 및 공용 컴포넌트 사용할 것")
class SignUpVC: UIViewController {
    var idPass: Bool = false
    var pwPass: Bool = false
    var pwCheckPass: Bool = false
    var nickNamePass: Bool = false
  
    let bodyContainer = {
        // scrollView
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
        let line = CustomMemberInfoBox(id: .email, conditionText: "Email 형식 확인", passText: "", placeHolder: "Email", condition: "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+$")
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
    
    let privacyArea = {
        let view = UIView()
        return view
    }()
    
    let centerContainer = {
        let view = UIButton()
        return view
    }()
    
    let checkArea = {
        let button = UIButton()
        return button
    }()
    
    let checkIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "square")
        view.tintColor = UIColor.black
        return view
    }()
    
    let privacyButton = {
        let button = UIButton()
        return button
    }()

    let privacyLabel = {
        let label = UILabel()
        return label
    }()
    
    let signupButton = {
        let button = CtaLargeButton(titleText: "가입하기")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .rgrgColor4
        view.backgroundColor = UIColor.rgrgColor5
        setupUI()
        passValueCheck()
        showTierSelector()
        showPositionSelector()
        setupKeyboardEvent()
        hideKeyboardEvent()
    }
}

extension SignUpVC {
    @objc func tapSignUP() {
        if idPass, pwPass, pwCheckPass, nickNamePass {
            emailConfirmAlert(title: "이메일 사용 확인", message: "password 확인 시 \n 현재 이메일 주소가 사용됩니다")
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
                    "mostChampion": ["None", "None", "None"], // Defaults 이미지
                    "uid": result.user.uid,
                    "iBlocked": [],
                    "youBlocked": []
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
        let movePage = LoginVC()
        navigationController?.pushViewController(movePage, animated: true)
    }
    
    func showTierSelector() {
        let optionalClosure = { (action: UIAction) in
            print(action.title)
        }
        
        tierButton.menu = UIMenu(children: [
            UIAction(title: "Iron", state: .on, handler: optionalClosure),
            UIAction(title: "Bronze", state: .off, handler: optionalClosure),
            UIAction(title: "Silver", state: .off, handler: optionalClosure),
            UIAction(title: "Gold", state: .off, handler: optionalClosure),
            UIAction(title: "Platinum", state: .off, handler: optionalClosure),
            UIAction(title: "Emerald", state: .off, handler: optionalClosure),
            UIAction(title: "Diamond", state: .off, handler: optionalClosure),
            UIAction(title: "Master", state: .off, handler: optionalClosure),
            UIAction(title: "Grand Master", state: .off, handler: optionalClosure),
            UIAction(title: "Challenger", state: .off, handler: optionalClosure)
        ])
        
        tierButton.showsMenuAsPrimaryAction = true
        tierButton.changesSelectionAsPrimaryAction = true
        tierButton.setupShadow(alpha: 0.25, offset: CGSize(width: 2, height: 3), radius: 4, opacity: 0.5)
        tierButton.layer.borderColor = UIColor.rgrgColor6.cgColor
        tierButton.layer.borderWidth = 2
    }
    
    func showPositionSelector() {
        let optionalClosure = { (action: UIAction) in
            print(action.title)
        }
        
        positionButton.menu = UIMenu(children: [
            UIAction(title: "Top", state: .on, handler: optionalClosure),
            UIAction(title: "Jungle", state: .off, handler: optionalClosure),
            UIAction(title: "Mid", state: .off, handler: optionalClosure),
            UIAction(title: "Bottom", state: .off, handler: optionalClosure),
            UIAction(title: "Support", state: .off, handler: optionalClosure)
        ])
        
        positionButton.showsMenuAsPrimaryAction = true
        positionButton.changesSelectionAsPrimaryAction = true
        positionButton.setupShadow(alpha: 0.25, offset: CGSize(width: 2, height: 3), radius: 4, opacity: 0.5)
        positionButton.layer.borderColor = UIColor.rgrgColor6.cgColor
        positionButton.layer.borderWidth = 2
    }
    
    func updateUIButton() {
        guard idPass, pwPass, pwCheckPass, nickNamePass, checkValue else {
            return signupButton.backgroundColor = UIColor.rgrgColor7
        }
        signupButton.backgroundColor = UIColor.rgrgColor3
    }
    
    func passValueCheck() {
        emailLine.passHandler = { pass in
            self.idPass = pass
            self.updateUIButton()
        }
        passwordLine.passHandler = { pass in
            self.pwPass = pass
            self.updateUIButton()
        }
        passwordCheckLine.passHandler = { pass in
            self.pwCheckPass = pass
            self.updateUIButton()
        }
        nickNameLine.passHandler = { pass in
            self.nickNamePass = pass
            self.updateUIButton()
        }
    }
    
    func conditionAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func emailConfirmAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "가입하기", style: .default) { _ in
            self.createUser()
            self.movetoLogin()
        }
        let cancleAction = UIAlertAction(title: "취소", style: .default, handler: nil)
      
        alertController.addAction(cancleAction)
        alertController.addAction(okAction)
     
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func tapPrivarcy() {
        let PersonalInfoViewControllerVC = PersonalInfoVC()
        
        PersonalInfoViewControllerVC.chekcHandler = { [weak self] _ in
            self?.checkIcon.image = checkValue ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
            self?.updateUIButton()
        }
        
        navigationController?.pushViewController(PersonalInfoViewControllerVC, animated: true)
    }
}

extension SignUpVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willShowKeyboard),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willHideKeyboard),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc func willShowKeyboard(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardHeight - 180
        }
    }

    @objc func willHideKeyboard(_ notification: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    func hideKeyboardEvent() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.dismissKeyboardSignup))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardSignup() {
        view.endEditing(true)
    }
}

extension SignUpVC {
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
        methodArea.addArrangedSubview(privacyArea)
        privacyArea.addSubview(centerContainer)
        centerContainer.addSubview(checkArea)
        checkArea.addSubview(checkIcon)
        centerContainer.addSubview(privacyButton)
        privacyButton.addSubview(privacyLabel)
        methodArea.addArrangedSubview(signupButton)
        positionLine.addArrangedSubview(tierButton)
        positionLine.addArrangedSubview(positionButton)
        
        privacyButton.addTarget(self, action: #selector(tapPrivarcy), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(tapSignUP), for: .touchUpInside)
        
        bodyContainer.layer.cornerRadius = 10
        bodyContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(51)
            make.right.equalToSuperview().inset(51)
        }
        
        imageArea.layer.cornerRadius = 10
        imageArea.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(83)
        }
        
        mainImage.image = UIImage(named: "SignupMain")
        mainImage.contentMode = .center
        mainImage.snp.makeConstraints { make in
            make.width.equalTo(imageArea.snp.width).multipliedBy(0.8)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        methodArea.spacing = 15
        methodArea.distribution = .fillProportionally
        methodArea.snp.makeConstraints { make in
            make.top.equalTo(imageArea.snp.bottom).offset(15)
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
            make.height.equalTo(52)
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
        
        privacyArea.contentMode = .center
        privacyArea.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        centerContainer.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
     
        checkArea.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }

        checkIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        privacyButton.snp.makeConstraints { make in
            make.left.equalTo(checkArea.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        privacyLabel.text = "개인정보처리방침"
        privacyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        signupButton.backgroundColor = UIColor.rgrgColor7
        signupButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
    }
}
