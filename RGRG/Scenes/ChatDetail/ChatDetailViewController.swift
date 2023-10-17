//
//  ChatDetailViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import SnapKit
import UIKit
import SwiftUI

class ChatDetailViewController: UIViewController {
    let testButton = CustomButton(frame: .zero)

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ChatDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupButton()
    }
}

extension ChatDetailViewController {
    func setupButton() {
        view.addSubview(testButton)
        testButton.configureButton(title: "TEST", cornerValue: 10, backgroundColor: .systemBlue)
        testButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        testButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
    }

    @objc func tappedButton(_ sender: UIButton) {
        print("### \(#function)")
    }
}

// MARK: - SwiftUI Preview

@available(iOS 13.0, *)
struct ChatDetailViewControllerRepresentble: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ChatDetailViewControllerRepresentble>) {}

    func makeUIView(context: Context) -> UIView { ChatDetailViewController().view }
}

@available(iOS 13.0, *)
struct ChatDetailVCPreview: PreviewProvider {
    static var previews: some View { ChatDetailViewControllerRepresentble()
    }
}
