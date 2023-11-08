//
//  createPartyPageVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/18.
//

import Foundation
import SnapKit
import UIKit

class CreatePartyVC: UIViewController {
    var user: User?
    var hopePositionArray: [String]?
    var positionOptionButtonArry = [UIButton]()
    var firstPickedPosition: UIButton?
    var secondPickedPosition: UIButton?
    
    var selectedPositionArry: [String] = ["", ""]
    
    var thread: String?
    var tag = 1 // 생성 : 1 || 수정 : 2
    
    var placeholder = "짧은 게시글 내용을 작성해주세요.\n( 최대 500자 )"
    var textViewPosY = CGFloat(0)
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let topFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "RG구하기"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
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
        textField.becomeFirstResponder()
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
        button.subtitleLabel?.text = "Top"
        button.tag = 1
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let junglePositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Jungle"), for: .normal)
        button.subtitleLabel?.text = "Jungle"
        button.tag = 2
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let midPositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Mid"), for: .normal)
        button.subtitleLabel?.text = "Mid"
        button.tag = 3
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let bottomPositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Bottom"), for: .normal)
        button.subtitleLabel?.text = "Bottom"
        button.tag = 4
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(positionOptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let supportPositionbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Support"), for: .normal)
        button.subtitleLabel?.text = "Support"
        button.tag = 5
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
        textView.becomeFirstResponder()
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    var letterNumLabel: UILabel = {
        var label = UILabel()
        label.text = "0/150"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.rgrgColor6
        label.textAlignment = .right
        return label
        }()
    
    
    
    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("작성 완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        //        button.backgroundColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
        button.backgroundColor = UIColor.rgrgColor7
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(tappedConfirmationButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Method
    
    func task() {
        if let user = user {
            let hopePosition = [selectedPositionArry[0], selectedPositionArry[1]]
            
            let party = PartyInfo(champion: user.mostChampion, content: infoTextView.text ?? "", date: FireStoreManager.shared.dateFormatter(value: Date.now), hopePosition: hopePosition, profileImage: user.profilePhoto, tier: user.tier, title: partyNameTextField.text ?? "", userName: user.userName, writer: user.userName, position: user.position)
            
            Task {
                if tag == 1 {
                    await PartyManager.shared.addParty(party: party) { party in
                        print("### 업로드 된 :: \(party)")
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    if thread != nil {
                        let paryDetailVC = PartyInfoDetailVC()
                        await PartyManager.shared.updateParty(party: party, thread: thread ?? "n/a") {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @objc func tappedConfirmationButton(_ sender: UIButton) {
        if positionOptionButtonArry.count != 2 {
            showAlert()
        } else {
            task()
        }
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
        } else {
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
                selectedPositionArry[0] = "Top"
            case junglePositionbutton:
                jungleLabel.text = "1 st"
                jungleLabel.textColor = .rgrgColor4
                selectedPositionArry[0] = "Jungle"
            case midPositionbutton:
                midLabel.text = "1 st"
                midLabel.textColor = .rgrgColor4
                selectedPositionArry[0] = "Mid"
            case bottomPositionbutton:
                bottomLabel.text = "1 st"
                bottomLabel.textColor = .rgrgColor4
                selectedPositionArry[0] = "Bottom"
            case supportPositionbutton:
                supportLabel.text = "1 st"
                supportLabel.textColor = .rgrgColor4
                selectedPositionArry[0] = "Support"
            default:
                topLabel.text = ""
                jungleLabel.text = ""
                midLabel.text = ""
                bottomLabel.text = ""
                supportLabel.text = ""
            }
            print("@@@@@@@@@@@@@\(selectedPositionArry[0])@@@@@@@@@@@@")
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
                selectedPositionArry[1] = "Top"
            case junglePositionbutton:
                jungleLabel.text = "2 nd"
                jungleLabel.textColor = .rgrgColor3
                selectedPositionArry[1] = "Jungle"
            case midPositionbutton:
                midLabel.text = "2 nd"
                midLabel.textColor = .rgrgColor3
                selectedPositionArry[1] = "Mid"
            case bottomPositionbutton:
                bottomLabel.text = "2 nd"
                bottomLabel.textColor = .rgrgColor3
                selectedPositionArry[1] = "Bottom"
            case supportPositionbutton:
                supportLabel.text = "2 nd"
                supportLabel.textColor = .rgrgColor3
                selectedPositionArry[1] = "Support"
            default:
                topLabel.text = ""
                jungleLabel.text = ""
                midLabel.text = ""
                bottomLabel.text = ""
                supportLabel.text = ""
            }
            print("@@@@@@@@@@@@@\(selectedPositionArry[1])@@@@@@@@@@@@")
        } else {
            topLabel.text = ""
            jungleLabel.text = ""
            midLabel.text = ""
            bottomLabel.text = ""
            supportLabel.text = ""
        }
        confirmationOn()
    }
    
//    func addPlaceholderToTextView() {
//        let placeholderLabel = UILabel()
//        placeholderLabel.text = "짧은 게시글 내용을 작성해주세요.\n( 최대 500자 )"
//        placeholderLabel.textColor = .systemGray3
//        placeholderLabel.font = infoTextView.font
//        placeholderLabel.numberOfLines = 0
//        placeholderLabel.sizeToFit()
//        placeholderLabel.frame.origin = CGPoint(x: 10, y: infoTextView.textContainerInset.top)
//        placeholderLabel.tag = 100
//
//        infoTextView.addSubview(placeholderLabel)
//
//        // 텍스트 뷰에 터치 제스처 추가
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        infoTextView.addGestureRecognizer(tapGesture)
//    }
//
//    @objc func handleTap() {
//        infoTextView.viewWithTag(100)?.isHidden = true
//        infoTextView.isEditable = true
//        infoTextView.becomeFirstResponder()
//        confirmationOn()
//        print("!!!!!!!!!!!!!tag222\(infoTextView.viewWithTag(100)?.isHidden)!!!!!!!!!!!!")
//    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        if !textView.text.isEmpty {
//            infoTextView.viewWithTag(100)?.isHidden = true
//            confirmationOn()
//            print("!!!!!!!!!!!!!tag\(infoTextView.viewWithTag(100)?.isHidden)!!!!!!!!!!!!")
//        }
//    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let maxLength = 500
//        let currentText = textView.text
//        let newText = (currentText as! NSString).replacingCharacters(in: range, with: text)
//
//        return newText.count <= maxLength
//    }
    
    //    func updateConfirmationButton() {
    //        if selectedPositionArry[1] != "" && selectedPositionArry[2] != "" && !(partyNameTextField.text?.isEmpty ?? true) && !(infoTextView.text?.isEmpty ?? true) {
    //            confirmationButton.isEnabled = true
    //            confirmationButton.backgroundColor = UIColor.rgrgColor4
    //        } else {
    //            confirmationButton.isEnabled = false
    //            confirmationButton.backgroundColor = UIColor.red // 조건이 만족되지 않으면 원하는 배경색으로 설정하세요.
    //        }
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        infoTextView.becomeFirstResponder()
        view.endEditing(true)
    }
    
    // MARK: - KeyBoard
    
    var bottomButtonConstraint: NSLayoutConstraint?
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if #available(iOS 11.0, *) {
                let bottomInset = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.bottom ?? 0
                let adjustedKeyboardHeight = keyboardHeight - bottomInset
                bottomButtonConstraint?.constant = -adjustedKeyboardHeight
                bottomButtonConstraint?.constant = -keyboardHeight
            }
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardDidShow(_ noti: NSNotification) {}
    
    @objc func keyboardWillHide(_ noti: NSNotification) {
        bottomButtonConstraint?.constant = 0
        view.layoutIfNeeded()
    }
    
    func confirmationOn() {
        if selectedPositionArry[0] == "" && selectedPositionArry[1] == "" || partyNameTextField.text?.isEmpty == true || infoTextView.text?.isEmpty == true {
            confirmationButton.isEnabled = false
            confirmationButton.backgroundColor = UIColor.rgrgColor7
        } else {
            confirmationButton.isEnabled = true
            confirmationButton.backgroundColor = UIColor.rgrgColor4
        }
    }
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        navigationController?.navigationBar.isHidden = false
        print("!!!!!!!!!!!!!\(partyNameTextField.text?.isEmpty)!!!!!!!!!!!!!")
        confirmationOn()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = titleLabel
       
        partyNameTextField.delegate = self
        infoTextView.delegate = self
        configureUI()
//        addPlaceholderToTextView()
        addKeyboardNotifications()
        confirmationOn()
        
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - configureUI
    
    func configureUI() {
        if infoTextView.text.isEmpty == true {
//            addPlaceholderToTextView()
        }
        
        view.backgroundColor = .rgrgColor5
        
        view.addSubview(topFrame)
        topFrame.addSubview(titleLabel)
    
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
        view.addSubview(letterNumLabel)
        view.addSubview(confirmationButton)
        
        // 네비게이션 바 왼쪽 버튼
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "XIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true // 버튼의 가로 크기
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.imageEdgeInsets = .init(top: -18, left: -13, bottom: -8, right: -13)
        
        let customItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customItem
        
        // 네비게이션바 오른쪽 버튼
        let rightButton = UIBarButtonItem(title: "임시 저장", style: .plain, target: self, action: #selector(backButtonTapped))
        rightButton.isHidden = true
        navigationItem.rightBarButtonItem = rightButton
        
        topFrame.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(88)
        }
        
//        scrollView.snp.makeConstraints{
//            $0.top.equalTo(topFrame.snp.bottom).offset(0)
//            $0.trailing.leading.bottom.equalTo(self.view.safeAreaLayoutGuide)
//        }
//
//        contentView.snp.makeConstraints{
        ////            $0.top.trailing.leading.bottom.equalTo(scrollView)
//            $0.edges.equalTo(scrollView)
//            $0.width.equalTo(scrollView)
//        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(topFrame.snp.bottom).offset(-6)
            $0.centerX.equalToSuperview()
            //            $0.top.equalTo(contentView.snp.top).offset(32)
//            $0.leading.equalTo(contentView.snp.leading).offset(28)
        }
        
        partyNameLabel.snp.makeConstraints {
            $0.top.equalTo(topFrame.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(28)
            //            $0.top.equalTo(contentView.snp.top).offset(32)
//            $0.leading.equalTo(contentView.snp.leading).offset(28)
        }
        
        partyNameTextField.snp.makeConstraints {
            $0.top.equalTo(partyNameLabel.snp.bottom).offset(7)
            $0.height.equalTo(45)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
//            $0.leading.equalTo(contentView.snp.leading).offset(28)
//            $0.trailing.equalTo(contentView.snp.trailing).offset(-28)
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
        
        letterNumLabel.snp.makeConstraints{
            $0.trailing.equalTo(infoTextView.snp.trailing).offset(-6)
            $0.bottom.equalTo(infoTextView.snp.bottom).offset(-8)
            $0.height.equalTo(18)
            $0.width.equalTo(50)
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

extension CreatePartyVC: UITextFieldDelegate {
    func textField(_ partyNameTextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 백스페이스 처리
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard partyNameTextField.text!.count < 26 else { return false }
        confirmationOn()
        return true
    }
}

extension CreatePartyVC {
    func showAlert() {
        let alert = UIAlertController(title: "포지션을 선택해주세요.", message: "", preferredStyle: .alert)
        
        let confirmAlert = UIAlertAction(title: "확인", style: .default) { _ in
            print("#### 확인을 눌렀음.")
        }
        alert.addAction(confirmAlert)
        present(alert, animated: true)
    }
}


// MARK: - TextView

extension CreatePartyVC: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = UIColor(hex: "#505050")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor(hex: "#ADADAD")
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    // MARK: textview 높이 자동조절
    
    func textViewDidChange(_ textView: UITextView) {

            func textViewDidBeginEditing(_ textView: UITextView) {
                if textView.text == placeholder {
                    infoTextView.text = nil
                    infoTextView.textColor = UIColor(hex: "#505050")
                }
            }
        
        
        
            func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
                textView.resignFirstResponder()
                
                return true
            }
        
            // MARK: textview 높이 자동조절
        
            func textViewDidChange(_ textView: UITextView) {
                let size = CGSize(width: view.frame.width, height: .infinity)
                let estimatedSize = textView.sizeThatFits(size)
                if infoTextView.text.count > 10 {
                    infoTextView.deleteBackward()
                }
                letterNumLabel.text = "\(infoTextView.text.count)/150"
        
                textView.constraints.forEach { _ in
        
                    if estimatedSize.height <= 80 {
                        textView.isScrollEnabled = false
        
                    } else {
                        textView.isScrollEnabled = true
        //                if chats.isEmpty != true {
        //                    let endexIndex = IndexPath(row: chats.count - 1, section: 0)
        //                    tableView.scrollToRow(at: endexIndex, at: .bottom, animated: true)
        //                }
                    }
                }
            }
        
            func textViewDidEndEditing(_ textView: UITextView) {
                if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    infoTextView.text = placeholder
                    infoTextView.textColor = UIColor(hex: "#ADADAD")
                    
        
                    if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
        //                infoTextView.textColor = .gray200
        //                infoTextView.text = placeholder
                        letterNumLabel.textColor = UIColor.systemBlue
                                letterNumLabel.text = "0/150"
                            }
                }
            }
    }
}
