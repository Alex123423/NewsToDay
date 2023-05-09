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
