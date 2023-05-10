//
//  TabBar.swift
//  NewsToDay
//
//  Created by Александра Савчук on 10.05.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
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
        let navigationVC = UINavigationController(rootViewController: UserProfileController())
        navigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 3)
        return navigationVC
    }
    
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [homeController(), categoriesControler(), bookmarmController(), profileControler()]
        tabBar.tabBar.layer.cornerRadius = 12
        tabBar.tabBar.layer.borderWidth = 0.5
        tabBar.tabBar.layer.masksToBounds = true
        return tabBar
    }
    
    var customTabBar: UITabBarController {
        return createTabBar()
    }
}
