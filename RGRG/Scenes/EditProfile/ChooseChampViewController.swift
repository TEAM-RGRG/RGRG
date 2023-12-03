//
//  ChooseChampViewController.swift
//  RGRG
//
//  Created by 이수현 on 10/27/23.
//

import FirebaseStorage
import UIKit

protocol SendSelectedChampDelegate {
    func sendSelectedChamp(champArray: [String])
}

class ChooseChampViewController: UIViewController {
    let champName = ["Garen", "Galio", "Gangplank", "Gragas", "Graves", "Gwen", "Gnar", "Nami", "Nasus", "Naafiri", "Nautilus", "Nocturne", "Nunu", "Nidalee", "Neeko", "Nilah", "Darius", "Diana", "Draven", "Ryze", "Rakan", "Rammus", "Lux", "Rumble", "Renata", "Renekton", "Leona", "RekSai", "Rell", "Rengar", "Lucian", "Lulu", "Leblanc", "LeeSin", "Riven", "Lissandra", "Lillia", "MasterYi", "Maokai", "Malzahar", "Malphite", "Mordekaiser", "Morgana", "DrMundo", "MissFortune", "Milio", "Bard", "Varus", "Vi", "Veigar", "Vayne", "Vex", "Belveth", "Velkoz", "Volibear", "Braum", "Briar", "Brand", "Vladimir", "Blitzcrank", "Viego", "Viktor", "Poppy", "Samira", "Sion", "Sylas", "Shaco", "Senna", "Seraphine", "Sejuani", "Sett", "Sona", "Soraka", "Shen", "Shyvana", "Swain", "Skarner", "Sivir", "XinZhao", "Syndra", "Singed", "Thresh", "Ahri", "Amumu", "AurelionSol", "Ivern", "Azir", "Akali", "Akshan", "Aatrox", "Aphelios", "Alistar", "Annie", "Anivia", "Ashe", "Yasuo", "Ekko", "Elise", "MonkeyKing", "Ornn", "Orianna", "Olaf", "Yone", "Yorick", "Udyr", "Urgot", "Warwick", "Yuumi", "Irelia", "Evelynn", "Ezreal", "Illaoi", "JarvanIV", "Xayah", "Zyra", "Zac", "Janna", "Jax", "Zed", "Xerath", "Zeri", "Jayce", "Zoe", "Ziggs", "Jhin", "Zilean", "Jinx", "Chogath", "Karma", "Camille", "Kassadin", "Karthus", "Cassiopeia", "Kaisa", "Khazix", "Katarina", "Kalista", "Kennen", "Caitlyn", "Kayn", "Kayle", "KogMaw", "Corki", "Quinn", "KSante", "Kled", "Qiyana", "Kindred", "Taric", "Talon", "Taliyah", "TahmKench", "Trundle", "Tristana", "Tryndamere", "TwistedFate", "Twitch", "Teemo", "Pyke", "Pantheon", "Fiddlesticks", "Fiora", "Fizz", "Heimerdinger", "Hecarim"]
    let champNameKor = ["가렌", "갈리오", "갱플랭크", "그라가스", "그레이브즈", "그웬", "나르", "나미", "나서스", "나피리", "노틸러스", "녹턴", "누누와 윌럼프", "니달리", "니코", "닐라", "다리우스", "다이애나", "드레이븐", "라이즈", "라칸", "람머스", "럭스", "럼블", "레나타 글라스크", "레넥톤", "레오나", "렉사이", "렐", "렝가", "루시안", "룰루", "르블랑", "리신", "리븐", "리산드라", "릴리아", "마스터 이", "마오카이", "말자하", "말파이트", "모데카이저", "모르가나", "문도 박사", "미스 포츈", "밀리오", "바드", "바루스", "바이", "베이가", "베인", "벡스", "벨베스", "벨코즈", "볼리베어", "브라움", "브라이어", "브랜드", "블라디미르", "블리츠크랭크", "비에고", "빅토르", "뽀삐", "사미라", "사이온", "사일러스", "샤코", "세나", "세라핀", "세주아니", "세트", "소나", "소라카", "쉔", "쉬바나", "스웨인", "스카너", "시비르", "신짜오", "신드라", "신지드", "쓰레쉬", "아리", "아무무", "아우렐리온 솔", "아이번", "아지르", "아칼리", "아크샨", "아트록스", "아펠리오스", "알리스타", "애니", "애니비아", "애쉬", "야스오", "에코", "엘리스", "오공", "오른", "오리아나", "올라프", "요네", "요릭", "우디르", "우르곳", "워윅", "유미", "이렐리아", "이블린", "이즈리얼", "일라오이", "자르반 4세", "자야", "자이라", "자크", "잔나", "잭스", "제드", "제라스", "제리", "제이스", "조이", "직스", "진", "질리언", "징크스", "초가스", "카르마", "카밀", "카사딘", "카서스", "카시오페이아", "카이사", "카직스", "카타리나", "칼리스타", "케넨", "케이틀린", "케인", "케일", "코그모", "코르키", "퀸", "크산테", "클레드", "키아나", "킨드레드", "타릭", "탈론", "탈리야", "탐켄치", "트런들", "트리스타나", "트린다미어", "트위스티드 페이트", "트위치", "티모", "파이크", "판테온", "피들스틱", "피오라", "피즈", "하이머딩거", "헤카림"]
    let a = ChampionManager.shared.champName[0]
    
    var delegate: SendSelectedChampDelegate?
    
    var presentChamp: [String]?
    var selectedChamp: [String] = []
    
    let container = UIView()
    
    let searchBar = UISearchController(searchResultsController: nil)
    
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
        collectionView.allowsMultipleSelection = true
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageCollectionView.reloadData()
    }
}

extension ChooseChampViewController {
    func configureUI() {
        setupButton()
        setupImage()
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = "선호 챔피언 변경"
        
        view.backgroundColor = .white
        container.backgroundColor = .rgrgColor5
        view.addSubview(container)
        
        container.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        [firstImage, secondImage, thirdImage].forEach { mostChampImgStackView.addArrangedSubview($0) }
        [mostChampImgStackView, imageCollectionView, selectButton].forEach { container.addSubview($0) }
        
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
        selectButton.addTarget(self, action: #selector(selectButtonPressed), for: .touchUpInside)
    }
    
    func setupImage() {
        firstImage.image = UIImage(named: presentChamp?[0] ?? "None")
        secondImage.image = UIImage(named: presentChamp?[1] ?? "None")
        thirdImage.image = UIImage(named: presentChamp?[2] ?? "None")
    }
    
    @objc func selectButtonPressed() {
        arrangeSelectedChamp()
        delegate?.sendSelectedChamp(champArray: selectedChamp)
        
        navigationController?.popViewController(animated: true)
    }
    
    func arrangeSelectedChamp() {
        while selectedChamp.count < 3 {
            selectedChamp.append("None")
        }
    }
}

extension ChooseChampViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        imageCollectionView.register(ChampCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ChampCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.iconImage.image = UIImage(named: champName[indexPath.row])
        if presentChamp?[0] != "None" {
            if indexPath.row == champName.firstIndex(of: presentChamp?[0] ?? "Aatrox") {
                cell.layer.borderColor = UIColor.rgrgColor3.cgColor
                cell.layer.borderWidth = 3
            }
        }
        if presentChamp?[1] != "None" {
            if indexPath.row == champName.firstIndex(of: presentChamp?[1] ?? "Aatrox") {
                cell.layer.borderColor = UIColor.rgrgColor3.cgColor
                cell.layer.borderWidth = 3
            }
        }
        if presentChamp?[2] != "None" {
            if indexPath.row == champName.firstIndex(of: presentChamp?[2] ?? "Aatrox") {
                cell.layer.borderColor = UIColor.rgrgColor3.cgColor
                cell.layer.borderWidth = 3
            }
        }
        let len = selectedChamp.count
        for i in 0 ..< len {
            if indexPath.row == champName.firstIndex(of: selectedChamp[i]) {
                cell.layer.borderColor = UIColor.rgrgColor2.cgColor
                cell.layer.borderWidth = 3
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interval: CGFloat = 20
        let width: CGFloat = (collectionView.frame.width - interval * 2 - 56 * 2) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            if !selectedChamp.contains(champName[indexPath.row]) {
                selectedChamp.append(champName[indexPath.row])
            }
            cell.layer.borderColor = UIColor.rgrgColor3.cgColor
            cell.layer.borderWidth = 3
            print(selectedChamp)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewCell {
            if selectedChamp.contains(champName[indexPath.row]) {
                selectedChamp.remove(at: selectedChamp.firstIndex(of: champName[indexPath.row]) ?? 0)
            }
            cell.layer.borderColor = UIColor.rgrgColor3.cgColor
            cell.layer.borderWidth = 0
        }
    }
}
