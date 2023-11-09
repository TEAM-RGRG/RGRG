//
//  CtaLarge.swift
//  RGRG
//
//  Created by kiakim on 2023/10/13.
//

import Foundation
import UIKit
import SnapKit

class CtaLargeButton : UIButton {
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFontName.bold, size: 15)
        return label
    }()
        
 init(titleText: String) {
        self.title.text = titleText
        super.init(frame:  CGRect())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.layer.cornerRadius = 10


        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        self.addSubview(title)
        title.textColor = UIColor.white
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

}

