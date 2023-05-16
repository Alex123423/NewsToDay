//
//  AppDelegate.swift
//  NewsToDay
//
//  Created by Alexey Davidenko on 08.05.2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let bookmarksManager = BookmarksManager.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        bookmarksManager.saveBookmarks(bookmarksManager.bookmarksArray)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        bookmarksManager.saveBookmarks(bookmarksManager.bookmarksArray)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        bookmarksManager.bookmarksArray = bookmarksManager.getBookmarks()
    }
}

