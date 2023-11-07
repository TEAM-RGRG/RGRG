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
    // 1. UI 구성(진행 중)
    // 2. 이메일 보내기(테스트 예정)
    // 3. 키보드 반응(구현 예정)
    // 4. 현재 글자 수 표시
    // 5. 최대 글자 수 제한

    var pageTitle: String?

    let reportTitle = CustomLabel(frame: .zero)
    let reportTextField = CustomTextField(frame: .zero)
    let reportDescriptionTitle = CustomLabel(frame: .zero)
    let reportDescriptionTextView = CustomTextView(frame: .zero)
    let sendButton = CustomButton(frame: .zero)

    let rightBarButtonItem = CustomBarButton()

    let textFieldPlaceholder = "제목을 입력해주세요"
    let textViewPlaceholder = "신고 사유를 작성해주세요.(최대 500자)"
}

// MARK: - View LifeCycle

extension ReportViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

        makeRightBarButton()
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

// MARK: - Send Email

extension ReportViewController: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        // 이메일 사용가능한지 체크하는 if문
        if MFMailComposeViewController.canSendMail() {
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self

            // 개발자 계정 이메일
            compseVC.setToRecipients(["본 메일을 전달받을 이메일주소"])
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
        reportTextField.resignFirstResponder()
        reportDescriptionTextView.resignFirstResponder()
    }
}

// MARK: - TextFieldDelegate

extension ReportViewController: UITextFieldDelegate {}

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
