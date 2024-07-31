//
//  FeedService.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import Foundation

enum CustomErrors: Error, Comparable {
    case urlFailed
    case serverError
}

protocol FeedServicing {
    func getFeedNews<T: Decodable>() async throws -> T
}

final class FeedService: FeedServicing {
    private let urlAPI = "https://newsapi.org/v2/everything"
    private let endPointParams: [URLQueryItem] = [
        .init(name: "from", value: "2024-07-01"),
        .init(name: "sortBy", value: "publishAt"),
        .init(name: "apiKey", value: "a8c3eaa851534d5e9526e17535eaee99"),
        .init(name: "q", value: "Jogos+Games+Xbox+Playstation+Nintendo"),
        .init(name: "language", value: "pt")
    ]
    
    func getFeedNews<T>() async throws -> T where T : Decodable {
        guard var endPoint = URL(string: urlAPI) else { throw CustomErrors.urlFailed }
        endPoint.append(queryItems: endPointParams)
        
        do {
            let (data, response) = try await URLSession.shared.data(from: endPoint)
            if let status = response as? HTTPURLResponse, status.statusCode >= 300 {
                throw CustomErrors.serverError
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
