//
//  CustomTextView.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/31/23.
//

import UIKit

final class CustomTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextView {
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
        self.contentInset.top = topCorrect
    }
}
