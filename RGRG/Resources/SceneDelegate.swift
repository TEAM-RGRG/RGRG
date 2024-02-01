//
//  SceneDelegate.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/12.
//

import FirebaseAuth
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        var rootViewController = UIViewController()

        if Auth.auth().currentUser != nil {
            rootViewController = TabBarVC()
            rootViewController.viewWillAppear(true)
        } else {
            rootViewController = LoginVC()
        }

        let rootNavigationController = UINavigationController(rootViewController: rootViewController)

        self.window?.rootViewController = rootNavigationController
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {
        sleep(1)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
