//
//  PartyDetailVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/19.
//

import FirebaseAuth
import FirebaseStorage
import Foundation
import SnapKit
import UIKit

#warning("UI 코드 중복 제거 및 공용 컴포넌트 활용할 것")
class PartyDetailVC: UIViewController {
    var party: PartyInfo?
    var user: UserInfo?
    var partyID = ""
    var isExist: Bool?
    var channels: [ChannelInfo] = []
    var existcount = 0
    
    let rightBarButtonItem = CustomBarButton()
    
    var eventHandler: ((String) -> ())?
    
    let topFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .rgrgColor5
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        return stackView
    }()
    
    let topframeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerRadius = 10
        return view
    }()
    
    let midframeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let bottomframeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let profileImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 26
        return imageView
    }()
    
    let positionImageFrame: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .gray
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 8.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return view
    }()
    
    let positionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "미드w") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "페이커짱"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let tierLabelFrame: UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        View.layer.borderColor = UIColor.systemGray3.cgColor
        View.layer.borderWidth = 1
        View.layer.cornerRadius = 13
        return View
    }()
    
    let tierLabel: UILabel = {
        let label = UILabel()
        label.text = "bronze"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let textTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "국밥탑 등반 듀오구합니다@@  • • •"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "3분 전"
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1)
        return label
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "듀오 하실 분 구합니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@ 현재 플레 1이구요. 든든하게 국밥챔프 위주로만 플레이 합니다,.. 간절하신 분이였으면 좋겠어요\n다이아,,.. 가봅시다요ㅠㅠ 최고 티어는 다이아 3까지 갔었습니다. 같이 다이아 등반 하실 분 구합니다"
        textView.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        return textView
    }()
    
    let championLabel: UILabel = {
        let label = UILabel()
        label.text = "주 챔피언"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        return label
    }()
    
    let mostChampionFrame: UIView = {
        let View = UIView()
        return View
    }()
    
    let firstMostChampionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 22.5
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return imageView
    }()
    
    let secondMostChampionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 22.5
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return imageView
    }()
    
    let thirdMostChampionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "profileImageIcon") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 22.5
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return imageView
    }()
    
    let requiredPositionLabel: UILabel = {
        let label = UILabel()
        label.text = "듀오 희망 포지션"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        return label
    }()
    
    let fitstRequiredPositionFrame: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 22.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    let requiredPositionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "미드w") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        imageView.layer.cornerRadius = 10.5
        return imageView
    }()

    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("듀오 신청하기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.rgrgColor4
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        return button
    }()
}

// MARK: - View Life Cycle

extension PartyDetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        channels.removeAll()
        navigationController?.navigationBar.isHidden = false
        setupUI()
        FBStoreManager.shared.loadChannels(collectionName: "channels", filter: party?.writer ?? "n/a") { channels, _ in
            
            var hostCount = channels.filter { $0.host == self.user?.uid }
            var guestCount = channels.filter { $0.guest == self.user?.uid }
            
            if hostCount.count > 0 {
                self.existcount = hostCount.count
            } else if guestCount.count > 0 {
                self.existcount = guestCount.count
            } else {
                self.existcount = 0
            }

            print("##### 현재 \(self.existcount)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        channels.removeAll()
    }
}

// MARK: - Setting UI

extension PartyDetailVC {
    func setupUI() {
        if party?.writer == user?.uid {
            confirmationButton.isHidden = true
        }
        
        userNameLabel.text = party?.userName
        textTitleLabel.text = party?.title
        textView.text = party?.content
        timeLabel.text = FBPartyManager.shared.dateFormatter(strDate: party?.date ?? "No Date")
        profileImage.image = UIImage(named: party?.profileImage ?? "Default")
        positionImage.image = UIImage(named: party?.position ?? "Top")
        requiredPositionImage.image = UIImage(named: party?.hopePosition[0] ?? "Top")
        
        tierLabel.text = party?.tier
        
        if let tier = party?.tier {
            tierLabel.textColor = getColorForTier(tier)
        }
        
        func getColorForTier(_ tier: String) -> UIColor {
            switch tier {
            case "Iron":
                return UIColor.iron
            case "Bronze":
                return UIColor.bronze
            case "Silver":
                return UIColor.silver
            case "Gold":
                return UIColor.gold
            case "Platinum":
                return UIColor.platinum
            case "Emerald":
                return UIColor.emerald
            case "Diamond":
                return UIColor.diamond
            case "Master":
                return UIColor.master
            case "GrandMaster":
                return UIColor.grandMaster
            case "Challenger":
                return UIColor.challenger
            default:
                return UIColor.black
            }
        }
        
        if let firstImageURL = party?.champion[0] {
            FBStorageManager.shared.getImage("champ", firstImageURL) { firstImage in
                DispatchQueue.main.async {
                    self.firstMostChampionImage.image = firstImage
                }
            }
        }
        
        if let secondImageURL = party?.champion[1] {
            FBStorageManager.shared.getImage("champ", secondImageURL) { secondImage in
                DispatchQueue.main.async {
                    self.secondMostChampionImage.image = secondImage
                }
            }
        }

        if let thirdImageURL = party?.champion[2] {
            FBStorageManager.shared.getImage("champ", thirdImageURL) { thirdImage in
                DispatchQueue.main.async {
                    self.thirdMostChampionImage.image = thirdImage
                }
            }
        }
        
        if userNameLabel.text == "알 수 없음" {
            confirmationButton.backgroundColor = UIColor.rgrgColor6
        }

        configureUI()
        makeBackButton()
        swipeRecognizer()
        
        if user?.uid == party?.writer {
            makeMyRightBarButton()
        } else {
            makeOtherRightBarButton()
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(topFrame)
        topFrame.addSubview(contentView)
        
        contentView.addSubview(topframeView)
        topframeView.addSubview(profileImage)
        topframeView.addSubview(positionImageFrame)
        positionImageFrame.addSubview(positionImage)
        topframeView.addSubview(userNameLabel)
        topframeView.addSubview(tierLabelFrame)
        tierLabelFrame.addSubview(tierLabel)
        
        contentView.addSubview(midframeView)
        midframeView.addSubview(textTitleLabel)
        midframeView.addSubview(timeLabel)
        midframeView.addSubview(textView)
        midframeView.addSubview(championLabel)
        midframeView.addSubview(mostChampionFrame)
        mostChampionFrame.addSubview(firstMostChampionImage)
        mostChampionFrame.addSubview(secondMostChampionImage)
        mostChampionFrame.addSubview(thirdMostChampionImage)
        midframeView.addSubview(requiredPositionLabel)
        midframeView.addSubview(fitstRequiredPositionFrame)
        fitstRequiredPositionFrame.addSubview(requiredPositionImage)
        
        contentView.addSubview(bottomframeView)
        bottomframeView.addSubview(confirmationButton)
        
        topFrame.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(topFrame.snp.top).offset(10)
            $0.bottom.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
        }
        
        topframeView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(0)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.height.equalTo(95)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(topframeView.snp.top).offset(20)
            $0.leading.equalTo(topframeView.snp.leading).offset(16)
            $0.height.width.equalTo(52)
            $0.bottom.equalTo(topframeView.snp.bottom).offset(-24)
        }
        
        positionImageFrame.snp.makeConstraints {
            $0.trailing.equalTo(profileImage.snp.trailing).offset(5)
            $0.height.width.equalTo(17)
            $0.bottom.equalTo(profileImage.snp.bottom).offset(0)
        }
        
        positionImage.snp.makeConstraints {
            $0.trailing.equalTo(positionImageFrame.snp.trailing).offset(-2)
            $0.height.width.equalTo(13)
            $0.bottom.equalTo(positionImageFrame.snp.bottom).offset(-2)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(topframeView.snp.top).offset(17)
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
        }
        
        tierLabelFrame.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
            $0.bottom.equalTo(topframeView.snp.bottom).offset(-22)
        }
        
        tierLabel.snp.makeConstraints {
            $0.top.equalTo(tierLabelFrame.snp.top).offset(4)
            $0.leading.equalTo(tierLabelFrame.snp.leading).offset(12)
            $0.trailing.equalTo(tierLabelFrame.snp.trailing).offset(-12)
            $0.bottom.equalTo(tierLabelFrame.snp.bottom).offset(-4)
        }
        
        midframeView.snp.makeConstraints {
            $0.top.equalTo(topframeView.snp.bottom).offset(3)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.height.equalTo(397)
        }
        
        textTitleLabel.snp.makeConstraints {
            $0.top.equalTo(midframeView.snp.top).offset(13)
            $0.leading.equalTo(midframeView.snp.leading).offset(14)
            $0.trailing.equalTo(midframeView.snp.trailing).offset(-14)
            $0.height.equalTo(31)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(textTitleLabel.snp.bottom).offset(0)
            $0.trailing.equalTo(midframeView.snp.trailing).offset(-14)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(7)
            $0.height.equalTo(132)
            $0.leading.equalTo(midframeView.snp.leading).offset(14)
            $0.trailing.equalTo(midframeView.snp.trailing).offset(-14)
        }
        
        championLabel.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(81)
            $0.height.equalTo(31)
            $0.width.equalTo(81)
            $0.leading.equalTo(midframeView.snp.leading).offset(14)
        }
        
        mostChampionFrame.snp.makeConstraints {
            $0.top.equalTo(championLabel.snp.bottom).offset(12)
            $0.height.equalTo(45)
            $0.width.equalTo(165)
            $0.leading.equalTo(midframeView.snp.leading).offset(14)
        }
        
        firstMostChampionImage.snp.makeConstraints {
            $0.top.equalTo(mostChampionFrame.snp.top).offset(0)
            $0.height.width.equalTo(45)
            $0.leading.equalTo(mostChampionFrame.snp.leading).offset(8)
        }
        
        secondMostChampionImage.snp.makeConstraints {
            $0.top.equalTo(mostChampionFrame.snp.top).offset(0)
            $0.height.width.equalTo(45)
            $0.leading.equalTo(firstMostChampionImage.snp.trailing).offset(11)
        }
        
        thirdMostChampionImage.snp.makeConstraints {
            $0.top.equalTo(mostChampionFrame.snp.top).offset(0)
            $0.height.width.equalTo(45)
            $0.leading.equalTo(secondMostChampionImage.snp.trailing).offset(11)
        }
        
        requiredPositionLabel.snp.makeConstraints {
            $0.top.equalTo(championLabel.snp.top).offset(0)
            $0.height.equalTo(31)
            $0.width.equalTo(139)
            $0.trailing.equalTo(midframeView.snp.trailing).offset(-14)
        }
        
        fitstRequiredPositionFrame.snp.makeConstraints {
            $0.top.equalTo(requiredPositionLabel.snp.bottom).offset(12)
            $0.height.width.equalTo(45)
            $0.leading.equalTo(requiredPositionLabel.snp.leading).offset(0)
        }
        
        requiredPositionImage.snp.makeConstraints {
            $0.top.equalTo(fitstRequiredPositionFrame.snp.top).offset(5)
            $0.height.width.equalTo(35)
            $0.leading.equalTo(fitstRequiredPositionFrame.snp.leading).offset(5)
        }
        
        bottomframeView.snp.makeConstraints {
            $0.top.equalTo(midframeView.snp.bottom).offset(3)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        
        confirmationButton.snp.makeConstraints {
            $0.leading.equalTo(bottomframeView.snp.leading).offset(17)
            $0.trailing.equalTo(bottomframeView.snp.trailing).offset(-17)
            $0.bottom.equalTo(bottomframeView.snp.bottom).offset(-30)
            $0.height.equalTo(60)
        }
        scrollView.contentSize = contentView.bounds.size
    }
}

// MARK: - Functions

extension PartyDetailVC {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func menuButtonTapped() {
        if userNameLabel.text == "알 수 없음" {
            let alert = UIAlertController(title: "탈퇴한 유저", message: "해당 유저는 탈퇴한 유저입니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            
            present(alert, animated: true)
        } else {
            if existcount == 0 {
                // 유저 없음
                
                if let user = user {
                    // 자기 자신 user의 uid 필드 필요
                    FBStoreManager.shared.addChannel(channelTitle: party?.writer ?? "n/a", guest: party?.writer ?? "n/a", host: user.uid, channelID: party?.writer ?? "", date: FBStoreManager.shared.dateFormatter(value: Date.now), users: [party?.writer ?? "n/a", user.uid], guestProfile: party?.profileImage ?? "n/a", hostProfile: user.profilePhoto, hostSender: false, guestSender: false) { channel in
                        print("### 채널 추가 하기 :: \(channel)")
                    }
                    navigationController?.popViewController(animated: true)
                }
            } else {
                // 유저 있음
                showAlert()
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "해당 유저와 채팅 중입니다.", message: "", preferredStyle: .alert)
        let confirmAlert = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAlert)
        present(alert, animated: true)
    }
}

// MARK: - Right Bar Button

extension PartyDetailVC {
    func makeMyRightBarButton() {
        // 액션 만들기 >> 메뉴 만들기 >> UIBarButtonItem 만들기
        let latestSortAction = rightBarButtonItem.makeSingleAction(title: "게시글 수정", attributes: .keepsMenuPresented, state: .off) { _ in
            print("### 수정하기 알파입니다.")
            let editVC = PartyCreateVC()

            editVC.thread = self.partyID
            editVC.tag = 2
            editVC.user = self.user
            editVC.partyNameTextField.text = self.party?.title
            editVC.infoTextView.text = self.party?.content
            editVC.hopePositionArray = self.party?.hopePosition
           
            editVC.eventHandler = { party in
                self.party = party
                self.viewWillAppear(true)
            }
            
            self.navigationController?.pushViewController(editVC, animated: true)
        }

        let bookMarkAction = rightBarButtonItem.makeSingleAction(title: "삭제", attributes: .destructive, state: .off) { [weak self] _ in
            guard let self = self else { return }
            
            FBPartyManager.shared.deleteParty(thread: partyID) {
                let vc = PartyVC()
                vc.viewWillAppear(true)
                self.navigationController?.popViewController(animated: true)
            }
            print("### 삭제하기 알파입니다.")
        }

        let menu = [latestSortAction, bookMarkAction]

        let uiMenu = rightBarButtonItem.makeUIMenu(title: "", opetions: .displayInline, uiActions: menu)

        navigationItem.rightBarButtonItem?.changesSelectionAsPrimaryAction = false

        rightBarButtonItem.image = UIImage(named: "verticalEllipsis")
        rightBarButtonItem.menu = uiMenu
        rightBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func makeOtherRightBarButton() {
        // 액션 만들기 >> 메뉴 만들기 >> UIBarButtonItem 만들기
        let latestSortAction = rightBarButtonItem.makeSingleAction(title: "차단하기", attributes: .destructive, state: .off) { _ in
            self.showBenAlert()
            print("차단하기")
        }

        let menu = [latestSortAction]

        let uiMenu = rightBarButtonItem.makeUIMenu(title: "게시글 차단", opetions: .displayInline, uiActions: menu)

        navigationItem.rightBarButtonItem?.changesSelectionAsPrimaryAction = false

        rightBarButtonItem.image = UIImage(named: "verticalEllipsis")
        rightBarButtonItem.menu = uiMenu
        rightBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func makeBackButton() {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "chevron.left"), style: .plain, target: self, action: #selector(tappedBackButton))
        backBarButtonItem.tintColor = UIColor(hex: "#0C356A")
        navigationItem.leftBarButtonItem = backBarButtonItem
    }

    @objc func tappedBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension PartyDetailVC {
    func showBenAlert() {
        let alert = UIAlertController(title: "차단하시겠습니까?", message: "차단 하시면 차단된 친구의 글 정보 볼 수 없습니다.", preferredStyle: .alert)
        let confirmAlert = UIAlertAction(title: "차단", style: .destructive, handler: { _ in
            UserBlockManager.shared.blockUser(uid: self.party?.writer ?? "")
            self.eventHandler?(self.party?.writer ?? "")
            
            self.navigationController?.popViewController(animated: true)
            
        })
        
        let cancelAlert = UIAlertAction(title: "취소", style: .default)
        [confirmAlert, cancelAlert].forEach {
            alert.addAction($0)
        }
        
        present(alert, animated: true)
    }
}

// MARK: - 옆으로 제스처해서 뒤로가기

extension PartyDetailVC {
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
