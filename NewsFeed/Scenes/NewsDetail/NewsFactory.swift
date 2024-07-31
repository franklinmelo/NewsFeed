//
//  NewsFactory.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import Foundation

enum NewsFactory {
    static func make(_ model: News) -> NewsDetail {
        let viewModel = NewsViewModel(model: model)
        let view = NewsDetail(viewModel: viewModel)
        
        return view
    }
}
