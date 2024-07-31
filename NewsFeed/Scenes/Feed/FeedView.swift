//
//  FeedView.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import SwiftUI

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
        }
        .task {
            do {
                try await viewModel.fetchNews()
            } catch {
                print(error)
            }
        }
        .onAppear(perform: {
            viewModel.logScreenAccessEvent()
        })
    }
}

#Preview {
    FeedFactory.make()
}
