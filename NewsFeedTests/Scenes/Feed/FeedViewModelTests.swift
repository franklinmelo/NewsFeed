//
//  FeedViewModelTests.swift
//  NewsFeedTests
//
//  Created by franklin melo on 31/07/24.
//

import XCTest
@testable import NewsFeed

final class FeedServiceSpy: FeedServicing {
    private(set) var callsCount = 0
    var data: Data?
    var response: URLResponse?
    
    func getFeedNews<T>() async throws -> T where T : Decodable {
        callsCount += 1
        guard let data else { throw CustomErrors.serverError }
        if let status = response as? HTTPURLResponse, status.statusCode >= 300 {
            throw CustomErrors.serverError
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

final class FeedViewModelTests: XCTestCase {
    let mockJson = """
{
    "status": "ok",
    "totalResults": 96,
    "articles": [
        {
            "source": {
                "id": "bleacher-report",
                "name": "Bleacher Report"
            },
            "author": "Adam Wells",
            "title": "Kiyan Anthony Explains Paul George NBA GOAT Comment: 'I Like Seeing Him Get a Bucket'",
            "description": "Kiyan Anthony, son of NBA legend Carmelo Anthony, has an extremely high opinion of Paul George. Appearing on the 7PM in Brooklyn with Carmelo Anthony and Kid…",
            "url": "https://bleacherreport.com/articles/10130148-kiyan-anthony-explains-paul-george-nba-goat-comment-i-like-seeing-him-get-a-bucket",
            "urlToImage": "https://media.bleacherreport.com/image/upload/x_0,y_683,w_1800,h_1195,c_crop/c_fill,g_faces,w_3800,h_2000,q_95/v1722352469/mqzojdgfb2r3fsu9algg.jpg",
            "publishedAt": "2024-07-30T15:37:43Z",
            "content": "Glenn James/NBAE via Getty Images\r\nKiyan Anthony, son of NBA legend Carmelo Anthony, has an extremely high opinion of Paul George.\r\nAppearing on the 7PM in Brooklyn with Carmelo Anthony and Kid Mero … [+1536 chars]"
        },
        {
            "source": {
                "id": "bleacher-report",
                "name": "Bleacher Report"
            },
            "author": "Adam Wells",
            "title": "Victor Wembanyama, Yuki Togashi Height Difference Featured in Viral Photo at Olympics",
            "description": "Victor Wembanyama being taller than everyone he's playing with or against in a basketball game is nothing new, but Tuesday's Olympic showdown between France…",
            "url": "https://bleacherreport.com/articles/10130156-victor-wembanyama-yuki-togashi-height-difference-featured-in-viral-photo-at-olympics",
            "urlToImage": "https://media.bleacherreport.com/image/upload/c_fill,g_faces,w_3800,h_2000,q_95/v1722356616/gwiux4jlzdb9yercrfcf.jpg",
            "publishedAt": "2024-07-30T16:28:46Z",
            "content": "Gregory Shamus/Getty Images\r\nVictor Wembanyama being taller than everyone he's playing with or against in a basketball game is nothing new, but Tuesday's Olympic showdown between France and Japan off… [+2244 chars]"
        }
    ]
}
""".data(using: .utf8)
    
    var sut: FeedViewModel?
    var serviceSpy: FeedServiceSpy?
    var analyticsSpy: AnalyticsEventsSpy?

    override func setUpWithError() throws {
        serviceSpy = FeedServiceSpy()
        analyticsSpy = AnalyticsEventsSpy()
        guard let serviceSpy,
              let analyticsSpy else {
            XCTFail("Spies can't be null")
            return
        }
        
        InjectedValues[\.analyticsEvents] = analyticsSpy
        sut = FeedViewModel(service: serviceSpy)
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        sut = nil
        serviceSpy = nil
        analyticsSpy = nil
    }
    
    func testFetchNews_shoulReturnArticles() async throws {
        serviceSpy?.data = mockJson
        
        try await sut?.fetchNews()
        
        XCTAssertNotNil(sut?.model)
        XCTAssertEqual(serviceSpy?.callsCount, 1)
    }
    
    func testFetchNews_whenResponseCodeIsNotValid_shoulReturnArticles() async throws {
        let fakeUrl = try XCTUnwrap(URL(string: "www.google.com"))
        serviceSpy?.data = mockJson
        serviceSpy?.response = HTTPURLResponse(url: fakeUrl, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        await XCTAssertHelper.XCTAssertThrowsErrorAsync(try await sut?.fetchNews(), CustomErrors.serverError)
        
        XCTAssertNil(sut?.model)
        XCTAssertEqual(serviceSpy?.callsCount, 1)
    }
    
    func testLogScreenAccessEvent_shouldCallWorker() throws {
        sut?.logScreenAccessEvent()
        
        XCTAssertEqual(analyticsSpy?.callsCount, 1)
        let event = try XCTUnwrap(analyticsSpy?.callsEvent)
        XCTAssertTrue(event is ScreenAccessEvent)
    }
}
