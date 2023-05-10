//
//  swiftExtension.swift
//  NewsToDay
//
//  Created by Александра Савчук on 09.05.2023.
//

import Foundation
import UIKit

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

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
   }

  convenience init(hex: Int, alpha: CGFloat = 1) {
      let r = CGFloat((hex & 0xff0000) >> 16) / 255
      let g = CGFloat((hex & 0x00ff00) >> 8) / 255
      let b = CGFloat(hex & 0x0000ff) / 255
      self.init(red: r, green: g, blue: b, alpha: alpha)
  }
}
