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
        box.font = UIFont(name: AppFontName.bold, size: 16)
        return box
    }()
    
    let conditionText = {
        let text = UILabel()
        text.isHidden = true
        text.font = UIFont(name: AppFontName.regular, size: 14)
        return text
    }()
    
    lazy var checkIcon = {
        let icon = UIImageView()
        icon.isHidden = true
        return icon
    }()
    
    let isSecureControllView = {
        let view = UIButton()
        view.isHidden = true
        return view
    }()
    
    lazy var eyesIcon = {
        let icon = UIImageView()
        return icon
    }()
    
    let passMessage = {
        let text = UILabel()
        text.isHidden = true
        text.font = UIFont(name: AppFontName.regular, size: 14)
        return text
    }()
    
    lazy var duplicationMessage = {
        let text = UILabel()
        text.isHidden = true
        text.font = UIFont(name: AppFontName.regular, size: 14)
        return text
    }()
    
    init(id:MemberInfoBox, conditionText:String? = nil, passText:String? = nil, placeHolder: String, condition: String, cellHeight:Int = 52 , style: String = "SignUp") {
        self.conditon = condition
        self.cellHeightValue = cellHeight
        self.conditionText.text = conditionText
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
        var cellID = self.cellID
        //유효성검사 [1]
        let validationCheck = isValid(text: inputText, condition: conditon)
        
        //유효성 검사값이 true이면 passHandler로 값을 저장 [3]
        func updateUIvalid(validation: Bool = validationCheck, passView: UIView? = nil, nonPassView:UIView? = nil) {
            if inputText.isEmpty {
                conditionText.isHidden = true
                passView?.isHidden = true
                nonPassView?.isHidden = true
                duplicationMessage.isHidden = true
                passHandler?(false)
            }else if validation {
                //pass
                switch cellID {
                case .email:
                    duplicationCheckEmail { [self] isUnique in
                        if isUnique {
                            passView?.isHidden = false
                            passMessage.text = "사용가능"
                            nonPassView?.isHidden = true
                            duplicationMessage.isHidden = true
                            passHandler?(true)
                        } else {
                            
                            passView?.isHidden = true
                            duplicationMessage.isHidden = false
                            duplicationMessage.text = "사용불가"
                            nonPassView?.isHidden = true
                            passHandler?(false)
                        }
                    }
                case .userName:
                    duplicationCheckUserName { [self] isUnique in
                        if isUnique {
                            passView?.isHidden = false
                            passMessage.text = "사용가능"
                            nonPassView?.isHidden = true
                            duplicationMessage.isHidden = true
                            passHandler?(true)
                        } else  {
                            passView?.isHidden = true
                            duplicationMessage.isHidden = false
                            duplicationMessage.text = "사용불가"
                            nonPassView?.isHidden = true
                            passHandler?(false)
                        }
                    }
                case .resetPW:
                    duplicationCheckEmail { [self] isUnique in
                        if isUnique {
                            //unique
                            passView?.isHidden = true
                            duplicationMessage.isHidden = false
                            duplicationMessage.text = "없는 계정"
                            nonPassView?.isHidden = true
                            passHandler?(false)
                           
                        } else {
                            //Not unique
                            passView?.isHidden = false
                            passMessage.text = "계정확인됨"
                            nonPassView?.isHidden = true
                            duplicationMessage.isHidden = true
                            passHandler?(true)
                            
                            // passHandler == true
                            // 위 메일주소로 메일을 발송할까요 ? 문구 뜨게
                        }
                    }
                    
                default :
                    passView?.isHidden = false
                    nonPassView?.isHidden = true
                    passHandler?(true)
                }
            } else {
                //nonPass
                passView?.isHidden = true
                nonPassView?.isHidden = false
                passHandler?(false)
            }
        }
        
        switch cellID {
        case .loginEmail :
            updateUIvalid(passView: self.checkIcon)
        case .loginPW :
            isSecureControllView.isHidden = false
            updateUIvalid(passView: self.checkIcon)
        case .email:
            updateUIvalid(passView: passMessage, nonPassView: self.conditionText)
        case .pw:
            isSecureControllView.isHidden = false
            updateUIvalid(passView: checkIcon, nonPassView: conditionText)
            savePasswordValue()
        case .pwCheck:
            isSecureControllView.isHidden = false
            let pwCheckInputValue = inputBox.text
            let pwCheckValue = pwBringValue == pwCheckInputValue
            updateUIvalid(validation: pwCheckValue, passView: checkIcon, nonPassView: conditionText)
        case .userName:
            updateUIvalid(passView: passMessage, nonPassView: self.conditionText)
        case .resetPW:
            //중복값이 있어야 의미가 있는 Line
            updateUIvalid(passView: passMessage)
        }
    }
    
    func isValid(text:String, condition:String) -> Bool {
        let  condition = condition
        let compare = NSPredicate(format:"SELF MATCHES %@",  condition)
        return compare.evaluate(with: text)
    }
    
    //email 중복확인 [2]
    func duplicationCheckEmail(completion: @escaping (Bool) -> Void) {
        let email = inputBox.text ?? ""
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("오류 발생: \(error.localizedDescription)")
                completion(false) // 에러가 발생한 경우 false 반환
            } else {
                if let querySnapshot = querySnapshot {
                    let isDuplicate = !querySnapshot.isEmpty
                    if isDuplicate {
                        completion(false) // 중복된 이메일이 있는 경우 false 반환
                    } else {
                        completion(true) // 중복된 이메일이 없는 경우
                    }
                } else {
                    completion(false) // 쿼리 스냅샷이 nil인 경우 false 반환
                }
            }
        }
    }
    
    func duplicationCheckUserName(completion: @escaping (Bool) -> Void) {
        let userName = inputBox.text ?? ""
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("userName", isEqualTo: userName).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("오류 발생: \(error.localizedDescription)")
                completion(false) // 에러가 발생한 경우 false 반환
            } else {
                if let querySnapshot = querySnapshot {
                    let isDuplicate = !querySnapshot.isEmpty
                    if isDuplicate {
                        completion(false) // 중복된 이메일이 있는 경우 false 반환
                    } else {
                        completion(true) // 중복된 이메일이 없는 경우
                    }
                } else {
                    completion(false) // 쿼리 스냅샷이 nil인 경우 false 반환
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
            self.layer.borderColor = UIColor.rgrgColor3.cgColor
            self.checkIcon.tintColor = UIColor.white
            self.eyesIcon.tintColor = UIColor.white
        case "SignUp":
            self.layer.borderColor = UIColor.white.cgColor
            self.backgroundColor = UIColor.white
            self.inputBox.textColor = UIColor(hex: "505050")
            self.eyesIcon.tintColor = UIColor.gray
        case "resetPW" :
            self.layer.borderColor = UIColor.rgrgColor3.cgColor
            self.inputBox.textColor = UIColor(hex: "505050")
        default:
            break
        }
    }
    
    //MARK: UI
    func setupUI(){
        self.addSubview(stackView)
        stackView.addArrangedSubview(inputBox)

        stackView.addArrangedSubview(conditionText)
        stackView.addArrangedSubview(isSecureControllView)
        stackView.addArrangedSubview(checkIcon)
        stackView.addArrangedSubview(passMessage)
        stackView.addArrangedSubview(duplicationMessage)
        isSecureControllView.addSubview(eyesIcon)
        
        self.setupShadow(alpha: 0.25, offset: CGSize(width: 2, height: 3), radius: 4, opacity: 0.5)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.snp.makeConstraints { make in
            make.height.equalTo(cellHeightValue)
        }
             
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(25)
        }
         
        inputBox.addTarget(self, action: #selector(checkInputValue), for: .editingChanged)
        inputBox.attributedPlaceholder = NSAttributedString(string: inputBox.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.rgrgColor7])
        inputBox.textColor = UIColor(hex: "FFFFFF")
       
        conditionText.textColor = UIColor.systemRed
        conditionText.textAlignment = .right
        conditionText.snp.makeConstraints { make in
            make.right.equalTo(isSecureControllView.snp.left).offset(-10)
            make.width.equalTo(110)
        }
        
        isSecureControllView.addTarget(self, action: #selector(switchisSecure), for: .touchUpInside)
        isSecureControllView.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        eyesIcon.image = UIImage(systemName: "eye.slash")
        eyesIcon.contentMode = .scaleAspectFit
        eyesIcon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        checkIcon.image = UIImage(systemName: "checkmark")
        checkIcon.tintColor = UIColor.gray
        checkIcon.contentMode = .scaleAspectFit
        checkIcon.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.left.equalTo(isSecureControllView.snp.right).offset(10)
        }
        
        passMessage.textColor = UIColor.systemBlue
        duplicationMessage.textColor = UIColor.systemRed
    }
}



