//
//  URLOpener.swift
//  NewsFeed
//
//  Created by franklin melo on 31/07/24.
//

import Foundation
import UIKit

protocol HasURLOpener {
    func open(url: URL)
}

final class URLOpener: HasURLOpener {
    func open(url: URL) {
        UIApplication.shared.open(url)
    }
}

private struct UrlOpenerKey: InjectionKey {
    static var currentValue: HasURLOpener = URLOpener()
}

extension InjectedValues {
    var urlOpener: HasURLOpener {
        get { Self[UrlOpenerKey.self] }
        set { Self[UrlOpenerKey.self] = newValue }
    }
}
