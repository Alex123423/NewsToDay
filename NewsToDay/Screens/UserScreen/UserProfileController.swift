//
//  UserProfileController.swift
//  NewsToDay
//
//  Created by Edward Kheladze on 09.05.2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth

class UserProfileController: UIViewController{
    
    // MARK: - Outlets
    
    lazy var termsConditionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Terms & Conditions".localized, for: .normal)
        button.configuration = createButtonConfiguration(title: "Terms & Conditions".localized)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTermsPressed), for: .touchUpInside)
        button.addImageToButton(img: "chevron.right")
        return button
    }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Sign Out".localized, for: .normal)
        button.configuration = createButtonConfiguration(title: "Sign Out".localized)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        button.addImageToButton(img: "rectangle.portrait.and.arrow.forward")
        return button
    }()
    
    lazy var languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Language".localized, for: .normal)
        button.configuration = createButtonConfiguration(title: "Language".localized)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeLanguagePressed), for: .touchUpInside)
        button.addImageToButton(img: "chevron.right")
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile".localized
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
        setupViews()
        setConstraints()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChangedNotification"), object: nil)
    }
    
    //MARK: - Methods
    
    private func createButtonConfiguration(title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.titlePadding = 10
        configuration.baseForegroundColor = .darkGray
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var updated = attributes
            updated.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            return updated
        }
        return configuration
    }
    
    @objc func updateLanguage() {
        termsConditionsButton.setTitle("Terms & Conditions".localized, for: .normal)
        signOutButton.setTitle("Sign Out".localized, for: .normal)
        languageButton.setTitle("Language".localized, for: .normal)
        titleLabel.text = "Profile".localized
    }
    
    @objc func buttonTermsPressed(_ sender: UIButton) {
        let vc = TermsConditions()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signOutButtonPressed(_ sender: UIButton) {
        let vc = UserSignInController()
        vc.hidesBottomBarWhenPushed = true
        vc.navigationItem.hidesBackButton = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func changeLanguagePressed(_ sender: UIButton) {
        let vc = LanguageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
            languageButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 44),
            languageButton.widthAnchor.constraint(equalToConstant: 360),
            languageButton.heightAnchor.constraint(equalToConstant: 60),
            
            termsConditionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsConditionsButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -30),
            termsConditionsButton.widthAnchor.constraint(equalToConstant: 360),
            termsConditionsButton.heightAnchor.constraint(equalToConstant: 60),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signOutButton.widthAnchor.constraint(equalToConstant: 360),
            signOutButton.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            photoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -90),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension UIButton {
    func addImageToButton(img: String) {
        let checkmarkImage = UIImage(systemName: img)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: checkmarkImage)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
