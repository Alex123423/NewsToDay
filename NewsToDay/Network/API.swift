//
//  API.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-02.
//

import Foundation

enum API {
    
    var apiKey: String {
       return "6258f9f2474847a99abc8bdae9cc7968"
    }
    
    var baseURL: String {
        return "https://newsapi.org/v2/"
    }
    
    case popular
    case search(keyWord: String)
    case byCategory(category: String)

    
    var url: URL {
        switch self {
        case .popular:
            return URL(string:"\(baseURL)top-headlines?country=us&apiKey=\(apiKey)")!
        case .search(let keyWord):
//            let encodedKeyWord = keyWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: "\(baseURL)everything?q=\(keyWord)&apiKey=\(apiKey)")!
        case .byCategory(let category):
//            let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: "\(baseURL)top-headlines?category=\(category)&country=us&apiKey=\(apiKey)")!
        }
    }
}



