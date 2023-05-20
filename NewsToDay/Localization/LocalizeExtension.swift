//
//  swiftExtension.swift
//  NewsToDay
//
//  Created by Александра Савчук on 09.05.2023.
//

import Foundation

extension Bundle {
    
    private static var bundle: Bundle!
    
    static var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "app_lang") ?? "ru"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "app_lang")
        }
    }
    
    static var localizedBundle: Bundle {
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            return Bundle(path: path)!
        } else {
            return Bundle.main
        }
    }
    
    
    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChangedNotification"), object: nil)
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle, value: "", comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
}

