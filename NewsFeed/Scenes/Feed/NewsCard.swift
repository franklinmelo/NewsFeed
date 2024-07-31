//
//  NewsCard.swift
//  NewsFeed
//
//  Created by franklin melo on 31/07/24.
//

import SwiftUI

struct NewsCard: View {
    private var news: News
    init(news: News) {
        self.news = news
    }
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: news.urlToImage ?? "")) {
                $0
                    .resizable()
                    .frame(maxWidth: 150, maxHeight: 100)
                    .cornerRadius(15.0)
            } placeholder: {
                Rectangle()
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: 150, maxHeight: 100)
                    .cornerRadius(15.0)
            }
            
            VStack(alignment: .leading) {
                Text(news.author ?? "")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundStyle(.placeholder)
                
                Text(news.title)
                    .font(.headline)
                    .lineLimit(4)
            }
        }
    }
}
