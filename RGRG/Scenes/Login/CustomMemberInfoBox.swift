//
//  CustomLoginCell.swift
//  RGRG
//
//  Created by kiakim on 2023/10/13.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import FirebaseFirestore


var pwBringValue: String = ""

class CustomMemberInfoBox : UIView {
    
    
    
    var passHandler:((Bool)->Void)?
    var conditon : String
    var cellHeightValue : Int
    var cellID: MemberInfoBox
    
    let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let inputBox = {
        let box = UITextField()
        box.autocapitalizationType = .none
        return box
    }()
    
    let conditionText = {
        let text = UILabel()
        text.isHidden = true
        return text
    }()
    
    let checkIcon = {
        let icon = UIImageView()
        icon.isHidden = true
        return icon
        
    }()
    
    let isSecureControllView = {
        let view = UIButton()
        view.isHidden = true
        return view
    }()
    
    let eyesIcon = {
        let icon = UIImageView()
        return icon
    }()
    
    let passMessage = {
        let text = UILabel()
        text.isHidden = true
        return text
        
    }()
    let duplicationLabel = {
        let button = UIButton()
        button.isHidden = true
        return button
    }()
    
    
    init(id:MemberInfoBox, conditionText:String? = nil, passText:String? = nil, placeHolder: String, condition: String, cellHeight:Int = 60 , style: String = "SignUp") {
        
        self.conditon = condition
        self.cellHeightValue = cellHeight
        self.conditionText.text = conditionText
        self.passMessage.text = passText
        self.inputBox.placeholder = placeHolder
        self.cellID = id
        super.init(frame: CGRect())
        setupUI()
        styleSort(style: style)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Method
    @objc func checkInputValue() {
        let inputText = inputBox.text ?? ""
        let cellID = self.cellID
        let validationCheck = isValid(text: inputText, condition: conditon)
        
        func updateUIvalid(validation: Bool) {
            if inputText.isEmpty {
                conditionText.isHidden = true
            }else if validation {
                //login page에서는 UIupdate 없이 true값만 전달해주기 .. !
                if [.loginEmail ,  .loginPW].contains(cellID){
                    passHandler?(true)
                }
                else{
                    checkIcon.isHidden = false
                    conditionText.isHidden = true
                    passHandler?(true)
                }
            } else {
                checkIcon.isHidden = true
                conditionText.isHidden = false
            }
        }
        
        switch cellID {
        case .loginEmail :
            updateUIvalid(validation: validationCheck)
        case .loginPW :
            self.inputBox.isSecureTextEntry = true
            isSecureControllView.isHidden = false
            updateUIvalid(validation: validationCheck)
        case .email:
            updateUIvalid(validation: validationCheck)
            checkIcon.isHidden = true
            duplicationLabel.isHidden = false
        case .pw:
            updateUIvalid(validation: validationCheck)
            savePasswordValue()
        case .pwCheck:
            let pwCheckInputValue = inputBox.text
            let pwCheckValue = pwBringValue == pwCheckInputValue
            updateUIvalid(validation: pwCheckValue)
        case .userName:
            updateUIvalid(validation: validationCheck)
            duplicationCheckUserName()
        }
    }
    
    func isValid(text:String, condition:String) -> Bool {
        let  condition = condition
        let compare = NSPredicate(format:"SELF MATCHES %@",  condition)
        return compare.evaluate(with: text)
    }
    
    //email 중복확인
    @objc func duplicationCheckEmail() {
        let email = inputBox.text ?? ""
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("오류 발생: \(error.localizedDescription)")
            } else {
                if let querySnapshot = querySnapshot {
                    let isDuplicate = !querySnapshot.isEmpty
                    if isDuplicate {
                        print("중복된 이메일이 이미 존재합니다.")
                    } else {
                        print("중복된 이메일이 없습니다. 사용 가능한 이메일입니다.")
                    }
                } else {
                    print("쿼리 스냅샷이 nil입니다.")
                }
            }
        }
    }
    
    func duplicationCheckUserName(){
        let userName = inputBox.text ?? ""
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("userName", isEqualTo: userName).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("오류 발생: \(error.localizedDescription)")
            } else {
                if let querySnapshot = querySnapshot {
                    let isDuplicate = !querySnapshot.isEmpty
                    if isDuplicate {
                        print("중복된 닉네임 이미 존재합니다.")
                    } else {
                        print("중복된 닉네임 없습니다. 사용 가능한 닉네임입니다.")
                        self.passMessage.isHidden = false
                        self.checkIcon.isHidden = true
                    }
                } else {
                    print("쿼리 스냅샷이 nil입니다.")
                }
            }
        }
    }
    
    func savePasswordValue (){
        if cellID == .pw {
            let pwValue = inputBox.text
            pwBringValue = pwValue ?? ""
        }
    }
    
    @objc func switchisSecure (){
        self.inputBox.isSecureTextEntry.toggle()
        
        self.eyesIcon.image = self.inputBox.isSecureTextEntry ? UIImage(systemName: "eye.slash") :            UIImage(systemName: "eye")
        
    }
    
    func styleSort(style : String){
        switch style {
        case "Login" :
            self.layer.borderColor = UIColor(hex: "279EFF").cgColor
            
        case "SignUp":
            self.layer.borderColor = UIColor.white.cgColor
            self.backgroundColor = UIColor.white
            self.inputBox.textColor = UIColor(hex: "505050")
            
            
        default:
            break
        }
    }
    
    //MARK: UI
    func setupUI(){
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.snp.makeConstraints { make in
            make.height.equalTo(cellHeightValue)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(25)
        }
        
        stackView.addArrangedSubview(inputBox)
        inputBox.addTarget(self, action: #selector(checkInputValue), for: .editingChanged)
        inputBox.attributedPlaceholder = NSAttributedString(string: inputBox.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "ADADAD")])
        inputBox.textColor = UIColor(hex: "FFFFFF")
        stackView.addArrangedSubview(conditionText)
        conditionText.textColor = UIColor.systemRed
        
        stackView.addArrangedSubview(checkIcon)
        checkIcon.image = UIImage(systemName: "checkmark")
        checkIcon.tintColor = UIColor.black
        checkIcon.contentMode = .scaleAspectFit
        checkIcon.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        
        stackView.addArrangedSubview(isSecureControllView)
        isSecureControllView.addTarget(self, action: #selector(switchisSecure), for: .touchUpInside)
        isSecureControllView.addSubview(eyesIcon)
        
        eyesIcon.image = UIImage(systemName: "eye.slash")
        eyesIcon.tintColor = UIColor.white
        eyesIcon.contentMode = .scaleAspectFit
        eyesIcon.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        stackView.addArrangedSubview(duplicationLabel)
        duplicationLabel.setTitle("중복확인", for: .normal)
        duplicationLabel.backgroundColor = UIColor.blue
        duplicationLabel.addTarget(self, action: #selector(duplicationCheckEmail), for: .touchUpInside)
        
        stackView.addArrangedSubview(passMessage)
        passMessage.textColor = UIColor.systemBlue
    }
    
    
    
}
