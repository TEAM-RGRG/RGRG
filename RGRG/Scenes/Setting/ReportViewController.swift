//
//  ReportViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 11/7/23.
//

import MessageUI
import SnapKit
import UIKit

class ReportViewController: UIViewController {
    var pageTitle: String?

    let reportTitle = CustomLabel(frame: .zero)
    let reportTextField = CustomTextField(frame: .zero)
    let reportDescriptionTitle = CustomLabel(frame: .zero)
    let reportDescriptionTextView = CustomTextView(frame: .zero)
    let sendButton = CustomButton(frame: .zero)

    let rightBarButtonItem = CustomBarButton()

    let textFieldPlaceholder = "제목을 입력해주세요"
    let textViewPlaceholder = "신고 사유를 작성해주세요.(최대 200자)"

    var textViewPosY = CGFloat(0)

    let currentTextFieldLabel = CustomLabel(frame: .zero)
    let currentTextViewLabel = CustomLabel(frame: .zero)

    var currentTextFieldCount = 0
    var currentTextViewCount = 0
}

// MARK: - View LifeCycle

extension ReportViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        reportTextField.text = nil
        reportDescriptionTextView.text = textViewPlaceholder
        reportDescriptionTextView.textColor = UIColor(hex: "#ADADAD")

        currentTextFieldLabel.text = "\(0)/25"
        currentTextViewLabel.text = "\(0)/200"
    }
}

// MARK: - Setting UI

extension ReportViewController {
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#F4F4F4")
        navigationItem.title = pageTitle

        addView()
        confirmReportTitle()
        confirmReportTextField()
        confirmReportDescription()
        confirmReportTextView()
        confirmSendButton()

        confirmCurrentTextFieldLabel()
        confirmCurrentTextViewLabel()

        makeRightBarButton()
        keyboardCheck()
        hideKeyboardWhenTappedAround()
    }

    func addView() {
        [reportTitle, reportTextField, reportDescriptionTitle, reportDescriptionTextView, sendButton].forEach {
            view.addSubview($0)
        }
    }
}

// MARK: - Confirm View

extension ReportViewController {
    func confirmReportTitle() {
        reportTitle.text = "제목"
        reportTitle.font = UIFont(name: AppFontName.bold, size: 16)
        reportTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.leading.equalTo(view).offset(36)
            make.width.greaterThanOrEqualTo(30)
            make.height.greaterThanOrEqualTo(25)
        }
    }

    func confirmReportTextField() {
        reportTextField.delegate = self
        reportTextField.font = UIFont(name: AppFontName.regular, size: 18)
        reportTextField.placeholder = textFieldPlaceholder
        reportTextField.backgroundColor = .white
        reportTextField.layer.cornerRadius = 10
        reportTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        reportTextField.leftViewMode = .always
        reportTextField.clearButtonMode = .whileEditing
        reportTextField.returnKeyType = .done

        reportTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(67)
            make.leading.equalTo(view).offset(36)
            make.height.equalTo(55)
        }
    }

    func confirmReportDescription() {
        reportDescriptionTitle.text = "신고 사유🚨"
        reportDescriptionTitle.font = UIFont(name: AppFontName.bold, size: 16)

        reportDescriptionTitle.snp.makeConstraints { make in
            make.top.equalTo(reportTextField.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(36)
            make.width.greaterThanOrEqualTo(40)
            make.height.greaterThanOrEqualTo(25)
        }
    }

    func confirmReportTextView() {
        reportDescriptionTextView.delegate = self
        reportDescriptionTextView.text = textViewPlaceholder
        reportDescriptionTextView.font = UIFont(name: AppFontName.regular, size: 18)
        reportDescriptionTextView.backgroundColor = UIColor(hex: "#FFFFFF")
        reportDescriptionTextView.textColor = UIColor(hex: "#ADADAD")
        reportDescriptionTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        reportDescriptionTextView.isScrollEnabled = true
        reportDescriptionTextView.layer.cornerRadius = 10

        reportDescriptionTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(reportDescriptionTitle.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(36)
            make.width.equalTo(400)
            make.height.equalTo(300)
        }
    }

    func confirmSendButton() {
        sendButton.titleLabel?.font = UIFont(name: AppFontName.bold, size: 16)
        sendButton.tintColor = UIColor(hex: "#FFFFFF")
        sendButton.configureButton(title: "작성완료", cornerValue: 10, backgroundColor: UIColor(hex: "#0C356A"))
        sendButton.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)

        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(36)
            make.top.equalTo(reportDescriptionTextView.snp.bottom).offset(50)
            make.width.equalTo(330)
            make.height.equalTo(60)
        }
    }

    @objc func tappedSendButton(_ sender: UIButton) {
        print("#### \(#function)")
        if reportTextField.text?.isEmpty != true, reportDescriptionTextView.text.isEmpty != true, reportDescriptionTextView.text != textViewPlaceholder {
            print("#### 메일 전송~~~~")
            sendEmail()

        } else {
            showAlert()
        }
    }
}

// MARK: - CurrentTextFieldLabel, CurrentTextViewLabel

extension ReportViewController {
    func confirmCurrentTextFieldLabel() {
        view.addSubview(currentTextFieldLabel)

        currentTextFieldLabel.text = "\(currentTextFieldCount)/25"
        currentTextFieldLabel.snp.makeConstraints { make in
            make.top.equalTo(reportTextField.snp.bottom).offset(5)
            make.trailing.equalTo(reportTextField.snp.trailing)
            make.width.greaterThanOrEqualTo(50)
            make.height.greaterThanOrEqualTo(30)
        }
    }

    func confirmCurrentTextViewLabel() {
        view.addSubview(currentTextViewLabel)
        currentTextViewLabel.text = "\(currentTextViewCount)/200"

        currentTextViewLabel.snp.makeConstraints { make in
            make.top.equalTo(reportDescriptionTextView.snp.bottom).offset(5)
            make.trailing.equalTo(reportDescriptionTextView.snp.trailing)
            make.width.greaterThanOrEqualTo(50)
            make.height.greaterThanOrEqualTo(30)
        }
    }
}

// MARK: - Send Email

extension ReportViewController: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        // 이메일 사용가능한지 체크하는 if문
        if MFMailComposeViewController.canSendMail() {
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self

            // 개발자 계정 이메일
            compseVC.setToRecipients(["rgrgshared@gmail.com"])
            compseVC.setSubject(reportTextField.text ?? "N/A")
            compseVC.setMessageBody(reportDescriptionTextView.text ?? "N/A", isHTML: false)

            present(compseVC, animated: true, completion: nil)

        } else {
            showSendMailErrorAlert()
        }
    }

    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {
            (_) in
            print("확인")
        }
        sendMailErrorAlert.addAction(confirmAction)
        present(sendMailErrorAlert, animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ReportViewController {
    func makeRightBarButton() {
        // 액션 만들기 >> 메뉴 만들기 >> UIBarButtonItem 만들기

        rightBarButtonItem.title = "초기화"
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(tappedResetButton)

        navigationItem.rightBarButtonItem?.changesSelectionAsPrimaryAction = false

        rightBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func tappedResetButton(_ sender: UIBarButtonItem) {
        reportTextField.text = nil
        reportDescriptionTextView.text = textViewPlaceholder
        reportDescriptionTextView.textColor = UIColor(hex: "#ADADAD")

        currentTextFieldLabel.text = "\(0)/25"
        currentTextViewLabel.text = "\(0)/200"

        reportTextField.resignFirstResponder()
        reportDescriptionTextView.resignFirstResponder()
    }
}

// MARK: - TextFieldDelegate

extension ReportViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        reportTextField.resignFirstResponder()
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("#### 264 호출")
        currentTextFieldLabel.text = "\(0)/25"
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let rangeText = Range(range, in: currentText) else { return false }

        let changedText = currentText.replacingCharacters(in: rangeText, with: string)

        print("#### 지금 현재 글자 수 \(changedText.count)")
        currentTextFieldCount = changedText.count
        currentTextFieldLabel.text = "\(currentTextFieldCount)/25"
        return currentTextFieldCount < 25
    }
}

// MARK: - TextViewDelegate

extension ReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = UIColor(hex: "#505050")
        }
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

    // MARK: textview 높이 자동조절

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)

        textView.constraints.forEach { (_) in

            if estimatedSize.height <= 80 {
                textView.isScrollEnabled = false

            } else {
                textView.isScrollEnabled = true
            }
        }
    }

    // MARK: - 현재 글자 수 출력

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let rangeText = Range(range, in: currentText) else { return false }

        let changedText = currentText.replacingCharacters(in: rangeText, with: text)

        print("#### 지금 현재 글자 수 \(changedText.count)")
        currentTextViewCount = changedText.count
        currentTextViewLabel.text = "\(currentTextViewCount)/200"
        return currentTextViewCount < 200
    }
}

extension ReportViewController {
    func showAlert() {
        let alert = UIAlertController(title: "빈칸이 있습니다. 내용을 작성해주세요.", message: "", preferredStyle: .alert)

        let confirmAlert = UIAlertAction(title: "확인", style: .default) { _ in
            print("#### 확인을 눌렀음.")
        }
        alert.addAction(confirmAlert)
        present(alert, animated: true)
    }
}

extension ReportViewController {
    func keyboardCheck() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        print("#### \(#function)")

        if reportDescriptionTextView.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if view.frame.origin.y == textViewPosY {
                    view.frame.origin.y -= keyboardSize.height * 0.4 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func keyboardDidShow(notification: NSNotification) {
        print("#### \(#function)")

        if reportDescriptionTextView.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if view.frame.origin.y == textViewPosY {
                    view.frame.origin.y -= keyboardSize.height * 0.4 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("#### \(#function)")
        if reportDescriptionTextView.frame.origin.y != textViewPosY {
            view.frame.origin.y = textViewPosY
        }
    }
}

// MARK: - hideKeyboardWhenTappedAround

extension ReportViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatDetailViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
