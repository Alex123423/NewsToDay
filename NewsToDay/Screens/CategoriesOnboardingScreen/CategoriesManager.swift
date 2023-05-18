//
//  CategoriesManager.swift
//  NewsToDay
//
//  Created by Александра Савчук on 12.05.2023.
//

import Foundation
import UIKit

class CategoriesManager {
    
    let key = "selectCategories"
    private let userDefaults = UserDefaults.standard
    
    static let shared = CategoriesManager()
    
    var categories: [String] = []
    
    init() {
        if let categories = userDefaults.object(forKey: key) as? [String] {
            self.categories = categories
        } else {
            self.categories = []
        }
    }
    
    func add(category: String) {
        let lowercaseCategory = category.lowercased()
        if !categories.contains(lowercaseCategory) {
            categories.append(lowercaseCategory)
            saveCategories()
        }
    }
    
    func delete(category: String) {
        if let index = categories.firstIndex(of: category.lowercased()) {
            categories.remove(at: index)
            saveCategories()
        }
    }
    
    private func saveCategories() {
        userDefaults.set(categories, forKey: key)
    }
    
    func getCategoriesString() -> String {
        return categories.joined(separator: ",")
    }
}
