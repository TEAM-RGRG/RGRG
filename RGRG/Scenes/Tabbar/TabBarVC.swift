import UIKit

final class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        setupTabbarController()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.tintColor = UIColor(hex: "#767676")

        let paddingTop: CGFloat = 10.0
        tabBar.frame = .init(
            x: tabBar.frame.origin.x,
            y: tabBar.frame.origin.y - paddingTop,
            width: tabBar.frame.width,
            height: tabBar.frame.height + paddingTop
        )
    }
}

extension TabBarVC {
    func setupTabbarController() {
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        tabBar.unselectedItemTintColor = UIColor(hex: "#767676")
        tabBar.tintColor = UIColor(hex: "#0C365A")
        tabBar.backgroundColor = UIColor(hex: "#FFFFFF")

        let mainVC = PartyVC()
        mainVC.viewWillAppear(true)
        mainVC.tabBarItem = configure(title: "List", symbolName: "tabMenu", tag: 0)

        let chatVC = ChatListVC()
        chatVC.viewWillAppear(true)
        chatVC.tabBarItem = configure(title: "Message", symbolName: "tabMessage_fill", tag: 1)

        let profileVC = ProfileVC()
        profileVC.viewWillAppear(true)
        profileVC.tabBarItem = configure(title: "Profile", symbolName: "tabUser_box", tag: 2)

        mainVC.tabBarItem.selectedImage = UIImage(named: "selectedTabMenu")
        chatVC.tabBarItem.selectedImage = UIImage(named: "selectedTabMessage_fill")
        profileVC.tabBarItem.selectedImage = UIImage(named: "selectedTabUser_box_fill")

        viewControllers = [mainVC, chatVC, profileVC]
    }

    func configure(title: String, symbolName: String, tag: Int) -> UITabBarItem {
        return UITabBarItem(title: title, image: UIImage(named: symbolName), tag: tag)
    }
}
