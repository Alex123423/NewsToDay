//
//  UserSignInController.swift
//  NewsToDay
//
//  Created by Edward Kheladze on 11.05.2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth

final class UserSignInController: UIViewController {
    
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton(type: .system)
    let dontHaveAccountButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        titleLabel.text = "Welcome Back 👋".localized
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .black
        
        descriptionLabel.text = "I am happy to see you again. You can continue where you left off by logging in".localized
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        
        emailTextField.placeholder = "Email Address".localized
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.borderStyle = .roundedRect
        
        
        passwordTextField.placeholder = "Password".localized
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        
        
        signInButton.setTitle("Sign In".localized, for: .normal)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signInButton.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0.3529411765, blue: 0.8431372549, alpha: 1)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        dontHaveAccountButton.setTitle("Don't have an account? Sign Up".localized, for: .normal)
        dontHaveAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        dontHaveAccountButton.backgroundColor = nil
        dontHaveAccountButton.setTitleColor(.gray, for: .normal)
        dontHaveAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        dontHaveAccountButton.titleLabel?.minimumScaleFactor = 0.5
        dontHaveAccountButton.addTarget(self, action: #selector(dontHaveAccountButtonPressed), for: .touchUpInside)
        
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(dontHaveAccountButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        dontHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 60),
            dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            dontHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAccountButton.heightAnchor.constraint(equalToConstant: 50),
            dontHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dontHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func dontHaveAccountButtonPressed() {
        let userRegistrationController = UserRegistrationController()
        present(userRegistrationController, animated: true, completion: nil)
        
    }
    
    @objc func signInButtonPressed() {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            // Ваш код обработки успешной аутентификации или ошибки
            if let error = error {
                // Обработка ошибки входа
                print("Ошибка входа: \(error.localizedDescription)")
            } else {
                // Успешный вход
                let categoriesOnboardingVC = CategoriesOnboardingVC()
                let navigationController = UINavigationController(rootViewController: categoriesOnboardingVC)
                categoriesOnboardingVC.navigationController?.isNavigationBarHidden = true
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let appDelegate = windowScene.delegate as? SceneDelegate {
                    appDelegate.window?.rootViewController = navigationController
                }
            }
        }
        
        
    }
}
