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
}
