//
//  NewsDetailViewModelTests.swift
//  NewsFeedTests
//
//  Created by franklin melo on 31/07/24.
//

import XCTest
@testable import NewsFeed

private extension News {
    static func fixture(url: String? = nil) -> News {
        .init(
            author: "newsweek.com",
            title: "Clippers",
            description: "new NBA…",
            url: url ?? "https://biztoc.com/x/ffef954802c595f3",
            urlToImage: "https://a2.espncdn.com/combiner/i?img=%2Fphoto%2F2024%2F0124%2Fr1281889_1296x729_16%2D9.jpg",
            publishedAt: "2024-05-11T17:22:06Z"
        )
    }
}

final class AnalyticsEventsSpy: HasAnalyticsEvents {
    private(set) var callsCount = 0
    private(set) var callsEvent: (any Event)?
    
    func log(event: any Event) {
        callsCount += 1
        callsEvent = event
    }
}

final class URLOpenerSpy: HasURLOpener {
    enum Messages: Equatable {
        case open(url: String)
    }
    private(set) var calls = [Messages]()
    
    func open(url: URL) {
        calls.append(.open(url: url.absoluteString))
    }
}

final class NewsDetailViewModelTests: XCTestCase {
    var sut: NewsViewModel?
    var analyticsSpy: AnalyticsEventsSpy?
    var urlOpenerSpy:URLOpenerSpy?

    override func setUpWithError() throws {
        analyticsSpy = AnalyticsEventsSpy()
        urlOpenerSpy = URLOpenerSpy()
        guard let analyticsSpy ,
              let urlOpenerSpy else {
            XCTFail("Spies can't be null")
            return
        }
        InjectedValues[\.analyticsEvents] = analyticsSpy
        InjectedValues[\.urlOpener] = urlOpenerSpy
        sut = NewsViewModel(model: .fixture())
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        sut = nil
        analyticsSpy = nil
        urlOpenerSpy = nil
    }

    func testGetFormatedDate_shouldReturnUSFormat() throws {
        let date = try XCTUnwrap(sut?.getFormatedDate())
        
        XCTAssertEqual(date, "05/11/2024")
    }
    
    func testOpenArticle_shouldCallWorker() throws {
        sut?.openArticle()
        
        XCTAssertEqual(urlOpenerSpy?.calls, [.open(url: sut?.model.url ?? "")])
        XCTAssertEqual(analyticsSpy?.callsCount, 1)
        let event = try XCTUnwrap(analyticsSpy?.callsEvent)
        XCTAssertTrue(event is ButtonClickedEvent)
    }
    
    func testOpenArticle_whenUrlIsInvalid_shouldNotCallWorker() throws {
        sut = NewsViewModel(model: .fixture(url: ""))
        sut?.openArticle()
        
        XCTAssertEqual(urlOpenerSpy?.calls, [])
        XCTAssertEqual(analyticsSpy?.callsCount, 0)
        XCTAssertNil(analyticsSpy?.callsEvent)
    }
    
    func testLogScreenAccessEvent_shouldCallWorker() throws {
        sut?.logScreenAccessEvent()
        
        let event = try XCTUnwrap(analyticsSpy?.callsEvent)
        XCTAssertTrue(event is ScreenAccessEvent)
    }
}
