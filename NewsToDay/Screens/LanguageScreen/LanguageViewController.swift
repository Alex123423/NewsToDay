//
//  LanguageViewController.swift
//  NewsToDay
//
//  Created by Alexey Davidenko on 20.05.2023.
//

import UIKit

class LanguageViewController: UIViewController{
    
    // MARK: - Outlets
    private lazy var changeToENButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitle("English", for: .normal)
        button.configuration = .plain()
        button.configuration?.titlePadding = CGFloat(10)
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let transformer = UIConfigurationTextAttributesTransformer { (attributes) in
            var updated = attributes
            updated.font = font
            return updated
        }
        button.configuration?.titleTextAttributesTransformer = transformer
        button.contentHorizontalAlignment = .left
        
        // Check if current language is English and set the background color accordingly
        if Bundle.currentLanguage == "en" {
            button.backgroundColor = UIColor.blue
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
            button.setTitleColor(.darkGray, for: .normal)
        }
        
        // Add checkmark image as right view
        if Bundle.currentLanguage == "en" {
            let checkmarkImage = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            let imageView = UIImageView(image: checkmarkImage)
            button.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16).isActive = true
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeLanguagePressedEN), for: .touchUpInside)
        return button
    }()
    
    private lazy var changeToRUButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitle("Russian", for: .normal)
        button.configuration = .plain()
        button.configuration?.titlePadding = CGFloat(10)
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let transformer = UIConfigurationTextAttributesTransformer { (attributes) in
            var updated = attributes
            updated.font = font
            return updated
        }
        button.configuration?.titleTextAttributesTransformer = transformer
        button.contentHorizontalAlignment = .left
  
        if Bundle.currentLanguage == "ru" {
            button.backgroundColor = UIColor.blue
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
            button.setTitleColor(.darkGray, for: .normal)
        }
        
        if Bundle.currentLanguage == "ru" {
            let checkmarkImage = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            let imageView = UIImageView(image: checkmarkImage)
            button.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16).isActive = true
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeLanguagePressedRU), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .gray
        navigationItem.leftBarButtonItem = backButton
        title = "Language".localized
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChangedNotification"), object: nil)
    }

        //MARK: - Methods
    @objc func changeLanguagePressedEN(_ sender: UIButton) {
        Bundle.setLanguage(lang: "en")
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func changeLanguagePressedRU(_ sender: UIButton) {
        Bundle.setLanguage(lang: "ru")
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func updateLanguage() {
        changeToENButton.setTitle("English".localized, for: .normal)
        changeToRUButton.setTitle("Russian".localized, for: .normal)
    }
    
    func setupViews() {
        view.addSubview(changeToENButton)
        view.addSubview(changeToRUButton)
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            changeToENButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeToENButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            changeToENButton.widthAnchor.constraint(equalToConstant: 360),
            changeToENButton.heightAnchor.constraint(equalToConstant: 60),
            
            changeToRUButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeToRUButton.topAnchor.constraint(equalTo: changeToENButton.bottomAnchor, constant: 16),
            changeToRUButton.widthAnchor.constraint(equalToConstant: 360),
            changeToRUButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
