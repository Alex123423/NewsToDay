//
//  SceneDelegate.swift
//  NewsToDay
//
//  Created by Alexey Davidenko on 08.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        if isOnboardingCompleted() {
            let tabBarController = TabBarController()
            window.rootViewController = tabBarController.createTabBar()
        } else {
            window.rootViewController = createOnboarding()
        }

        window.makeKeyAndVisible()
    }

    private func isOnboardingCompleted() -> Bool {
        return UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
    }

    private func createOnboarding() -> UIViewController {
        let onboardingVC = OnboardingViewController()
        let tabBarController = TabBarController()
        onboardingVC.onCompletion = { [weak self, weak tabBarController] in
            UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
            self?.window?.rootViewController = tabBarController?.customTabBar
        }
        return UINavigationController(rootViewController: onboardingVC)
    }
}
