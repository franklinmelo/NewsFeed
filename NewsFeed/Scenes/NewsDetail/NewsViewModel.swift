//
//  NewsViewModel.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import Foundation

protocol NewsViewModelDelegate {
    var model: News { get }
    func getFormatedDate() -> String
}

final class NewsViewModel: NewsViewModelDelegate {
    var model: News
    
    init(model: News) {
        self.model = model
    }
    
    func getFormatedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: model.publishedAt)
        return date?.formatted(date: .abbreviated, time: .omitted) ?? ""
    }
}
