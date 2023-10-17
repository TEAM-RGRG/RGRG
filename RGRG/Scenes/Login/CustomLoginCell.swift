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
    var conditon : String
    var cellHeightValue : Int
    
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
    
    var cellID: String = ""

    
    @objc func checkContents() {
        let inputText = inputBox.text ?? ""
        let cellID = self.cellID
        let validationCheck = isValid(text: inputText, condition: conditon)
        
        func updateUI(validation: Bool) {
            if validationCheck {
                checkIcon.isHidden = false
                infoText.isHidden = true
            } else {
                checkIcon.isHidden = true
                infoText.isHidden = false
            }
        }

        switch cellID {
        case "ID", "nickName":
            updateUI(validation: validationCheck)
        case "PW":
            updateUI(validation: validationCheck)
            savePasswordValue()
        case "PWcheck":
            let pwCheckInputValue = inputBox.text
            let pwCheckValue = pwBringValue == pwCheckInputValue
            updateUI(validation: pwCheckValue)
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
        // pw 일치 여부 확인
        if cellID == "PW" {
            let pwValue = inputBox.text
            pwBringValue = pwValue ?? ""
            print("pwBringValue확인",pwBringValue)
        }
    }

    
    
    //MARK: UI
    func setupUI(){
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        //cellHeight값이 변하지 않는 Bug
        self.snp.makeConstraints { make in
            make.height.equalTo(cellHeightValue)
            
        }
        
        self.addSubview(stackView)
        //        stackView.backgroundColor = UIColor.systemPink
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-25)
        }
        
        stackView.addArrangedSubview(inputBox)
        inputBox.addTarget(self, action: #selector(checkContents), for: .editingChanged)
        
        stackView.addArrangedSubview(infoText)
        infoText.textColor = UIColor.red
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
