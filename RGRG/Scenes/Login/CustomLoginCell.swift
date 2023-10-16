//
//  CustomLoginCell.swift
//  RGRG
//
//  Created by kiakim on 2023/10/13.
//

import Foundation
import UIKit
import SnapKit

class CustomLoginCell : UIView {
    
    var useConditon = ""
    
    let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let inputBox = {
        let box = UITextField()
        return box
    }()
    
    let checkIcon = {
        let icon = UIImageView()
        icon.isHidden = true
        return icon
        
    }()
    
    init(placeHolder: String, condition: String) {
        super.init(frame: CGRect())
        setupUI()
        self.useConditon = condition
        inputBox.placeholder = placeHolder
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Action
    
    //PWcheck의 경우 다르게 처리해주기
    @objc func checkContents(){
        let text = inputBox.text ?? ""
        let check = isValid(text: text, condition: useConditon)
        check ? ( checkIcon.isHidden = false):(  checkIcon.isHidden = true)
    }
    
    func isValid(text:String, condition:String) -> Bool {
        let  condition = condition
        let compare = NSPredicate(format:"SELF MATCHES %@",  condition)
        return compare.evaluate(with: text)
    }
    
    
    //MARK: UI
    func setupUI(){
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.snp.makeConstraints { make in
            make.height.equalTo(70)
            
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
