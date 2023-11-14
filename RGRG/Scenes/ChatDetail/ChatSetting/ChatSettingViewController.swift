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

    var thread: String?
    
    let topBaseView = UIView(frame: .zero)
    let lineView = UIView(frame: .zero)
    
    let blockView = UIView(frame: .zero)
    let blockIcon = CustomImageView(frame: .zero)
    let blockLabel = CustomLabel(frame: .zero)
    
    let exitView = UIView(frame: .zero)
    let exitIcon = CustomImageView(frame: .zero)
    let exitLabel = CustomLabel(frame: .zero)
    
    let cancelView = UIView(frame: .zero)
    let cancelLabel = CustomLabel(frame: .zero)
}

extension ChatSettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.custom(resolver: { _ in
                self.setupUI()
                return 201
            })]
        }
    }
}

extension ChatSettingViewController {
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#F1F1F1")
        addView()
        setupView()
        confirms()
    }
    
    func addView() {
        view.addSubview(topBaseView)
        view.addSubview(cancelView)
        
        topBaseView.addSubview(blockView)
        topBaseView.addSubview(exitView)
        topBaseView.addSubview(lineView)
        
        blockView.addSubview(blockIcon)
        blockView.addSubview(blockLabel)
        
        exitView.addSubview(exitIcon)
        exitView.addSubview(exitLabel)

        cancelView.addSubview(cancelLabel)
    }
    
    func confirms() {
        confirmBlock()
        confirmExit()
        confirmCancel()
    }
}

extension ChatSettingViewController {
    func setupView() {
        confirmTopBaseView()
        confirmBlockView()
        confirmExitView()
        confirmLineView()
        confirmCancelView()
    }
    
    func confirmTopBaseView() {
        topBaseView.backgroundColor = UIColor(hex: "#FFFFFF")
        topBaseView.layer.cornerRadius = 10
        
        topBaseView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(16)
            make.height.equalTo(101)
        }
    }
    
    func confirmBlockView() {
        blockView.backgroundColor = UIColor(hex: "#FFFFFF")
        blockView.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBlockView))
        blockView.addGestureRecognizer(tapGesture)
        
        blockView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func confirmExitView() {
        exitView.backgroundColor = UIColor(hex: "#FFFFFF")
        exitView.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedExitView))
        exitView.addGestureRecognizer(tapGesture)
        
        exitView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func confirmLineView() {
        lineView.backgroundColor = UIColor(hex: "#F7F8FA")
        lineView.layer.cornerRadius = 0.1
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(blockView.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(13)
            make.height.equalTo(1)
        }
    }
    
    func confirmCancelView() {
        cancelView.backgroundColor = UIColor(hex: "#FFFFFF")
        cancelView.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCancelView))
        cancelView.addGestureRecognizer(tapGesture)
        
        cancelView.snp.makeConstraints { make in
            make.top.equalTo(topBaseView.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(16)
            make.height.equalTo(50)
        }
    }
}

extension ChatSettingViewController {
    func confirmBlock() {
        comfirmBlockIcon()
        confirmBlockLabel()
    }
    
    func comfirmBlockIcon() {
        blockIcon.image = UIImage(named: "blockIcon")
        
        blockIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(blockView).offset(19)
            make.width.height.greaterThanOrEqualTo(24)
        }
    }
    
    func confirmBlockLabel() {
        blockLabel.settingText("차단하기")
        blockLabel.font = UIFont(name: "NotoSansKR-VariableFont_wght", size: 17)
        blockLabel.textColor = UIColor(hex: "#FF0000")
        
        blockLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(blockView).offset(52)
            make.width.equalTo(120)
            make.height.equalTo(22)
        }
    }
}

extension ChatSettingViewController {
    func confirmExit() {
        confirmExitIcon()
        confirmExitLabel()
    }
    
    func confirmExitIcon() {
        exitIcon.image = UIImage(named: "exitIcon")
        
        exitIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(exitView).offset(19)
            make.width.height.greaterThanOrEqualTo(24)
        }
    }
    
    func confirmExitLabel() {
        exitLabel.settingText("채팅방 나가기")
        exitLabel.font = UIFont(name: "NotoSansKR-VariableFont_wght", size: 17)
        exitLabel.textColor = UIColor(hex: "#000000")
        
        exitLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(exitView).offset(52)
            make.width.equalTo(120)
            make.height.equalTo(22)
        }
    }
}

extension ChatSettingViewController {
    func confirmCancel() {
        confirmCancelLabel()
    }
    
    func confirmCancelLabel() {
        cancelLabel.settingText("취소")
        cancelLabel.textAlignment = .center
        cancelLabel.font = UIFont(name: "NotoSansKR-VariableFont_wght", size: 17)
        cancelLabel.textColor = UIColor(hex: "#000000")
        
        cancelLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(22)
        }
    }
}

extension ChatSettingViewController {
    @objc func tappedBlockView() {
        print("### \(#function)")
    }
    
    @objc func tappedExitView() {
        print("### \(#function)")
        
        if thread != nil {
            FireStoreManager.shared.deleteChannel(thread: thread ?? "n/a", completion: {
                guard let presentingViewController = self.presentingViewController as? UINavigationController else { return }
                let vc = ChatListViewController()
                presentingViewController.popViewController(animated: true)
                self.dismiss(animated: true)
            })
        }
    }
    
    @objc func tappedCancelView() {
        print("### \(#function)")
        dismiss(animated: true)
    }
}
