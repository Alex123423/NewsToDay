//
//  API.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-02.
//

import Foundation

enum API {
    var apiKey: String {
       return "pub_21924ad04488c43e5d7a6ab402385b44f4c29"
    }
    
    var baseURL: String {
        return "https://newsdata.io/api/1/news?apikey="
    }
    
    case popular
    case search(keyWord: String)
    case byCategory(category: String)

    //generating urls for network requests
    var url: URL {
        switch self {
        case .popular:
            return URL(string:"\(baseURL)\(apiKey)&language=en")!
        case .search(let keyWord):
            let encodedKeyWord = keyWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: "\(baseURL)\(apiKey)&q=\(encodedKeyWord)&language=en")!
        case .byCategory(let category):
            return URL(string: "\(baseURL)\(apiKey)&category=\(category)&language=en")!
        }
    }
}





