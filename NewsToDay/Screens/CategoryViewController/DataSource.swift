//
//  DataSource.swift
//  NewsToDay
//
//  Created by Леонид Турко on 12.05.2023.
//

import UIKit

enum Category: String, CaseIterable {
  case smileysAndPeople = "🏈 Sports"
  case animalsAndNature = "⚖️ Politics"
  case foodAndDrink = "🌞 Life"
  case activity = "🎮 Gaming"
  case travelAndPlaces = "🐿 Animals"
  case objects = "🌴 Nature"
  case symbols = "🍟 Food"
  case flags = "🎨 Art"
  case history = "🏫 History"
  case fashion = "🧥 Fashion"
}

class DataSource: NSObject, UICollectionViewDataSource {
  let allCategories = Category.allCases
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    allCategories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else { fatalError() }
    let category = allCategories[indexPath.item]
    categoryCell.textLabel.text = category.rawValue
    categoryCell.backgroundColor = #colorLiteral(red: 0.9624661803, green: 0.9658432603, blue: 0.9719805121, alpha: 1)
    categoryCell.layer.cornerRadius = 12
    return categoryCell
  }
}
