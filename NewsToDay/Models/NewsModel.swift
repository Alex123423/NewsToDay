//
//  TopNewsModel.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-03.
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let status: String?
    let totalResults: Int?
    let results: [Result]
//    let nextPage: JSONNull?
}

// MARK: - Result
struct Result: Codable {
    let title: String?
    let link: String?
    let keywords: [String]?
    let creator: [String]?
    let videoURL: JSONNull?
    let description, content, pubDate: String?
    let imageURL: String?
    let sourceID: SourceID?
    let category: [Category]?
    let country: [Country]?
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case videoURL = "video_url"
        case description, content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case category, country, language
    }
}

enum Category: String, Codable {
    case business = "business"
    case politics = "politics"
    case top = "top"
    case entertainment = "entertainment"
    case environment = "environment"
    case food = "food"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    case tourism = "tourism"
    case world = "world"
}

enum Country: String, Codable {
    case austria = "austria"
    case indonesia = "indonesia"
}

enum Language: String, Codable {
    case german = "german"
    case indonesian = "indonesian"
}

enum SourceID: String, Codable {
    case liputan6 = "liputan6"
    case meinbezirk = "meinbezirk"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

//// MARK: - NewsByCategoryModel
//struct NewsModel: Codable {
//    let status: String
//    let totalResults: Int
//    let articles: [Article]
//}
//
//// MARK: - Article
//struct Article: Codable {
//    let source: Source
//    let author: String?
//    let title: String
//    let description: String?
//    let url: String
//    let urlToImage: String?
//    let publishedAt: String
//    let content: String?
//}
//
//// MARK: - Source
//struct Source: Codable {
//    let id: String?
//    let name: String
//}

