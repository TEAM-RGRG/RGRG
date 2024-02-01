//
//  CtaLargeButton.swift
//  RGRG
//
//  Created by kiakim on 2023/10/13.
//

import Foundation
import SnapKit
import UIKit

#warning("UI 코드 중복 제거 및 공용 컴포넌트 사용할 것")
// CtaLargeButton 은 무엇인가???
class CtaLargeButton: UIButton {
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFontName.bold, size: 15)
        return label
    }()
        
    init(titleText: String) {
        self.title.text = titleText
        super.init(frame: CGRect())
        self.setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.layer.cornerRadius = 10
        self.setupShadow(alpha: 0.25, offset: CGSize(width: 2, height: 3), radius: 4, opacity: 1)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        self.addSubview(self.title)
        self.title.textColor = UIColor.white
        self.title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
