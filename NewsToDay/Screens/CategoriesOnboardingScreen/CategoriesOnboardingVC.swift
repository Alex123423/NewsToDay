//
//  CategoriesOnboardingVC.swift
//  NewsToDay
//
//  Created by Александра Савчук on 15.05.2023.
//

import UIKit

class CategoriesOnboardingVC: UIViewController {
    
    private let categoriesOnboardingView = CategoriesOnboardingCollection()
    
    public lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.setTitle("next".localized, for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = UIColor(named: "buttonBlue")
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        return nextButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesOnboardingView.titleLabel.text = "Select your favorite topics".localized
        categoriesOnboardingView.subtitleLabel.text = "Select some of your favorite topics to let us suggest better news for you.".localized
        view.backgroundColor = .white
        categoriesOnboardingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoriesOnboardingView)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            categoriesOnboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesOnboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesOnboardingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesOnboardingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChangedNotification"), object: nil)
        categoriesOnboardingView.categoriesOnboardingVC = self

    }
    
    @objc func updateLanguage() {
        categoriesOnboardingView.updateLanguage()
    }
    
    @objc private func nextButtonTapped() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate = scene?.delegate as? SceneDelegate {
            let tabBarController = TabBarController()
            sceneDelegate.window?.rootViewController = tabBarController.createTabBar()
            
        }
    }
}
