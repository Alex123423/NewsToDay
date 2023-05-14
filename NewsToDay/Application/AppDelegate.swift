//
//  AppDelegate.swift
//  NewsToDay
//
//  Created by Alexey Davidenko on 08.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let bookmarksManager = BookmarksManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BookmarksManager.bookmarksArray = bookmarksManager.loadNews()
        print(BookmarksManager.bookmarksArray.count)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        bookmarksManager.saveNews(BookmarksManager.bookmarksArray)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        bookmarksManager.saveNews(BookmarksManager.bookmarksArray)
    }
    
}

