//
//  Conditions.swift
//  NewsToDay
//
//  Created by Edward Kheladze on 08.05.2023.
//

import UIKit

final class ConditionsController: UIViewController {
    
    let titleLabel: UILabel = { // Создаем Label
    let label = UILabel()
        label.textColor = .black // Цвет Label
        label.font = UIFont(name: "Avenir Next Bold", size: 40) // Задаем шрифты + размер текста
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    //MARK: - Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        let rules = Rules()
        label.text = rules.rules
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.4862745098, green: 0.5098039216, blue: 0.631372549, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.backBarButtonItem?.isEnabled = true
        setupViews()
        setConstraints()
        title = "Terms & Conditions"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Avenir Next Bold", size: 27)!
        ]
    }
    
    //MARK: - Methods
    
    @objc func buttonPressed(_ sender:UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9813271165, green: 0.9813271165, blue: 0.9813271165, alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(subtitleLabel)
    }
}

//MARK: Constraints

extension ConditionsController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10 ), // Отступ от верхних границ
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor) , // Центруем Label
            
           
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
