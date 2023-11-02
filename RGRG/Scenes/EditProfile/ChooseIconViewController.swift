//
//  ChooseIconViewController.swift
//  RGRG
//
//  Created by 이수현 on 10/27/23.
//

import FirebaseStorage
import UIKit

protocol sendSelectedIconDelegate {
    func sendSelectedIcon(iconString: String)
}

class ChooseIconViewController: UIViewController {
    let iconsName = ["Default", "1", "2", "3", "4", "5", "6", "7", "8", "13", "18", "20", "22", "25", "28"]
    
    var delegate: sendSelectedIconDelegate?
    
    var currentImageString: String?
    var selectedImageString: String?
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.rgrgColor3.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = .rgrgColor7
        return imageView
    }()
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 56)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let selectButton = CustomButton()

    deinit {
        print("### NotificationViewController deinitialized")
    }
}

extension ChooseIconViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {}
}

extension ChooseIconViewController {
    func configureUI() {
        setupButton()
        setImage()
        view.backgroundColor = .rgrgColor5
        [profileImage, imageCollectionView, selectButton].forEach { view.addSubview($0) }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        selectButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-26)
            make.height.equalTo(60)
            make.width.equalTo(329)
            make.centerX.equalToSuperview()
        }
        
        imageCollectionView.snp.makeConstraints { make in
            
            make.top.equalTo(profileImage.snp.bottom).offset(58)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(selectButton.snp.top).offset(-2)
        }
    }
    
    func setupButton() {
        selectButton.backgroundColor = .rgrgColor4
        selectButton.layer.cornerRadius = 10
        selectButton.setTitle("선택", for: .normal)
        selectButton.titleLabel?.font = .myBoldSystemFont(ofSize: 15)
        selectButton.addTarget(self, action: #selector(selectButtonPressed), for: .touchUpInside)
    }
    
    func setImage() {
        profileImage.image = UIImage(named: currentImageString ?? "Default")
    }
    
    @objc func selectButtonPressed() {
        delegate?.sendSelectedIcon(iconString: selectedImageString ?? "Default")
        navigationController?.popViewController(animated: true)
    }
}

extension ChooseIconViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        imageCollectionView.register(IconCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? IconCollectionViewCell else { return UICollectionViewCell()
        }
        cell.iconImage.image = UIImage(named: iconsName[indexPath.row])
        var imageIndex = iconsName.firstIndex(of: currentImageString ?? "Default")
        if indexPath.row == imageIndex {
            cell.layer.borderColor = UIColor.rgrgColor3.cgColor
            cell.layer.borderWidth = 2
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let interval: CGFloat = 20
        let width: CGFloat = (collectionView.frame.width - interval * 2 - 56 * 2) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewCell {
            cell.layer.borderColor = UIColor.rgrgColor2.cgColor
            cell.layer.borderWidth = 2
            profileImage.image = UIImage(named: iconsName[indexPath.row])
            selectedImageString = iconsName[indexPath.row]
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewCell {
            cell.layer.borderWidth = 0
            var imageIndex = iconsName.firstIndex(of: currentImageString ?? "Default")
            if indexPath.row == imageIndex {
                cell.layer.borderColor = UIColor.rgrgColor3.cgColor
                cell.layer.borderWidth = 2
            }
        }
    }
}
