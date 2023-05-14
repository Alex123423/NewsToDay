//
//  FavouriteManager.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-11.
//

import Foundation

final class BookmarksManager {
    
    static let shared = BookmarksManager()
    
    private let defaults = UserDefaults.standard
    private let bookmarksKey = "bookmarks"
    
    var bookmarksArray: [Result] {
        get {
            guard let data = defaults.data(forKey: bookmarksKey) else {
                return []
            }
            do {
                let savedBookmarks = try JSONDecoder().decode([Result].self, from: data)
                return savedBookmarks
            } catch {
                print("Error decoding bookmarks: \(error)")
                return []
            }
        }
        set {
            do {
                let savedBookmarks = try JSONEncoder().encode(newValue)
                defaults.set(savedBookmarks, forKey: bookmarksKey)
            } catch {
                print("Error encoding bookmarks: \(error)")
            }
        }
    }
    
    private init() {}
    
    func getBookmarks() -> [Result] {
        return bookmarksArray
    }
    
    func saveBookmarks(_ dataToSave: [Result]) {
        do {
            let savedNews = try JSONEncoder().encode(dataToSave)
            defaults.set(savedNews, forKey: "bookmarks")
            defaults.synchronize()
        } catch {
            print("Error encoding results: \(error)")
        }
    }
}

