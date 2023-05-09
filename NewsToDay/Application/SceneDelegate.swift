//
//  SceneDelegate.swift
//  NewsToDay
//
//  Created by Alexey Davidenko on 08.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func homeController() -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: HomeViewController())
        navigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        return navigationVC
    }
    
    func categoriesControler() -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: OnboardingViewController())
        navigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "square.grid.2x2"), tag: 1)
        return navigationVC
    }
    
    func bookmarmController() -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: BookmarksViewController())
        navigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "bookmark"), tag: 2)
        return navigationVC
    }
    
    func profileControler() -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: OnboardingViewController())
        navigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 3)
        return navigationVC
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [homeController(), categoriesControler(), bookmarmController(), profileControler()]
        return tabBar
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
                window.rootViewController = createTabBar()
////        window.rootViewController = HomeViewController()
//        window.rootViewController = BookmarksViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
    
}

