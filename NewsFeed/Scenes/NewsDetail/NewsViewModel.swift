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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: model.publishedAt) else { return "" }
        
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("ddMMyyyy")
        let stringDate = formatter.string(from: date)
        return stringDate
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
