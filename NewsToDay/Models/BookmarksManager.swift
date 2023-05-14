//
//  FavouriteManager.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-11.
//

import Foundation

struct BookmarksManager {
    
    static var bookmarksArray: [Result] = []
    
    let defaults = UserDefaults.standard
    
    func saveNews(_ dataToSave: [Result]) {
        do {
            let savedNews = try JSONEncoder().encode(dataToSave)
            defaults.set(savedNews, forKey: "bookmarks")
            defaults.synchronize()
        } catch {
            print("Error encoding results: \(error)")
        }
    }
    
    func loadNews() -> [Result] {
        guard let data = defaults.data(forKey: "bookmarks") else {
            return []
        }
        do {
            let savedNews = try JSONDecoder().decode([Result].self, from: data)
            return savedNews
        } catch {
            print("Error decoding team results: \(error)")
            return []
        }
    }
}

//final class BookmarksManager {
//
//    static let shared = BookmarksManager()
//
//    private let defaults = UserDefaults.standard
//    private let bookmarksKey = "bookmarks"
//
//    private var bookmarksArray: [Result] {
//        get {
//            guard let data = defaults.data(forKey: bookmarksKey) else {
//                return []
//            }
//            do {
//                let savedBookmarks = try JSONDecoder().decode([Result].self, from: data)
//                return savedBookmarks
//            } catch {
//                print("Error decoding bookmarks: \(error)")
//                return []
//            }
//        }
//        set {
//            do {
//                let savedBookmarks = try JSONEncoder().encode(newValue)
//                defaults.set(savedBookmarks, forKey: bookmarksKey)
//            } catch {
//                print("Error encoding bookmarks: \(error)")
//            }
//        }
//    }
//
//    private init() {}
//
//    func getBookmarks() -> [Result] {
//        return bookmarksArray
//    }
//
//    func addBookmark(_ bookmark: Result) {
//        var currentBookmarks = bookmarksArray
//        currentBookmarks.append(bookmark)
//        bookmarksArray = currentBookmarks
//    }
//
//    func removeBookmark(_ bookmark: Result) {
//        var currentBookmarks = bookmarksArray
//        if let index = currentBookmarks.firstIndex(where: { $0.id == bookmark.id }) {
//            currentBookmarks.remove(at: index)
//            bookmarksArray = currentBookmarks
//        }
//    }
//
//    func clearBookmarks() {
//        bookmarksArray = []
//    }
//
//    func saveBookmarks() -> Result<Void, Error> {
//        do {
//            let savedBookmarks = try JSONEncoder().encode(bookmarksArray)
//            defaults.set(savedBookmarks, forKey: bookmarksKey)
//            return .success(())
//        } catch {
//            return .failure(error)
//        }
//    }
//}
    
