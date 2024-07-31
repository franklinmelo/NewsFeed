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
    func openArticle()
    func logScreenAccessEvent()
}

final class NewsViewModel: NewsViewModelDelegate {
    @Injected(\.urlOpener) var urlOpenerWorker: HasURLOpener
    @Injected(\.analyticsEvents) var analyticsWorker: HasAnalyticsEvents
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
    
    func openArticle() {
        guard let url = URL(string: model.url) else { return }
        urlOpenerWorker.open(url: url)
        let event = ButtonClickedEvent(buttonName: "Saiba_mais", clickedDate: .now, userID: .init())
        analyticsWorker.log(event: event)
    }
    
    func logScreenAccessEvent() {
        let event = ScreenAccessEvent(screenName: "Detalhe_noticia", acessDate: .now, userID: .init())
        analyticsWorker.log(event: event)
    }
}
