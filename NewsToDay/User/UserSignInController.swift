//
//  UserSignInController.swift
//  NewsToDay
//
//  Created by Edward Kheladze on 11.05.2023.
//

import UIKit
import Firebase

final class UserSignInController: UIViewController {
    
    
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
        
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        let emailTextField = UITextField()
        let passwordTextField = UITextField()
        let signInButton = UIButton(type: .system)
        let signUpButton = UIButton(type: .system)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupViews()
        }
        
        func setupViews() {
            
            titleLabel.text = "Welcome Back 👋"
            titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            titleLabel.textColor = .black
            
            descriptionLabel.text = "I am happy to see you again. You can continue where you left off by logging in"
            descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            descriptionLabel.textColor = .gray
            descriptionLabel.numberOfLines = 0
            
            emailTextField.placeholder = "Email Address"
            emailTextField.keyboardType = .emailAddress
            emailTextField.autocapitalizationType = .none
            emailTextField.autocorrectionType = .no
            emailTextField.borderStyle = .roundedRect
            
            passwordTextField.placeholder = "Password"
            passwordTextField.isSecureTextEntry = true
            passwordTextField.borderStyle = .roundedRect
            
            signInButton.setTitle("Sign In", for: .normal)
            signInButton.backgroundColor = .blue
            signInButton.setTitleColor(.white, for: .normal)
            signInButton.layer.cornerRadius = 10
            signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
            
            signUpButton.setTitle("Don't have an account? Sign Up", for: .normal)
            signUpButton.backgroundColor = nil
            signUpButton.setTitleColor(.gray, for: .normal)
            signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
            
            
            view.addSubview(titleLabel)
            view.addSubview(descriptionLabel)
            view.addSubview(emailTextField)
            view.addSubview(passwordTextField)
            view.addSubview(signInButton)
            view.addSubview(signUpButton)
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            signInButton.translatesAutoresizingMaskIntoConstraints = false
            signUpButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                emailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                emailTextField.heightAnchor.constraint(equalToConstant: 40),
                
                passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
                passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                passwordTextField.heightAnchor.constraint(equalToConstant: 40),
                
                signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
                signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                signInButton.heightAnchor.constraint(equalToConstant: 50),
                signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                signUpButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
        
        @objc func signUpButtonPressed() {
            let userRegistrationController = UserRegistrationController()
            present(userRegistrationController, animated: true, completion: nil)
            
        }
        @objc func signInButtonPressed() {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("User signed in successfully")
                }
            }
        }

        
    }
