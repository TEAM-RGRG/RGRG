//
//  ChatSettingViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/27/23.
//

import SnapKit
import UIKit

class ChatSettingViewController: UIViewController {
    static let identifier = "ChatSettingViewController"

    var blockIcon = CustomImageView(frame: .zero)
    var exitIcon = CustomImageView(frame: .zero)

    var cancelButton = CustomButton(frame: .zero)

    var baseView = UIView(frame: .zero)
    var baseSubView = UIView(frame: .zero)
    var subView = UIView(frame: .zero)
    var lineView = UIView(frame: .zero)
}

extension ChatSettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.custom(resolver: { _ in

                return 207
            })]
        }
    }
}

extension ChatSettingViewController {
    func setupUI() {
        confirmBaseView()
        confirmBaseSubView()
        confirmLineView()
        confirmBlockIcon()
        confirmExitIcon()
        confirmSubView()
        confirmCancelButton()
    }
}

extension ChatSettingViewController {
    func confirmBaseView() {
        view.addSubview(baseView)
        baseView.backgroundColor = .white

        baseView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.height.equalTo(51)
        }
    }

    func confirmBaseSubView() {
        view.addSubview(baseSubView)
        baseSubView.backgroundColor = .white

        baseSubView.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.bottom)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.height.equalTo(50)
        }
    }

    func confirmLineView() {
        baseView.addSubview(lineView)
        lineView.backgroundColor = .black

        lineView.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(13)
            make.trailing.equalToSuperview().inset(-13)
            make.height.equalTo(0.1)
//            make.width.equalTo(336)
        }
    }
}

extension ChatSettingViewController {
    func confirmBlockIcon() {
        baseView.addSubview(blockIcon)
        blockIcon.image = UIImage(systemName: "bell")
        blockIcon.tintColor = .red

//        blockIcon.snp.makeConstraints { make in
//            make.top.equalTo(baseView).offset(14)
//            make.leading.equalTo(baseView).offset(19)
//            make.width.height.equalTo(24)
//        }
    }

    func confirmExitIcon() {
        baseView.addSubview(exitIcon)
        exitIcon.image = UIImage(systemName: "bell")
        exitIcon.tintColor = .black

//        exitIcon.snp.makeConstraints { make in
//            make.leading.equalTo(baseView).offset(19)
//            make.bottom.equalTo(baseView).offset(-12)
//            make.width.height.equalTo(24)
//        }
    }
}

extension ChatSettingViewController {}

extension ChatSettingViewController {
    func confirmSubView() {
        view.addSubview(subView)
        subView.backgroundColor = .clear
        subView.layer.cornerRadius = 10

//        subView.snp.makeConstraints { make in
//            make.height.equalTo(50)
//            make.top.equalTo(baseView.snp.bottom).offset(14)
//            make.leading.equalTo(view).offset(16)
//            make.trailing.equalTo(view).offset(-16)
//        }
    }

    func confirmCancelButton() {
        subView.addSubview(cancelButton)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.backgroundColor = .white
        cancelButton.layer.cornerRadius = 10

//        cancelButton.snp.makeConstraints { make in
//            make.top.bottom.leading.trailing.equalToSuperview()
//        }
    }
}
