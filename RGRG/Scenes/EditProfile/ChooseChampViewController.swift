//
//  ChooseChampViewController.swift
//  RGRG
//
//  Created by 이수현 on 10/27/23.
//

import FirebaseStorage
import UIKit

class ChooseChampViewController: UIViewController {
    let champName = ["Garen", "Galio", "Gangplank", "Gragas", "Graves", "Gwen", "Gnar", "Nami", "Nasus", "Naafiri", "Nautilus", "Nocturne", "Nunu", "Nidalee", "Neeko", "Nilah", "Darius", "Diana", "Draven", "Ryze", "Rakan", "Rammus", "Lux", "Rumble", "Renata", "Renekton", "Leona", "RekSai", "Rell", "Rengar", "Lucian", "Lulu", "Leblanc", "LeeSin", "Riven", "Lissandra", "Lillia", "MasterYi", "Maokai", "Malzahar", "Malphite", "Mordekaiser", "Morgana", "DrMundo", "MissFortune", "Milio", "Bard", "Varus", "Vi", "Veigar", "Vayne", "Vex", "Belveth", "Velkoz", "Volibear", "Braum", "Briar", "Brand", "Vladimir", "Blitzcrank", "Viego", "Viktor", "Poppy", "Samira", "Sion", "Sylas", "Shaco", "Senna", "Seraphine", "Sejuani", "Sett", "Sona", "Soraka", "Shen", "Shyvana", "Swain", "Skarner", "Sivir", "XinZhao", "Syndra", "Singed", "Thresh", "Ahri", "Amumu", "AurelionSol", "Ivern", "Azir", "Akali", "Akshan", "Aatrox", "Aphelios", "Alistar", "Annie", "Anivia", "Ashe", "Yasuo", "Ekko", "Elise", "MonkeyKing", "Ornn", "Orianna", "Olaf", "Yone", "Yorick", "Udyr", "Urgot", "Warwick", "Yuumi", "Irelia", "Evelynn", "Ezreal", "Illaoi", "JarvanIV", "Xayah", "Zyra", "Zac", "Janna", "Jax", "Zed", "Xerath", "Zeri", "Jayce", "Zoe", "Ziggs", "Jhin", "Zilean", "Jinx", "Chogath", "Karma", "Camille", "Kassadin", "Karthus", "Cassiopeia", "Kaisa", "Khazix", "Katarina", "Kalista", "Kennen", "Caitlyn", "Kayn", "Kayle", "KogMaw", "Corki", "Quinn", "KSante", "Kled", "Qiyana", "Kindred", "Taric", "Talon", "Taliyah", "TahmKench", "Trundle", "Tristana", "Tryndamere", "TwistedFate", "Twitch", "Teemo", "Pyke", "Pantheon", "Fiddlesticks", "Fiora", "Fizz", "Heimerdinger", "Hecarim"]
    
    var presentChamp: [String]?
    
    let firstImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 91, height: 91)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.rgrgColor3.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = .rgrgColor7
        return imageView
    }()

    let secondImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 91, height: 91)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.rgrgColor3.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = .rgrgColor7
        return imageView
    }()

    let thirdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 91, height: 91)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.rgrgColor3.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = .rgrgColor7
        return imageView
    }()
    
    let mostChampImgStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16.3
        stackView.distribution = .fillEqually
        return stackView

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

extension ChooseChampViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureUI()
        print("~~~")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageCollectionView.reloadData()
    }
}

extension ChooseChampViewController {
    func configureUI() {
        setupButton()
        view.backgroundColor = .rgrgColor5
        
        [firstImage, secondImage, thirdImage].forEach { mostChampImgStackView.addArrangedSubview($0) }
        [mostChampImgStackView, imageCollectionView, selectButton].forEach { view.addSubview($0) }
        
        mostChampImgStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(91)
            make.width.equalTo(317)
        }
        
        selectButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-26)
            make.height.equalTo(60)
            make.width.equalTo(329)
            make.centerX.equalToSuperview()
        }
        
        imageCollectionView.snp.makeConstraints { make in
            
            make.top.equalTo(mostChampImgStackView.snp.bottom).offset(79)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(selectButton.snp.top).offset(-2)
        }
    }
    
    func setupButton() {
        selectButton.backgroundColor = .rgrgColor4
        selectButton.layer.cornerRadius = 10
        selectButton.setTitle("선택", for: .normal)
        selectButton.titleLabel?.font = .myBoldSystemFont(ofSize: 15)
//        selectButton.addTarget(self, action: #selector(selectButtonPressed), for: .touchUpInside)
    }
    
    func setupImage() {
        firstImage.image = UIImage(named: presentChamp?[0] ?? "None")
        secondImage.image = UIImage(named: presentChamp?[1] ?? "None")
        thirdImage.image = UIImage(named: presentChamp?[2] ?? "None")
    }
    
//    @objc func selectButtonPressed() {
//        delegate?.sendChangedImage(image: selectedImageString ?? "Default")
//        navigationController?.popViewController(animated: true)
//    }
}

extension ChooseChampViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        imageCollectionView.register(IconCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? IconCollectionViewCell else { return UICollectionViewCell()
        }
        cell.iconImage.image = UIImage(named: champName[indexPath.row])
//        var imageIndex = champName.firstIndex(of: imageString ?? "None")
//        if indexPath.row == imageIndex {
//            cell.layer.borderColor = UIColor.rgrgColor3.cgColor
//            cell.layer.borderWidth = 2
//        }
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewCell {
//            cell.layer.borderColor = UIColor.rgrgColor2.cgColor
//            cell.layer.borderWidth = 2
//            profileImage.image = UIImage(named: iconsName[indexPath.row])
//            selectedImageString = iconsName[indexPath.row]
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewCell {
//            cell.layer.borderWidth = 0
//            var imageIndex = iconsName.firstIndex(of: imageString ?? "Default")
//            if indexPath.row == imageIndex {
//                cell.layer.borderColor = UIColor.rgrgColor3.cgColor
//                cell.layer.borderWidth = 2
//            }
//        }
//    }
}
