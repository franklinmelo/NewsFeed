//
//  NewsFeedApp.swift
//  NewsFeed
//
//  Created by franklin melo on 30/07/24.
//

import SwiftUI

@main
struct NewsFeedApp: App {
    var body: some Scene {
        WindowGroup {
            FeedFactory.make()
        }
    }
}
