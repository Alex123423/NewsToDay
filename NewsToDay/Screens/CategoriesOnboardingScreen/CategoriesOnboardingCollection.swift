//
//  CategoriesOnboardingCollection.swift
//  NewsToDay
//
//  Created by Александра Савчук on 11.05.2023.
//

import UIKit

class CategoriesOnboardingCollection: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var categoriesOnboardingVC: CategoriesOnboardingVC?
    public let categories = [
        "Politics": "🗳️",
        "Business": "💼",
        "Top": "🔝",
        "Environment": "🌳",
        "Entertainment": "🎭",
        "Food": "🍔",
        "Health": "🏥",
        "Science": "🔬",
        "Sports": "⚽️",
        "Tourism": "🗺️",
        "Technology": "💻",
        "World": "🌎"
    ]
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Categories".localized
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Thousands of articles in each category".localized
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .gray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    private let reuseIdentifier = "CategoriesOnCell"
    private var collectionView: UICollectionView
    weak var parentViewController: CategoriesVC?
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)
        configureCollection()
        self.addSubview(collectionView)
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChangedNotification"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CategoriesOnCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = true

        addSubview(collectionView)
    }

    func setupConstraints() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoriesOnCell
        let category = Array(categories.keys)[indexPath.row]
        
        if let emoji = categories[category] {
            var text = ""
            if Locale.current.languageCode == "ru" {
                text = emoji + " " + category.localized
            } else {
                text = emoji + " " + category
            }
            cell.label.text = text
        }
        
        if CategoriesManager.shared.categories.contains(category.lowercased()) {
            cell.activate()
        } else {
            cell.deactivate()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Array(categories.keys)[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as? CategoriesOnCell
        
        if CategoriesManager.shared.categories.contains(category.lowercased()) {
            CategoriesManager.shared.delete(category: category)
            cell?.deactivate()
        } else if CategoriesManager.shared.categories.count < 5 {
            CategoriesManager.shared.add(category: category)
            cell?.activate()
        } else if CategoriesManager.shared.categories.count == 5 {
            cell?.error()
            categoriesOnboardingVC?.nextButton.backgroundColor = .red
            categoriesOnboardingVC?.nextButton.isEnabled = false
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoriesOnCell
        let category = Array(categories.keys)[indexPath.row]
        CategoriesManager.shared.delete(category: category)
        cell?.deactivate()
        categoriesOnboardingVC?.nextButton.backgroundColor = UIColor(named: "buttonBlue")
        categoriesOnboardingVC?.nextButton.isEnabled = true
    }
    
    @objc func updateLanguage() {
        titleLabel.text = "Categories".localized
        subtitleLabel.text = "Thousands of articles in each category".localized
        collectionView.reloadData()
    }
}
