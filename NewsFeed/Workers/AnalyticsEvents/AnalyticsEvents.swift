//
//  AnalyticsEvents.swift
//  NewsFeed
//
//  Created by franklin melo on 31/07/24.
//

import Foundation

protocol Event: Codable {}

protocol HasAnalyticsEvents {
    func log(event: Event)
}

final class AnalyticsEvents: HasAnalyticsEvents {
    func log(event: any Event) {
        print(event)
    }
}

private struct AnalyticsEventsKey: InjectionKey {
    static var currentValue: HasAnalyticsEvents = AnalyticsEvents()
}

extension InjectedValues {
    var analyticsEvents: HasAnalyticsEvents {
        get { Self[AnalyticsEventsKey.self] }
        set { Self[AnalyticsEventsKey.self] = newValue }
    }
}
