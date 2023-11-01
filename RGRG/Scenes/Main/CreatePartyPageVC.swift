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
    
    var user: User?
    var positionOptionButtonArry = [UIButton]()
    var firstPickedPosition: UIButton?
    var secondPickedPosition: UIButton?
    
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
        stackView.spacing = 20
        return stackView
    }()
    
    let topPositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Top"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let junglePositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Jungle"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let midPositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Mid"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let bottomPositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Bottom"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let supportPositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Support"), for: .normal)
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let positionLabelFramView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    let jungleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    let midLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    let supportLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
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
        button.addTarget(self, action: #selector(tappedConfirmationButton), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Method
    
    func task() {
        if let user = user {
            let hopePosition = ["first": positionOptionButtonArry[0].subtitleLabel?.text ?? "top", "second": positionOptionButtonArry[1].subtitleLabel?.text ?? "top"]
            
            let party = PartyInfo(champion: ["Ahri", "Teemo", "Ashe"], content: infoTextView.text ?? "", date: FireStoreManager.shared.dateFormatter(value: Date.now), hopePosition: hopePosition, profileImage: user.profilePhoto, tier: user.tier, title: partyNameTextField.text ?? "", userName: user.userName, writer: user.userName, position: user.position)
            
            Task {
                await PartyManager.shared.addParty(party: party) { party in
                    print("### 업로드 된 :: \(party)")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @objc func tappedConfirmationButton(_ sender: UIButton) {
        task()
    }
    
    @objc func positionOptionButtonTapped(_ sender: UIButton) {
           if positionOptionButtonArry.isEmpty {
               sender.isSelected = true
               sender.backgroundColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
               firstPickedPosition = sender
               positionOptionButtonArry.append(sender)
               updatePositionLabels()
           } else if positionOptionButtonArry.count == 1 && firstPickedPosition != sender {
               sender.isSelected = true
               sender.backgroundColor = UIColor.rgrgColor3
               secondPickedPosition = sender
               positionOptionButtonArry.append(sender)
               updatePositionLabels()
               updateSecondPositionLabels()
           }  else {
               for button in positionOptionButtonArry {
                   button.backgroundColor = .systemGray4
                   button.layer.borderColor = UIColor.white.cgColor
               }
               positionOptionButtonArry.removeAll()
               firstPickedPosition = nil
               secondPickedPosition = nil
               updatePositionLabels()
               updateSecondPositionLabels()
           }
        }
    
    func updatePositionLabels() {
        if let firstPicked = firstPickedPosition {
            switch firstPicked {
            case topPositionbutton:
                topLabel.text = "1 st"
                topLabel.textColor = .rgrgColor4
            case junglePositionbutton:
                jungleLabel.text = "1 st"
                jungleLabel.textColor = .rgrgColor4
            case midPositionbutton:
                midLabel.text = "1 st"
                midLabel.textColor = .rgrgColor4
            case bottomPositionbutton:
                bottomLabel.text = "1 st"
                bottomLabel.textColor = .rgrgColor4
            case supportPositionbutton:
                supportLabel.text = "1 st"
                supportLabel.textColor = .rgrgColor4
            default:
                topLabel.text = ""
                jungleLabel.text = ""
                midLabel.text = ""
                bottomLabel.text = ""
                supportLabel.text = ""
            }
        } else {
            topLabel.text = ""
            jungleLabel.text = ""
            midLabel.text = ""
            bottomLabel.text = ""
            supportLabel.text = ""
        }
    }

    
    
    
    func updateSecondPositionLabels() {
        if let secondPicked = secondPickedPosition {
            switch secondPicked {
            case topPositionbutton:
                topLabel.text = "2 nd"
                topLabel.textColor = .rgrgColor3
            case junglePositionbutton:
                jungleLabel.text = "2 nd"
                jungleLabel.textColor = .rgrgColor3
            case midPositionbutton:
                midLabel.text = "2 nd"
                midLabel.textColor = .rgrgColor3
            case bottomPositionbutton:
                bottomLabel.text = "2 nd"
                bottomLabel.textColor = .rgrgColor3
            case supportPositionbutton:
                supportLabel.text = "2 nd"
                supportLabel.textColor = .rgrgColor3
            default:
                topLabel.text = ""
                jungleLabel.text = ""
                midLabel.text = ""
                bottomLabel.text = ""
                supportLabel.text = ""
            }
        } else {
            topLabel.text = ""
            jungleLabel.text = ""
            midLabel.text = ""
            bottomLabel.text = ""
            supportLabel.text = ""
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

    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "RG구하기"
        
        configureUI()
        addPlaceholderToTextView()

    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - configureUI
    
    func configureUI() {
        view.backgroundColor = .rgrgColor5
        
        view.addSubview(topFrame)
        view.addSubview(partyNameLabel)
        view.addSubview(partyNameTextField)
        view.addSubview(positionLabel)
        view.addSubview(positionFramView)
        positionFramView.addArrangedSubview(topPositionbutton)
        positionFramView.addArrangedSubview(junglePositionbutton)
        positionFramView.addArrangedSubview(midPositionbutton)
        positionFramView.addArrangedSubview(bottomPositionbutton)
        positionFramView.addArrangedSubview(supportPositionbutton)
        view.addSubview(positionLabelFramView)
        positionLabelFramView.addArrangedSubview(topLabel)
        positionLabelFramView.addArrangedSubview(jungleLabel)
        positionLabelFramView.addArrangedSubview(midLabel)
        positionLabelFramView.addArrangedSubview(bottomLabel)
        positionLabelFramView.addArrangedSubview(supportLabel)
    
        view.addSubview(infoTextLabel)
        view.addSubview(infoTextView)
        view.addSubview(confirmationButton)
        
        // 네비게이션 바 왼쪽 버튼
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "multiply")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true // 버튼의 가로 크기
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.imageEdgeInsets = .init(top: -18, left: -18, bottom: -18, right: -18)
        
        let customItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customItem
        
        // 네비게이션바 오른쪽 버튼
        let rightButton = UIBarButtonItem(title: "임시 저장", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        
        topFrame.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(97)
        }
        
        partyNameLabel.snp.makeConstraints {
            $0.top.equalTo(topFrame.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(28)
        }
        
        partyNameTextField.snp.makeConstraints {
            $0.top.equalTo(partyNameLabel.snp.bottom).offset(7)
            $0.height.equalTo(45)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
        }
        
        positionLabel.snp.makeConstraints {
            $0.top.equalTo(partyNameTextField.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(28)
        }

        positionFramView.snp.makeConstraints {
            $0.top.equalTo(positionLabel.snp.bottom).offset(12)
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
        }
        
        positionLabelFramView.snp.makeConstraints {
            $0.top.equalTo(positionFramView.snp.bottom).offset(2)
            $0.height.equalTo(15)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
        }
        
        infoTextLabel.snp.makeConstraints {
            $0.top.equalTo(positionFramView.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(28)
        }
        
        infoTextView.snp.makeConstraints {
            $0.top.equalTo(infoTextLabel.snp.bottom).offset(12)
            $0.height.equalTo(226)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
        }
        
        confirmationButton.snp.makeConstraints {
            $0.top.equalTo(infoTextView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.height.equalTo(60)
            $0.centerX.equalTo(view)
        }
    }
}
