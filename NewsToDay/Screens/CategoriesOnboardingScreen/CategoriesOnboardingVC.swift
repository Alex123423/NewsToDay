//
//  CategoriesOnboardingVC.swift
//  NewsToDay
//
//  Created by Александра Савчук on 11.05.2023.
//

import UIKit

class CategoriesOnboardingVC: UIViewController {
    
    private let categoriesOnboardingView = CategoriesOnboardingCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        categoriesOnboardingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoriesOnboardingView)
        
        NSLayoutConstraint.activate([
            categoriesOnboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesOnboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesOnboardingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesOnboardingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


