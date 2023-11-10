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
    
    let placeholderLabel = UILabel()
    let rightBarButtonItem = CustomBarButton()
    
    let textViewPlaceholder = "짧은 게시글 내용을 작성해주세요.(최대 200자)"

    var selectedPositionArry: [String] = ["", ""]
    
    var eventHandler: ((PartyInfo) -> Void)?
    
    var thread: String?
    var tag = 1 // 생성 : 1 || 수정 : 2
    var currentTextFieldCount = 0
    var currentTextViewCount = 0
    
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
        view.backgroundColor = .rgrgColor5
        return view
    }()
    
    let partyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.myBoldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let partyNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.placeholder = "제목"
        textField.font = .myMediumSystemFont(ofSize: 16)
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "구하는 포지션"
        label.font = UIFont.myBoldSystemFont(ofSize: 16)
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
        button.backgroundColor = .rgrgColor6
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
        button.backgroundColor = .rgrgColor6
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
        button.backgroundColor = .rgrgColor6
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
        button.backgroundColor = .rgrgColor6
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
        button.backgroundColor = .rgrgColor6
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
        label.font = UIFont.myMediumSystemFont(ofSize: 12)
        return label
    }()
    
    let jungleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.myMediumSystemFont(ofSize: 12)
        return label
    }()
    
    let midLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.myMediumSystemFont(ofSize: 12)
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.myMediumSystemFont(ofSize: 12)
        return label
    }()
    
    let supportLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.myMediumSystemFont(ofSize: 12)
        return label
    }()
    
    let infoTextLabel: UILabel = {
        let label = UILabel()
        label.text = "소개글"
        label.font = UIFont.myBoldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let infoTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = UIFont.myMediumSystemFont(ofSize: 16)
        textView.layer.cornerRadius = 10

        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    var textCountLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.myMediumSystemFont(ofSize: 15)
        label.textColor = .rgrgColor7
        label.text = "0/25"
        label.textAlignment = .right
        return label
    }()
    
    var currentTextCountLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.myMediumSystemFont(ofSize: 15)
        label.textColor = .rgrgColor7
        label.text = "0/200"
        label.textAlignment = .right
        return label
    }()
    
    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 15)
        button.setTitle("작성 완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = UIColor(red: 12/255, green: 53/255, blue: 106/255, alpha: 1)
        button.backgroundColor = UIColor.rgrgColor7
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.addTarget(self, action: #selector(tappedConfirmationButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Method
    
    func task() {
        if let user = user {
            let hopePosition = [selectedPositionArry[0], selectedPositionArry[1]]
            
            let party = PartyInfo(champion: [user.mostChampion[0], user.mostChampion[1], user.mostChampion[2]], content: infoTextView.text ?? "", date: FireStoreManager.shared.dateFormatter(value: Date.now), hopePosition: hopePosition, profileImage: user.profilePhoto, tier: user.tier, title: partyNameTextField.text ?? "", userName: user.userName, writer: user.userName, position: user.position)
            
            Task {
                if tag == 1 {
                    await PartyManager.shared.addParty(party: party) { party in
                        print("### 업로드 된 :: \(party)")
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("#### 여기 실행!!")
                    
                    if thread != nil {
                        await PartyManager.shared.updateParty(party: party, thread: thread ?? "n/a") { data in
                            print("##### 여기 실행되어야함")
                            self.eventHandler?(data)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
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
            sender.backgroundColor = UIColor.rgrgColor4
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
                button.backgroundColor = .rgrgColor6
                button.layer.borderColor = UIColor.white.cgColor
            }
            positionOptionButtonArry.removeAll()
            firstPickedPosition = nil
            secondPickedPosition = nil
            updatePositionLabels()
            updateSecondPositionLabels()
        }
        updateConfirmationButton()
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
        } else {
            topLabel.text = ""
            jungleLabel.text = ""
            midLabel.text = ""
            bottomLabel.text = ""
            supportLabel.text = ""
        }
        updateConfirmationButton()
    }
    
    func updateConfirmationButton() {
        if firstPickedPosition != nil && secondPickedPosition != nil && partyNameTextField.text?.isEmpty != true && infoTextView.text.isEmpty != true && infoTextView.text != textViewPlaceholder {
            confirmationButton.isEnabled = true
            confirmationButton.backgroundColor = UIColor.rgrgColor4
        } else {
            confirmationButton.isEnabled = false
            confirmationButton.backgroundColor = UIColor.rgrgColor7
        }
    }

    // MARK: - KeyBoard

    var bottomButtonConstraint: NSLayoutConstraint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if infoTextView.isFirstResponder {
                self.view.window?.frame.origin.y -= keyboardHeight - 210
                partyNameTextField.isEnabled = false
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.window?.frame.origin.y != 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                if infoTextView.isFirstResponder {
                    self.view.window?.frame.origin.y += keyboardHeight - 210
                    partyNameTextField.isEnabled = true
                }
            }
        }
    }
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
        if tag == 1 {
            addPlaceholderToTextView()
        }
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partyNameTextField.delegate = self
        infoTextView.delegate = self
        
        configureUI()
        setKeyboardObserver()
        
        makeRightBarButton()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - configureUI
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(topFrame)
        setUIShadow()

        topFrame.addSubview(partyNameLabel)
        topFrame.addSubview(partyNameTextField)
        topFrame.addSubview(positionLabel)
        topFrame.addSubview(positionFramView)
        positionFramView.addArrangedSubview(topPositionbutton)
        positionFramView.addArrangedSubview(junglePositionbutton)
        positionFramView.addArrangedSubview(midPositionbutton)
        positionFramView.addArrangedSubview(bottomPositionbutton)
        positionFramView.addArrangedSubview(supportPositionbutton)
        topFrame.addSubview(positionLabelFramView)
        positionLabelFramView.addArrangedSubview(topLabel)
        positionLabelFramView.addArrangedSubview(jungleLabel)
        positionLabelFramView.addArrangedSubview(midLabel)
        positionLabelFramView.addArrangedSubview(bottomLabel)
        positionLabelFramView.addArrangedSubview(supportLabel)
    
        topFrame.addSubview(infoTextLabel)
        topFrame.addSubview(infoTextView)
        topFrame.addSubview(textCountLabel)
        topFrame.addSubview(currentTextCountLabel)
        topFrame.addSubview(confirmationButton)
        
        // 네비게이션 타이틀
        navigationItem.title = "RG 구하기"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.black]

        // 네비게이션 바 왼쪽 버튼
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .rgrgColor4
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
            $0.left.right.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        partyNameLabel.snp.makeConstraints {
            $0.top.equalTo(topFrame.snp.top).offset(32)
            $0.leading.equalToSuperview().offset(28)
        }
        
        partyNameTextField.snp.makeConstraints {
            $0.top.equalTo(partyNameLabel.snp.bottom).offset(7)
            $0.height.equalTo(45)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
        }
        
        textCountLabel.snp.makeConstraints {
            $0.top.equalTo(partyNameTextField.snp.bottom).offset(5)
            $0.height.equalTo(18)
            $0.width.equalTo(50)
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
        
        currentTextCountLabel.snp.makeConstraints {
            $0.top.equalTo(infoTextView.snp.bottom).offset(5)
            $0.height.equalTo(18)
            $0.width.equalTo(80)
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
    
    func addPlaceholderToTextView() {
        infoTextView.text = textViewPlaceholder
        infoTextView.textColor = UIColor(hex: "#ADADAD")
    }
}

extension CreatePartyVC {
    func makeRightBarButton() {
        // 액션 만들기 >> 메뉴 만들기 >> UIBarButtonItem 만들기

        rightBarButtonItem.title = "초기화"
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(tappedResetButton)

        navigationItem.rightBarButtonItem?.changesSelectionAsPrimaryAction = false

        rightBarButtonItem.tintColor = UIColor.rgrgColor3
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func tappedResetButton(_ sender: UIBarButtonItem) {
        partyNameTextField.text = nil
        infoTextView.text = textViewPlaceholder
        infoTextView.textColor = UIColor(hex: "#ADADAD")
        for button in positionOptionButtonArry {
            button.backgroundColor = .rgrgColor6
            button.layer.borderColor = UIColor.white.cgColor
        }
        positionOptionButtonArry.removeAll()
        firstPickedPosition = nil
        secondPickedPosition = nil
        updatePositionLabels()
        updateSecondPositionLabels()
        updateConfirmationButton()
        
        textCountLabel.text = "\(0)/25"
        currentTextCountLabel.text = "\(0)/200"

        partyNameTextField.resignFirstResponder()
        infoTextView.resignFirstResponder()
    }
    
    func setUIShadow() {
        partyNameTextField.setupShadow(alpha: 0.05, offset: CGSize(width: 2, height: 3), radius: 12, opacity: 1)
        infoTextView.setupShadow(alpha: 0.05, offset: CGSize(width: 2, height: 3), radius: 12, opacity: 1)
        confirmationButton.setupShadow(alpha: 0.2, offset: CGSize(width: 2, height: 3), radius: 4, opacity: 1)
    }
}

extension CreatePartyVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textCountLabel.text = "\(0)/25"
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let rangeText = Range(range, in: currentText) else { return false }

        let changedText = currentText.replacingCharacters(in: rangeText, with: string)

        print("#### 지금 현재 글자 수 \(changedText.count)")
        currentTextFieldCount = changedText.count
        textCountLabel.text = "\(currentTextFieldCount)/25"
        updateConfirmationButton()
        return currentTextFieldCount < 25
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        
        let newLength = partyNameTextField.text?.count ?? 0 + string.count - range.length
        confirmationButton.isEnabled = !partyNameTextField.text!.isEmpty && newLength <= 26
        
        return newLength <= 20
    }
}

extension CreatePartyVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = UIColor(hex: "#505050")
        }
        updateConfirmationButton()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = UIColor(hex: "#ADADAD")
        }
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            infoTextView.viewWithTag(100)?.isHidden = true
            confirmationButton.isEnabled = !textView.text.isEmpty
            updateConfirmationButton()
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        
        guard let rangeText = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: rangeText, with: text)
        updateConfirmationButton()
        currentTextViewCount = changedText.count
        currentTextCountLabel.text = "\(currentTextViewCount)/200"

        return currentTextViewCount < 200
    }
}
