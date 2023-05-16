//
//  UserRegistrationController.swift
//  NewsToDay
//
//  Created by Edward Kheladze on 11.05.2023.
//

import UIKit
import Firebase

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
            let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
            // Handle successful sign-in
        } catch {
            // Handle error
            print(error)
        }
    }
    
    
    let userNameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let repeatPasswordTextField = UITextField()
    let signInButton = UIButton(type: .system)
    let signUpButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        let signUpButton = UIButton(type: .system)
        
        titleLabel.text = "Welcome to NewsToDay"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .black
        
        descriptionLabel.text = "Hello, I guess you are new around here. You can start using the application after sign up."
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        
        
        userNameTextField.placeholder = "Username"
        userNameTextField.keyboardType = .emailAddress
        userNameTextField.autocapitalizationType = .none
        userNameTextField.autocorrectionType = .no
        userNameTextField.borderStyle = .roundedRect
        
        
        emailTextField.placeholder = "Email Adress"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.borderStyle = .roundedRect
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        
        repeatPasswordTextField.placeholder = "Repeat Password"
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.borderStyle = .roundedRect
        
        
        signInButton.setTitle("Sign Up", for: .normal)
        signInButton.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0.3529411765, blue: 0.8431372549, alpha: 1)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        signUpButton.setTitle("Already have a account? Sign In", for: .normal)
        signUpButton.backgroundColor = nil
        signUpButton.setTitleColor(.gray, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(userNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            
            
            userNameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 100),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func signUpButtonPressed() {
        let userSignController = UserSignInController()
        present(userSignController, animated: true, completion: nil)
        
    }
    
    @objc func signInButtonPressed() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                // Обработка ошибки
                print(error.localizedDescription)
            } else {
                // Обработка успешной аутентификации
                print("User signed in successfully")
            }
            
            
        }
        
        
    }
}
