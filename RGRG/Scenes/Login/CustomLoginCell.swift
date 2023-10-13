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
        return icon
    }()
    
  init(frame: CGRect, placeHolder: String) {
        super.init(frame: frame)
        setupUI()
        inputBox.placeholder = placeHolder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
