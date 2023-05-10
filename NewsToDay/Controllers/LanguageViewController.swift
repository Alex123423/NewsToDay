//
//  LanguageViewController.swift
//  NewsToDay
//
//  Created by Александра Савчук on 09.05.2023.
//

import UIKit

class LanguageViewController: UIViewController{
    
    
    // MARK: - Outlets
   
    private lazy var changeToENButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.darkGray, for: .normal)
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
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(changeLanguagePressedEN), for: .touchUpInside)
        return button
    }()
    
    lazy var changeToRUButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.darkGray, for: .normal)
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
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeLanguagePressedRU), for: .touchUpInside)
        return button
    }()
 
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Bold", size: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonPressed))
         navigationItem.leftBarButtonItem = backButton
    }
    
    //MARK: - Methods
  
    @objc func changeLanguagePressedEN(_ sender: UIButton) {
        Bundle.setLanguage(lang: "en")
        let vc = UserProfileController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeLanguagePressedRU(_ sender: UIButton) {
        Bundle.setLanguage(lang: "ru")
        let vc = UserProfileController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(changeToENButton)
        view.addSubview(changeToRUButton)
        
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            
            changeToENButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeToENButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            changeToENButton.widthAnchor.constraint(equalToConstant: 360),
            changeToENButton.heightAnchor.constraint(equalToConstant: 60),
            
            changeToRUButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeToRUButton.topAnchor.constraint(equalTo: changeToENButton.bottomAnchor, constant: 16),
            changeToRUButton.widthAnchor.constraint(equalToConstant: 360),
            changeToRUButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}


