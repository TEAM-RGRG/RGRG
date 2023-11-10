//
//  DeveloperInfoViewController.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 11/7/23.
//

import SafariServices
import SnapKit
import UIKit

class DeveloperInfoViewController: UIViewController {
    var pageTitle: String?

    let developerList = Developer.developList

    let tableView = CustomTableView(frame: .zero, style: .plain)
}

// MARK: - View LifeCycle

extension DeveloperInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
}

// MARK: - Setting Up UI

extension DeveloperInfoViewController {
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        navigationController?.navigationItem.title = pageTitle
        confirmTableView()
        registerCell()
    }

    func confirmTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(hex: "#F4F4F4")

        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func registerCell() {
        tableView.register(DeveloperCell.self, forCellReuseIdentifier: DeveloperCell.identifier)
    }
}

// MARK: - TableView DataSource

extension DeveloperInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return developerList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = developerList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeveloperCell.identifier, for: indexPath) as? DeveloperCell else { return UITableViewCell() }
        cell.setupUI()
        cell.confirmCell(data: item)
        cell.accessoryType = .detailDisclosureButton
        cell.backgroundColor = .white
        return cell
    }
}

// MARK: - TableView Delegate

extension DeveloperInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = developerList[indexPath.row]

        guard let url = URL(string: item.github) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

struct Developer {
    var name: String
    var email: String
    var github: String
}

extension Developer {
    static let developList: [Developer] = [
        Developer(name: "김준우", email: "kimjunwoo629@gmail.com", github: "https://github.com/jakkujakku"),
        Developer(name: "이수현", email: "hyeonnee98@gmail.com", github: "https://github.com/suzzang98"),
        Developer(name: "김귀아", email: "kiakim.dev@gmail.com", github: "https://github.com/kiakim01"),
        Developer(name: "이시영", email: "jltldud@gmail.com", github: "https://github.com/startingg"),
    ]
}
