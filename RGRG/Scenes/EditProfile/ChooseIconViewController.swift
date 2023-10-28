//
//  ChooseIconViewController.swift
//  RGRG
//
//  Created by 이수현 on 10/27/23.
//

import FirebaseStorage
import UIKit

class ChooseIconViewController: UIViewController {
    var fileList: [StorageReference]?
    
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
        StorageManager.shared.getAllImage("icons") { files in
            self.fileList = files
            DispatchQueue.main.async {}
        }
    }
}

extension ChooseIconViewController {
    func configureUI() {
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
            make.left.right.equalToSuperview().inset(56)
            make.bottom.equalTo(selectButton.snp.top).offset(-2)
        }
    }
}

extension ChooseIconViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        imageCollectionView.register(IconCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? IconCollectionViewCell else { return UICollectionViewCell()
        }
        cell.backgroundColor = .master
        
        return cell
    }
}
