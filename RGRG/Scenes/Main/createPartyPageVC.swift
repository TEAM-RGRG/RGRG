//
//  createPartyPageVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/18.
//


import Foundation
import SnapKit
import UIKit



class CreatePartyVC: UIViewController, UITextViewDelegate {
    
    let topFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let partyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let partyNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.placeholder = "제목"
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "구하는 포지션"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let positionFramView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    let topPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("탑", for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .bottom
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "탑w"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8 ,bottom: 8, right: 8)
//        button.tintColor = UIColor.white
        button.backgroundColor = .systemGray4
//        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.layer.cornerRadius = 30
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let junglePositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "정글w"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8 ,bottom: 8, right: 8)
//        button.tintColor = UIColor.white
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 30
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let midPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "미드w"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8 ,bottom: 8, right: 8)
//        button.tintColor = UIColor.white
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 30
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let bottomPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "바텀w"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8 ,bottom: 8, right: 8)
//        button.tintColor = UIColor.white
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 30
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let supportPositionbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        button.setTitle("알림 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "서폿w"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8 ,bottom: 8, right: 8)
//        button.tintColor = UIColor.white
        button.backgroundColor = .systemGray4
//        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 30
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let infoTextLabel: UILabel = {
        let label = UILabel()
        label.text = "소개글"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    let infoTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textView.layer.cornerRadius = 10
        textView.text = ""
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("작성 완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
        button.layer.cornerRadius = (12)
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    

         
    
    var positionOptionButtonArry = [UIButton]()
    
    @objc func positionOptionButtonTapped(_ sender: UIButton) {
        for Btn in positionOptionButtonArry {
            if Btn == sender {
                // 만약 현재 버튼이 이 함수를 호출한 버튼이라면
                Btn.isSelected = true
                Btn.backgroundColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
                Btn.layer.borderColor = UIColor.rgrgColor3.cgColor
            }
                else {
                // 이 함수를 호출한 버튼이 아니라면
                Btn.isSelected = false
                Btn.backgroundColor = .systemGray4
                    Btn.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    
    func addPlaceholderToTextView() {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "짧은 게시글 내용을 작성해주세요.\n( 최대 500자 )"
        placeholderLabel.textColor = .systemGray3
        placeholderLabel.font = infoTextView.font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 10, y: infoTextView.textContainerInset.top)
        placeholderLabel.tag = 100
        
        infoTextView.addSubview(placeholderLabel)

        // 텍스트 뷰에 터치 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        infoTextView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap() {
        infoTextView.viewWithTag(100)?.isHidden = true

        infoTextView.isEditable = true
        infoTextView.becomeFirstResponder()
    }

    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            infoTextView.viewWithTag(100)?.isHidden = true
        }
    }

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           let maxLength = 500
           let currentText = textView.text
        let newText = (currentText as! NSString).replacingCharacters(in: range, with: text)

           return newText.count <= maxLength
       }

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "RG구하기"
        
        configureUI()
        addPlaceholderToTextView()
        
        
        positionOptionButtonArry.append(topPositionbutton)
        positionOptionButtonArry.append(junglePositionbutton)
        positionOptionButtonArry.append(midPositionbutton)
        positionOptionButtonArry.append(bottomPositionbutton)
        positionOptionButtonArry.append(supportPositionbutton)
    }
    
    
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func configureUI() {
        view.backgroundColor = .systemGray5
        
        view.addSubview(topFrame)
//        view.addSubview(pageTitleLabel)
//        view.addSubview(backButton)
        view.addSubview(partyNameLabel)
        view.addSubview(partyNameTextField)
        view.addSubview(positionLabel)
//        view.addSubview(listUnderline)
//        view.addSubview(tierFramView)
//        tierFramView.addArrangedSubview(tierPopupButton)
        view.addSubview(positionFramView)
//        positionFramView.addArrangedSubview(positionLabel)
        positionFramView.addArrangedSubview(topPositionbutton)
        positionFramView.addArrangedSubview(junglePositionbutton)
        positionFramView.addArrangedSubview(midPositionbutton)
        positionFramView.addArrangedSubview(bottomPositionbutton)
        positionFramView.addArrangedSubview(supportPositionbutton)
    
        view.addSubview(infoTextLabel)
        view.addSubview(infoTextView)
        view.addSubview(confirmationButton)
        
        
        // 네비게이션 바 왼쪽 버튼
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "multiply"), for: .normal)
//        backButton.
//        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true // 버튼의 가로 크기
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.imageEdgeInsets = .init(top: -18, left: -18, bottom: -18, right: -18)
        
        let customItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customItem
        
        
        
        // 네비게이션바 오른쪽 버튼
        let rightButton = UIBarButtonItem(title: "임시 저장", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        
//        pageTitleLabel.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.centerX.equalTo(view)
//        }
        
        
        topFrame.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(97)
        }
        
        // 파티명
        partyNameLabel.snp.makeConstraints{
            $0.top.equalTo(topFrame.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(28)
        }
        
        partyNameTextField.snp.makeConstraints{
            $0.top.equalTo(partyNameLabel.snp.bottom).offset(12)
            $0.height.equalTo(45)
//            $0.width.equalTo(205)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
        }
        
        positionLabel.snp.makeConstraints{
            $0.top.equalTo(partyNameTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(28)
        }

        
        positionFramView.snp.makeConstraints{
            $0.top.equalTo(positionLabel.snp.bottom).offset(12)
            $0.height.equalTo(60)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
        }
        
        infoTextLabel.snp.makeConstraints{
            $0.top.equalTo(positionFramView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(28)
        }
        
        infoTextView.snp.makeConstraints{
            $0.top.equalTo(infoTextLabel.snp.bottom).offset(12)
            $0.height.equalTo(200)
//            $0.width.equalTo(80)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
        }
        
        confirmationButton.snp.makeConstraints{
            $0.top.equalTo(infoTextView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.height.equalTo(55)
            $0.centerX.equalTo(view)
        }
    }
}

