//
//  UserProfileController.swift
//  NewsToDay
//
//  Created by Edward Kheladze on 09.05.2023.
//

import UIKit

class UserProfileController: OnboardingViewController{
    
    
    // MARK: - Outlets
    
    lazy var termsConditionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitle("   Terms & Conditions", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitle("   Sign Out", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitle("   Language", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Bold", size: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.image = UIImage(named: "UserProfile")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Edward K."
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "dev@gmail.com"
        return label
    }()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.isEnabled = true
        let tabBar = createTabBar()
        addChild(tabBar)
        view.addSubview(tabBar.view)
        tabBar.didMove(toParent: self)
        setupViews()
        setConstraints()
        view.backgroundColor = .white
    }
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        
        let homeVC = UIViewController()
        homeVC.tabBarItem.image = UIImage(named: "house")
        
        let categoriesVC = UIViewController()
        categoriesVC.tabBarItem.image = UIImage(named: "categories")
        
        let bookmarksVC = UIViewController()
        bookmarksVC.tabBarItem.image = UIImage(named: "favourite")
        
        let profileVC = UIViewController()
        profileVC.tabBarItem.image = UIImage(named: "profile")
        
        tabBar.viewControllers = [homeVC, categoriesVC, bookmarksVC, profileVC]
        
        return tabBar
    }
    
    //MARK: - Methods
    
    @objc func buttonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        view.addSubview(languageButton)
        view.addSubview(signOutButton)
        view.addSubview(termsConditionsButton)
        view.addSubview(titleLabel)
        view.addSubview(photoImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            
            languageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -460),
            languageButton.widthAnchor.constraint(equalToConstant: 360),
            languageButton.heightAnchor.constraint(equalToConstant: 60),
            
            termsConditionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsConditionsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -180),
            termsConditionsButton.widthAnchor.constraint(equalToConstant: 360),
            termsConditionsButton.heightAnchor.constraint(equalToConstant: 60),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            signOutButton.widthAnchor.constraint(equalToConstant: 360),
            signOutButton.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -90),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
            
        ])
    }
}


