//
//  CategoriesOnboardingCollection.swift
//  NewsToDay
//
//  Created by Александра Савчук on 11.05.2023.
//

import UIKit

class CategoriesOnboardingCollection: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    public let categories = [
        "Random": "🎲",
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
    
    private let reuseIdentifier = "CategoriesOnCell"
    private var collectionView: UICollectionView
    private var selectedCategories = Set<String>()
    private let maxSelections = 5
    weak var parentViewController: CategoriesOnboardingVC?
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)
        configureCollection()
        self.addSubview(collectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
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
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        let titleLabel = UILabel()
        titleLabel.text = "Categories"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Thousands of articles in each category"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .gray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
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
            let text = emoji + " " + category
            cell.label.text = text
        } else {
            cell.label.text = category
        }
        cell.isSelected = selectedCategories.contains(category)
        if selectedCategories.contains(category) {
            cell.backgroundColor = .blue
            cell.label.textColor = .white
        } else {
            cell.backgroundColor = .white
            cell.label.textColor = .black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Array(categories.keys)[indexPath.row]
        if selectedCategories.contains(category) {
            // Если категория уже выбрана, снимаем выделение и удаляем из выбранных
            selectedCategories.remove(category)
            collectionView.deselectItem(at: indexPath, animated: true)
        } else if selectedCategories.count < maxSelections {
            // Если категория еще не выбрана и можно выбрать еще категории,
            // добавляем в выбранные и устанавливаем выделение
            selectedCategories.insert(category)
            clipsToBounds = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        } else {
            // Иначе выводим сообщение об ошибке
            let alert = UIAlertController(title: "Error", message: "You can select up to \(maxSelections) categories", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            parentViewController?.present(alert, animated: true, completion: nil)
        }
        
        // Обновляем все ячейки
        collectionView.visibleCells.forEach { cell in
            guard let indexPath = collectionView.indexPath(for: cell) else { return }
            let category = Array(categories.keys)[indexPath.row]
            cell.isSelected = selectedCategories.contains(category)
            if selectedCategories.contains(category) {
                cell.backgroundColor = .blue
                
            } else {
                cell.backgroundColor = .white
                
            }
        }
        print(selectedCategories)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let category = Array(categories.keys)[indexPath.row]
        
        // Удаляем выбранную категорию из массива
        selectedCategories.remove(category)
        
        // Обновляем ячейку
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesOnCell {
            cell.isSelected = false
        }
    }
}

