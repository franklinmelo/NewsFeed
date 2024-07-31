//
//  FeedModel.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import Foundation

struct FeedNews: Decodable {
    var articles: [News]
}

struct News: Decodable, Identifiable {
    var id: UUID = .init()
    var author: String?
    var title: String
    var description: String
    var url: String
    var urlToImage: String?
    var publishedAt: String
    
    enum CodingKeys: CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
    }
    
    public init(
        author: String,
        title: String,
        description: String,
        url: String,
        urlToImage: String,
        publishedAt: String
    ) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.url = try container.decode(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
    }
}
