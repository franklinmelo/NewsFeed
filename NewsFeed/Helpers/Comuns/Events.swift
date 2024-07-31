//
//  AnalyticsEvents.swift
//  NewsFeed
//
//  Created by franklin melo on 31/07/24.
//

import Foundation

struct ScreenAccessEvent: Event {
    var screenName: String
    var acessDate: Date
    var userID: UUID
}

struct ButtonClickedEvent: Event {
    var buttonName: String
    var clickedDate: Date
    var userID: UUID
}
