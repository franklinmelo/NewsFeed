//
//  FeedFactory.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import Foundation

enum FeedFactory {
    static func make() -> FeedView<FeedViewModel> {
        let service = FeedService()
        let viewModel = FeedViewModel(service: service)
        let view = FeedView(viewModel: viewModel)
        
        return view
    }
}
