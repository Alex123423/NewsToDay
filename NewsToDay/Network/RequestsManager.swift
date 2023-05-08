//
//  RequestsManager.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-03.
//

import Foundation

final class RequestsManager {
    
    static let shared = RequestsManager()
    private init() { }
    
    func getTopNews(completion: @escaping (Result<NewsModel, Error>) -> Void) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: API.popular.url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let receivedNews = try decoder.decode(NewsModel.self, from: data)
                        completion(.success(receivedNews))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    
    func getNewsByCategory(category: String, completion: @escaping (Result<NewsModel, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let url = API.byCategory(category: category).url
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let receivedNewsByCategory = try decoder.decode(NewsModel.self, from: data)
                    completion(.success(receivedNewsByCategory))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getNewsByKeyWord(keyWord: String, completion: @escaping (Result<NewsModel, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let url = API.search(keyWord: keyWord).url
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let receivedSearchResults = try decoder.decode(NewsModel.self, from: data)
                    completion(.success(receivedSearchResults))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
