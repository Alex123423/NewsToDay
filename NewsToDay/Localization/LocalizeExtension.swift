//
//  swiftExtension.swift
//  NewsToDay
//
//  Created by Александра Савчук on 09.05.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

class SettingsModel {
    static let shared = SettingsModel()
    
    private let defaults = UserDefaults.standard
    private let selectedLanguageKey = "selectedLanguage"
    
    var selectedLanguage: String? {
        get {
            return defaults.string(forKey: selectedLanguageKey)
        }
        set {
            defaults.set(newValue, forKey: selectedLanguageKey)
            defaults.synchronize()
        }
    }
    
    func changeLanguage(to language: String) {
        selectedLanguage = language
    }
}

