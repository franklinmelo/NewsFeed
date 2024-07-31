//
//  FeedView.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
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

struct FeedView<T: FeedViewModelDelegate>: View {
    @ObservedObject var viewModel: T
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Buscando noticias")
                }
                List {
                    if let articles = viewModel.model?.articles {
                        ForEach(articles) { new in
                            NavigationLink {
                                NewsFactory.make(new)
                            } label: {
                                NewsCard(news: new)
                            }

                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    do {
                        try await viewModel.fetchNews()
                    } catch {
                        print(error)
                    }
                }
                .navigationTitle("Noticias Games")
            }
            .task {
                do {
                    try await viewModel.fetchNews()
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    FeedFactory.make()
}
