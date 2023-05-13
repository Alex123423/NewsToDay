//
//  CategoriesManager.swift
//  NewsToDay
//
//  Created by Александра Савчук on 12.05.2023.
//

import Foundation

class CategoriesManager {
    
    let key = "selectCategories"
    private let userDefaults = UserDefaults.standard

    static let shared = CategoriesManager()

    public static var categories: [String] = []

    init() {
        if let categories = userDefaults.object(forKey: key) as? [String] {
            CategoriesManager.categories = categories
        } else {
            CategoriesManager.categories = []
        }
    }

    func add(category: String) {
        CategoriesManager.categories.append(category.lowercased())
        saveCategories()
    }

    func delete(category: String) {
        CategoriesManager.categories.removeAll { $0 == category.lowercased() }
        saveCategories()
    }

    private func saveCategories() {
        userDefaults.set(CategoriesManager.categories, forKey: key)
    }
    
    func getCategoriesString() -> String {
        return CategoriesManager.categories.joined(separator: ",")
        }
}
