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
}

// MARK: - Result
struct Result: Codable, Equatable {
    let title: String?
    let link: String?
    let keywords: [String]?
    let creator: [String]?
    let videoURL: JSONNull?
    let description, content, pubDate: String?
    let imageURL: String?
    let sourceID: String?
    let category: [String]?
    let country: [String]?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case videoURL = "video_url"
        case description, content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case category, country, language
    }
}

//enum Category: String, Codable {
//    case business = "business"
//    case politics = "politics"
//    case top = "top"
//    case entertainment = "entertainment"
//    case environment = "environment"
//    case food = "food"
//    case health = "health"
//    case science = "science"
//    case sports = "sports"
//    case technology = "technology"
//    case tourism = "tourism"
//    case world = "world"
//}

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

