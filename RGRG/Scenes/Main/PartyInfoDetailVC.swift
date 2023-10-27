//
//  PartyInfoDetailVC.swift
//  RGRG
//
//  Created by t2023-m0064 on 2023/10/19.
//

import Foundation
import SnapKit
import UIKit



class PartyInfoDetailVC: UIViewController {
    
    
    
    let topFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let pageTitleLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
//        button.backgroundColor = UIColor.RGRGColor2
//        button.layer.cornerRadius = (10)
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
        View.layer.borderColor = UIColor.systemGray2.cgColor
        View.layer.borderWidth = 2
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
//        label.layer.borderColor = UIColor.systemGray2.cgColor
//        label.layer.borderWidth = 2
//        label.layer.cornerRadius = 12
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
        textView.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
//        textView.backgroundColor = .orange
        return textView
    }()
    
    let championLabel: UILabel = {
        let label = UILabel()
        label.text = "주 챔피언"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        return label
    }()
    
    let requiredPositionImage: UIImageView = {
        var imageView = UIImageView()
        if let image = UIImage(named: "미드w") {
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .RGRGColor6
//        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 22.5


        return imageView
    }()
    
    
//    let requiredPositionImage: UIImageView = {
//        var imageView = UIImageView()
//
//        if let image = UIImage(named: "미드w") {
//            // 이미지 크기 조절
//            let newSize = CGSize(width: image.size.width * 0.1, height: image.size.height * 0.1)
//            let scaledImage = image.resize(to: newSize)
//            imageView.image = scaledImage
//        }
//
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .RGRGColor6
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.cornerRadius = 22.5
//
//        return imageView
//    }()



    
    
    
    let confirmationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("듀오 신청하기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.RGRGColor4
        button.layer.cornerRadius = (10)
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
    }
    
    
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func configureUI() {
        view.backgroundColor = .systemGray5
        
        view.addSubview(topFrame)
        topFrame.addSubview(pageTitleLabel)
//        topFrame.addSubview(backButton)
        
//        view.addSubview(scrollView)
        view.addSubview(contentView)
        
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
        midframeView.addSubview(requiredPositionImage)
        
        contentView.addSubview(bottomframeView)
        bottomframeView.addSubview(confirmationButton)
        
        
        
        
        
        topFrame.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(90)
        }
        
        pageTitleLabel.snp.makeConstraints{
            $0.top.equalTo(topFrame.snp.top).offset(62)
            $0.centerX.equalTo(topFrame)
        }
        
//        backButton.snp.makeConstraints{
//            $0.top.equalTo(topFrame.snp.top).offset(55)
//            $0.leading.equalTo(topFrame.snp.leading).offset(25)
//        }
        
        
        contentView.snp.makeConstraints{
            $0.top.equalTo(topFrame.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
        }
        
        
        topframeView.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top).offset(0)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.height.equalTo(95)
            //            $0.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        
        profileImage.snp.makeConstraints{
            $0.top.equalTo(topframeView.snp.top).offset(20)
            $0.leading.equalTo(topframeView.snp.leading).offset(16)
            $0.height.width.equalTo(52)
            $0.bottom.equalTo(topframeView.snp.bottom).offset(-24)
        }
        
        positionImageFrame.snp.makeConstraints{
            //            $0.top.equalTo(cellFrameView.snp.top).offset(14)
            $0.trailing.equalTo(profileImage.snp.trailing).offset(5)
            $0.height.width.equalTo(17)
            $0.bottom.equalTo(profileImage.snp.bottom).offset(0)
        }
        
        positionImage.snp.makeConstraints{
            //            $0.top.equalTo(cellFrameView.snp.top).offset(14)
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
        
        
        
        midframeView.snp.makeConstraints{
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
        
        firstMostChampionImage.snp.makeConstraints{
            $0.top.equalTo(mostChampionFrame.snp.top).offset(0)
            $0.height.width.equalTo(45)
            $0.leading.equalTo(mostChampionFrame.snp.leading).offset(8)
        }
        
        secondMostChampionImage.snp.makeConstraints{
            $0.top.equalTo(mostChampionFrame.snp.top).offset(0)
            $0.height.width.equalTo(45)
            $0.leading.equalTo(firstMostChampionImage.snp.trailing).offset(11)
        }
        
        thirdMostChampionImage.snp.makeConstraints{
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
        
        requiredPositionImage.snp.makeConstraints{
            $0.top.equalTo(requiredPositionLabel.snp.bottom).offset(12)
            $0.height.width.equalTo(45)
            $0.leading.equalTo(requiredPositionLabel.snp.leading).offset(0)
        }
        
        
        
        bottomframeView.snp.makeConstraints{
            $0.top.equalTo(midframeView.snp.bottom).offset(3)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        
        confirmationButton.snp.makeConstraints{
            $0.leading.equalTo(bottomframeView.snp.leading).offset(17)
            $0.trailing.equalTo(bottomframeView.snp.trailing).offset(-17)
            $0.bottom.equalTo(bottomframeView.snp.bottom).offset(-30)
            $0.height.equalTo(60)

        }
        scrollView.contentSize = contentView.bounds.size
    }
}



