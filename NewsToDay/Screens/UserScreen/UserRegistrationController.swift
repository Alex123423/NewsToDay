//
//  UserRegistrationController.swift
//  NewsToDay
//
//  Created by Edward Kheladze on 11.05.2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth

final class UserRegistrationController: UIViewController {
    
    @MainActor
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password found.")
            return
        }
        do {
            _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
        } catch {
            print(error)
        }
    }
    
    let userNameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let repeatPasswordTextField = UITextField()
    let signUpButton = UIButton(type: .system)
    let alreadyHaveAccountButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        let signUpButton = UIButton(type: .system)
        
        titleLabel.text = "Welcome to NewsToDay".localized
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        descriptionLabel.text = "Hello, I guess you are new around here. You can start using the application after sign up.".localized
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        
        userNameTextField.placeholder = "Username".localized
        userNameTextField.keyboardType = .emailAddress
        userNameTextField.autocapitalizationType = .none
        userNameTextField.autocorrectionType = .no
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.addImageLeft(img: UIImage(systemName: "person")?.withTintColor(.gray, renderingMode: .alwaysOriginal), padding: 10)
        
        emailTextField.placeholder = "Email Address".localized
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.borderStyle = .roundedRect
        emailTextField.addImageLeft(img: UIImage(systemName: "envelope")?.withTintColor(.gray, renderingMode: .alwaysOriginal), padding: 10)
        
        passwordTextField.placeholder = "Password".localized
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.addImageLeft(img: UIImage(systemName: "exclamationmark.lock")?.withTintColor(.gray, renderingMode: .alwaysOriginal), padding: 10)
        
        repeatPasswordTextField.placeholder = "Repeat Password".localized
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.borderStyle = .roundedRect
        repeatPasswordTextField.addImageLeft(img: UIImage(systemName: "exclamationmark.lock")?.withTintColor(.gray, renderingMode: .alwaysOriginal), padding: 10)
        
        signUpButton.setTitle("Sign Up".localized, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signUpButton.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0.3529411765, blue: 0.8431372549, alpha: 1)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 25
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        
        alreadyHaveAccountButton.setTitle("Already have a account? Sign In".localized, for: .normal)
        alreadyHaveAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        alreadyHaveAccountButton.backgroundColor = nil
        alreadyHaveAccountButton.setTitleColor(.gray, for: .normal)
        alreadyHaveAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        alreadyHaveAccountButton.titleLabel?.minimumScaleFactor = 0.5
        alreadyHaveAccountButton.addTarget(self, action: #selector(alreadyHaveAccountButtonPressed), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(userNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(signUpButton)
        view.addSubview(alreadyHaveAccountButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            userNameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 100),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            
            alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alreadyHaveAccountButton.heightAnchor.constraint(equalToConstant: 60),
            alreadyHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            alreadyHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func alreadyHaveAccountButtonPressed() {
        let userSignController = UserSignInController()
        present(userSignController, animated: true, completion: nil)
        
    }
    
    @objc func signUpButtonPressed() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error != nil {
            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: [
                    "username" : self.userNameTextField.text!,
                    "email" : self.emailTextField.text!,
                    "uid" : result!.user.uid
                ]) { error in
                    if error != nil {
                        // Обработка ошибки записи в Firestore
                        print("Ошибка записи в Firestore: (error.localizedDescription)")
                    } else {
                        // Успешная запись в Firestore
                    }
                }
                let userSignController = OnboardingViewController()
                self.present(userSignController, animated: true, completion: nil)
            }
        }
    }
}
