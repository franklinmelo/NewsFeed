//
//  FeedViewModel.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import Foundation

protocol FeedViewModelDelegate: ObservableObject {
    var model: FeedNews? { get }
    var isLoading: Bool { get }
    func fetchNews() async throws
}

final class FeedViewModel: FeedViewModelDelegate {
    @Published var model: FeedNews?
    @Published var isLoading: Bool = false
    private var service: FeedServicing
    
    init(service: FeedServicing) {
        self.service = service
    }
    
    @MainActor
    func fetchNews() async throws {
        isLoading = true
        do {
            model = try await service.getFeedNews()
            isLoading = false
        } catch {
            throw error
        }
    }
}
