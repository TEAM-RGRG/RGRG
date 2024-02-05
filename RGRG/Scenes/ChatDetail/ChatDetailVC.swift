//
//  ChatDetailVC.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import FirebaseAuth
import SnapKit
import UIKit

class ChatDetailVC: UIViewController {
    let tableView = CustomTableView(frame: .zero, style: .plain)

    let emptyView = UIView(frame: .zero)
    let bottomBaseView = UIView(frame: .zero)

    let rightBarButtonItem = CustomBarButton()

    let blankMessage = CustomLabel(frame: .zero)
    let sendMessageIcon = CustomImageView(frame: .zero)
    let textView = CustomTextView(frame: .zero)

    var thread = ""
    var channelInfo: ChannelInfo?
    var chats: [ChatInfo] = []

    var fetchingMore = false
    var count = 1

    var currentUserUid = ""
    var placeholder = "메세지 보내기"
    var textViewPosY = CGFloat(0)

    deinit {
        print("### ChatDetailViewController deinitialized")
    }
}

// MARK: - View Life Cycle

extension ChatDetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        showBlankListMessage()
        task()
    }

    override func viewWillDisappear(_ animated: Bool) {
        currentUserUid = ""
        view.endEditing(true)
    }
}

// MARK: - SetUp UI

extension ChatDetailVC {
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        hideKeyboardWhenTappedAround()
        keyboardCheck()

        confirmNavigation()

        confirmTableView()
        registerCell()

        makeRightBarButton()
        makeBackButton()

        confirmBottomBaseView()
        confirmTextView()
        confirmEmptyView()
        confirmSendMessageIcon()

        swipeRecognizer()
    }

    func confirmNavigation() {
        navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor(hex: "#FFFFFF")
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.rgrgColor4]
        navigationController?.navigationBar.shadowImage = nil
    }
}

// MARK: - Load Data

extension ChatDetailVC {
    func task() {
        FBStoreManager.shared.loadChatting(channelName: "channels", thread: thread, startIndex: count) { [weak self] data in
            guard let self = self else { return }

            self.chats = data

            if chats.isEmpty == true {
                blankMessage.isHidden = false
            } else {
                blankMessage.isHidden = true
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()

                if self.chats.isEmpty != true {
                    let endexIndex = IndexPath(row: self.chats.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endexIndex, at: .bottom, animated: true)
                }
            }

            FBStoreManager.shared.updateChannel(currentMessage: self.chats.last?.content ?? "", thread: thread, sender: currentUserUid, host: channelInfo?.host ?? "n/a", guest: channelInfo?.guest ?? "n/a")
        }
    }
}

// MARK: - Making TableView

extension ChatDetailVC {
    func confirmTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        view.addSubview(bottomBaseView)
        bottomBaseView.addSubview(textView)

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hex: "#F4F4F4")

        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.bottom.equalTo(bottomBaseView.snp.top)
            make.height.greaterThanOrEqualTo(600)
        }
    }

    func registerCell() {
        tableView.register(MyFeedCell.self, forCellReuseIdentifier: MyFeedCell.identifier)
        tableView.register(YourFeedCell.self, forCellReuseIdentifier: YourFeedCell.identifier)
        tableView.register(ChatAlertCell.self, forCellReuseIdentifier: ChatAlertCell.identifier)
    }

    func showBlankListMessage() {
        view.addSubview(blankMessage)
        blankMessage.text = "쪽지를 보내서 RG 친구를 만들어 보세요!"
        blankMessage.textAlignment = .center
        blankMessage.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        blankMessage.textColor = UIColor(hex: "#767676")

        blankMessage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}

// MARK: - Making RightBarButtonItem

extension ChatDetailVC {
    func makeRightBarButton() {
        rightBarButtonItem.image = UIImage(named: "chatGearIcon")
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(tappedSettingButton)
        rightBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func tappedSettingButton(_ sender: UIBarButtonItem) {
        let vc = ChatSettingVC()
        vc.sheetPresentationController?.preferredCornerRadius = 20
        vc.thread = thread

        if currentUserUid == channelInfo?.host {
            print("##### Host: \(channelInfo?.guest)")
            vc.chatUserID = channelInfo?.guest
        } else {
            print("##### Guest: \(channelInfo?.host)")
            vc.chatUserID = channelInfo?.host
        }

        view.endEditing(true)
        present(vc, animated: true)
    }
}

// MARK: - TextView

extension ChatDetailVC {
    func confirmTextView() {
        textView.delegate = self

        textView.text = placeholder
        textView.font = UIFont(name: AppFontName.regular, size: 18)
        textView.backgroundColor = UIColor(hex: "#FFFFFF")
        textView.textColor = UIColor(hex: "#ADADAD")
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        textView.isScrollEnabled = true

        textView.snp.makeConstraints { make in
            make.leading.equalTo(bottomBaseView).offset(8)
            make.bottom.equalTo(bottomBaseView).offset(-38)
            make.width.equalTo(322)
            make.height.greaterThanOrEqualTo(35)
        }
    }
}

// MARK: - Setting Bottom View

extension ChatDetailVC {
    func confirmBottomBaseView() {
        bottomBaseView.backgroundColor = UIColor(hex: "#F1F1F1")

        bottomBaseView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view)
        }
    }

    func confirmEmptyView() {
        bottomBaseView.addSubview(emptyView)
        emptyView.layer.cornerRadius = 10

        emptyView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.bottom.equalTo(textView.snp.bottom).offset(-1)
            make.leading.equalTo(textView.snp.trailing).offset(4)
            make.trailing.equalTo(bottomBaseView).offset(-8)
        }
    }

    func confirmSendMessageIcon() {
        emptyView.addSubview(sendMessageIcon)

        sendMessageIcon.image = UIImage(named: "Send_fill")
        sendMessageIcon.tintColor = UIColor(hex: "#ADADAD")
        sendMessageIcon.contentMode = .scaleAspectFit

        sendMessageIcon.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSendingMessageButton))
        sendMessageIcon.addGestureRecognizer(tapGesture)

        sendMessageIcon.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(emptyView)
        }
    }

    @objc func tappedSendingMessageButton(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: sendMessageIcon, duration: 1, animations: {
            self.sendMessageIcon.image = UIImage(named: "ChangeSend_fill")
        })

        FBStoreManager.shared.addChat(thread: thread, sender: currentUserUid, date: FBStoreManager.shared.dateFormatter(value: Date.now), read: false, content: textView.text ?? "n/a") { chat in
            self.chats.append(chat)

            FBStoreManager.shared.updateChannelSender(thread: self.thread, sender: self.currentUserUid, host: self.channelInfo?.host ?? "n/a", guest: self.channelInfo?.guest ?? "n/a", date: FBStoreManager.shared.dateFormatter(value: Date.now))

            DispatchQueue.main.async {
                self.textView.text = nil
                self.textView.textColor = UIColor(hex: "#505050")
                self.textView.font = UIFont(name: AppFontName.regular, size: 18)
                self.textView.snp.remakeConstraints { make in
                    make.leading.equalTo(self.bottomBaseView).offset(8)
                    make.bottom.equalTo(self.bottomBaseView).offset(-38)
                    make.width.equalTo(334)
                    make.height.greaterThanOrEqualTo(35)
                }

                self.sendMessageIcon.image = UIImage(named: "Send_fill")
            }
        }
    }
}

// MARK: - TableView DataSource

extension ChatDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = chats[indexPath.row]

        if item.sender == currentUserUid {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFeedCell.identifier, for: indexPath) as? MyFeedCell else { return UITableViewCell() }

            cell.myChatContent.text = item.content
            cell.myChatTime.text = dateFormatter(strDate: item.date)

            DispatchQueue.main.async {
                cell.setupUI()
            }

            cell.backgroundColor = .clear
            let background = UIView()
            background.backgroundColor = .clear
            cell.selectedBackgroundView = background
            return cell

        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YourFeedCell.identifier, for: indexPath) as? YourFeedCell else { return UITableViewCell() }

            cell.yourChatContent.text = item.content
            cell.yourChatTime.text = dateFormatter(strDate: item.date)

            if channelInfo?.host == currentUserUid {
                cell.yourProfileImage.image = UIImage(named: channelInfo?.guestProfile ?? "Default")
            } else {
                cell.yourProfileImage.image = UIImage(named: channelInfo?.hostProfile ?? "Default")
            }

            DispatchQueue.main.async {
                cell.setupUI()
            }

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedYourProfileImage))
            cell.yourProfileImage.isUserInteractionEnabled = true
            cell.yourProfileImage.addGestureRecognizer(tapGesture)

            cell.backgroundColor = .clear
            let background = UIView()
            background.backgroundColor = .clear
            cell.selectedBackgroundView = background
            return cell
        }
    }

    @objc func tappedYourProfileImage() {
        let vc = ChatProfileVC()
        vc.channelInfo = channelInfo
        vc.currentUserID = currentUserUid
        present(vc, animated: true)
    }
}

// MARK: - TableView Delegate

extension ChatDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("#### 스크롤됨")
        textView.resignFirstResponder()
    }

    // TODO: 무한 스크롤링 구현
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
//                beginBatchFetch()
            }
        }
    }

    // TODO: 무한 스크롤링 구현
    func beginBatchFetch() {
        fetchingMore = true
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
        count += 10
        FBStoreManager.shared.loadChatting(channelName: "channels", thread: thread, startIndex: count) { chat in
            self.chats += chat
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                print("&&& \(self.count)")
                self.fetchingMore = false
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Custom Back Button

extension ChatDetailVC {
    func makeBackButton() {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackBarButton))
        backBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        navigationItem.leftBarButtonItem = backBarButtonItem
    }

    @objc func didTapBackBarButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextViewDelegate

extension ChatDetailVC: UITextViewDelegate {
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

// MARK: - hideKeyboardWhenTappedAround

extension ChatDetailVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatDetailVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - 키보드 올렸을 때 뷰 올리는 코드

extension ChatDetailVC {
    func keyboardCheck() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(didShowKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func willShowKeyboard(notification: NSNotification) {
        print("#### \(#function)")
        if chats.isEmpty != true {
            let endexIndex = IndexPath(row: chats.count - 1, section: 0)
            tableView.scrollToRow(at: endexIndex, at: .bottom, animated: true)
        }

        textView.isScrollEnabled = false

        if textView.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if view.frame.origin.y == textViewPosY {
                    blankMessage.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.bottom.equalTo(bottomBaseView.snp.top).offset(-175)
                        make.leading.equalTo(view).offset(50)
                        make.height.equalTo(20)
                    }

                    bottomBaseView.snp.remakeConstraints { make in
                        make.height.equalTo(80)
                        make.leading.equalToSuperview()
                        make.trailing.equalToSuperview()
                        make.bottom.equalTo(view).inset(keyboardSize.height - 27)
                    }

                    tableView.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.top.equalTo(view.safeAreaLayoutGuide)
                        make.leading.equalToSuperview()
                        make.bottom.equalTo(bottomBaseView.snp.top)
                    }
                }
            }
        }
    }

    @objc func didShowKeyboard(notification: NSNotification) {
        print("#### \(#function)")

        if chats.isEmpty != true {
            let endexIndex = IndexPath(row: chats.count - 1, section: 0)
            tableView.scrollToRow(at: endexIndex, at: .bottom, animated: true)
        }

        textView.isScrollEnabled = false

        if textView.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if view.frame.origin.y == textViewPosY {
                    blankMessage.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.bottom.equalTo(bottomBaseView.snp.top).offset(-175)
                        make.leading.equalTo(view).offset(50)
                        make.height.equalTo(20)
                    }

                    bottomBaseView.snp.remakeConstraints { make in
                        make.height.equalTo(80)
                        make.leading.equalToSuperview()
                        make.trailing.equalToSuperview()
                        make.bottom.equalTo(view).inset(keyboardSize.height - 27)
                    }

                    tableView.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.top.equalTo(view.safeAreaLayoutGuide)
                        make.leading.equalToSuperview()
                        make.bottom.equalTo(bottomBaseView.snp.top)
                    }
                }
            }
        }
    }

    @objc func willHideKeyboard(notification: NSNotification) {
        print("#### \(#function)")

        blankMessage.snp.remakeConstraints { make in
            make.height.equalTo(20)
            make.centerX.centerY.equalToSuperview()
        }

        bottomBaseView.snp.remakeConstraints { make in
            make.height.equalTo(80)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view)
        }

        tableView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.bottom.equalTo(bottomBaseView.snp.top)
            make.height.greaterThanOrEqualTo(600)
        }
    }
}

// MARK: - Date Formatting

extension ChatDetailVC {
    func dateFormatter(strDate: String) -> String {
        let strDateFormatter = DateFormatter()
        strDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        strDateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard var date = strDateFormatter.date(from: strDate) else { return "" }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
}

// MARK: - Swipe Gesture To PopNavigation

extension ChatDetailVC {
    func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)
    }

    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
    }
}
