//
//  CustomLoginCell.swift
//  RGRG
//
//  Created by kiakim on 2023/10/13.
//

import Foundation
import UIKit
import SnapKit


var pwBringValue: String = ""


class CustomLoginCell : UIView {
    //저장속성
    var passHandler:((Bool)->Void)?
    var conditon : String
    var cellHeightValue : Int
    var cellID: String = ""
    
    let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let inputBox = {
        let box = UITextField()
        return box
    }()
    
    let infoText = {
        let text = UILabel()
        text.isHidden = true
        return text
    }()
    
    let checkIcon = {
        let icon = UIImageView()
        icon.isHidden = true
        return icon
        
    }()
    
    
    
    
    
    init(id:String, infoText:String? = nil, placeHolder: String, condition: String, cellHeight:Int = 60) {
        
        self.conditon = condition
        self.cellHeightValue = cellHeight //200
        self.infoText.text = infoText
        self.inputBox.placeholder = placeHolder
        self.cellID = id
        //super.init ? override 랑 다른점
        super.init(frame: CGRect())
        setupUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Action
    
    
    
    @objc func checkContents() {
        let inputText = inputBox.text ?? ""
        let cellID = self.cellID
        let validationCheck = isValid(text: inputText, condition: conditon)
        
        
        func updateUIvalid(validation: Bool) {
            if inputText.isEmpty {
                infoText.isHidden = true
            }else if validation {
                checkIcon.isHidden = false
                infoText.isHidden = true
                passHandler?(true)
            } else {
                checkIcon.isHidden = true
                infoText.isHidden = false
            }
        }
        
        switch cellID {
        case "ID", "nickName":
            updateUIvalid(validation: validationCheck)
        case "PW":
            updateUIvalid(validation: validationCheck)
            savePasswordValue()
        case "PWcheck":
            let pwCheckInputValue = inputBox.text
            let pwCheckValue = pwBringValue == pwCheckInputValue
            updateUIvalid(validation: pwCheckValue)
            print("pwBringValue",pwBringValue)
            print("InputValue",pwCheckInputValue)
            print("pwCheckValue",pwCheckValue)
        case "LoginID","LoginPW" :
            updateUIvalid(validation: validationCheck)
            
        default:
            break
        }
        
        
    }
    func isValid(text:String, condition:String) -> Bool {
        let  condition = condition
        let compare = NSPredicate(format:"SELF MATCHES %@",  condition)
        return compare.evaluate(with: text)
    }
    
    func savePasswordValue (){
        if cellID == "PW" {
            let pwValue = inputBox.text
            pwBringValue = pwValue ?? ""
        }
    }
    
    
    
    //MARK: UI
    func setupUI(){
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.snp.makeConstraints { make in
            make.height.equalTo(cellHeightValue)
            
        }
        
        self.addSubview(stackView)
        //        stackView.backgroundColor = UIColor.systemPink
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(25)
        }
        
        stackView.addArrangedSubview(inputBox)
        inputBox.addTarget(self, action: #selector(checkContents), for: .editingChanged)
        
        stackView.addArrangedSubview(infoText)
        infoText.textColor = UIColor.systemRed
        //        infoText.text = "ddddd"
        
        
        stackView.addArrangedSubview(checkIcon)
        checkIcon.image = UIImage(systemName: "checkmark")
        checkIcon.tintColor = UIColor.black
        checkIcon.contentMode = .scaleAspectFit
        //        checkIcon.layer.borderWidth = 1
        checkIcon.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        
        
    }
    
}
