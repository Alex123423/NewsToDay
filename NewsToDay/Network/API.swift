//
//  API.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-02.
//

import Foundation

enum API {
    var apiKey: String {
        return "pub_21869cabfb95c023632642986db7f1d4be756"
//        "pub_2205626b53755973b1578aa4aae8877974363"
//        "pub_2208163cf5d19778bb3af801dba462a505e4d"
//        "pub_21869cabfb95c023632642986db7f1d4be756"
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



