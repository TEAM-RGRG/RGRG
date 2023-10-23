import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        setupTabbarController()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.tintColor = .label
//        self.navigationController?.navigationBar.isHidden = true;
        let paddingTop: CGFloat = 10.0
        tabBar.frame = .init(
            x: tabBar.frame.origin.x,
            y: tabBar.frame.origin.y - paddingTop,
            width: tabBar.frame.width,
            height: tabBar.frame.height + paddingTop
        )
    }
}

extension TabBarController {
    func setupTabbarController() {
        view.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6

        let mainVC = MainViewController()
        mainVC.tabBarItem = configure(title: "메인", symbolName: "house", tag: 0)

        let chatVC = ChatListViewController()
        chatVC.tabBarItem = configure(title: "채팅", symbolName: "message", tag: 2)

        let profileVC = ProfileViewController()
        profileVC.tabBarItem = configure(title: "마이룸", symbolName: "person", tag: 3)

        viewControllers = [mainVC, chatVC, profileVC]
    }

    func configure(title: String, symbolName: String, tag: Int) -> UITabBarItem {
        return UITabBarItem(title: title, image: UIImage(systemName: symbolName), tag: tag)
    }
}
