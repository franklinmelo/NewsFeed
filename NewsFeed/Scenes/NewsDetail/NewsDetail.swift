//
//  NewsDetail.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import SwiftUI

struct NewsDetail: View {
    var viewModel: NewsViewModelDelegate
    
    init(viewModel: NewsViewModelDelegate) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(viewModel.model.author ?? "")
                .font(.subheadline)
                .lineLimit(1)
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: viewModel.model.urlToImage ?? "")) {
                    $0.image?
                        .resizable()
                        .scaledToFit()
                }
            }
            Text(viewModel.model.title)
                .font(.title)
                .padding(4)
            Text(viewModel.model.description)
                .font(.body)
                .foregroundStyle(.gray)
            
            HStack {
                Text(viewModel.getFormatedDate())
                    .foregroundStyle(.placeholder)
                Spacer()
                if let url = URL(string: viewModel.model.url) {
                    Link("Saiba mais", destination: url)
                }
            }
            .padding(.vertical)
        }
        .padding()
        Spacer()
    }
}

#Preview {
    NewsFactory.make(
        .init(
            author: "newsweek.com",
            title: "Clippers' Russell Westbrook Has Huge Free Agent Decision to Make",
            description: "Over the course of his NBA career, point guard Russell Westbrook has become a somewhat polarizing player. While he is a likely future Hall of Famer, Westbrook's play style and inability to shoot the ball at a high rate have come under fire within this new NBA…",
            url: "https://biztoc.com/x/ffef954802c595f3",
            urlToImage: "https://a2.espncdn.com/combiner/i?img=%2Fphoto%2F2024%2F0124%2Fr1281889_1296x729_16%2D9.jpg",
            publishedAt: "2024-05-11T17:22:06Z"
        )
    )
}
