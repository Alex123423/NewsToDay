//
//  AppDelegate.swift
//  NewsToDay
//
//  Created by Alexey Davidenko on 08.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let bookmarksManager = BookmarksManager.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinish")
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        bookmarksManager.saveBookmarks(bookmarksManager.bookmarksArray)
        print("SAVED \(bookmarksManager.bookmarksArray.count)")
        fflush(stdout)

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        bookmarksManager.saveBookmarks(bookmarksManager.bookmarksArray)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Retrieve bookmarks from user defaults and set the value to the bookmarks array in BookmarksManager
        bookmarksManager.bookmarksArray = bookmarksManager.getBookmarks()
        print("ACTIVE \(bookmarksManager.bookmarksArray.count)")
        fflush(stdout)

    }
}

