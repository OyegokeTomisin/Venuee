//
//  VenueEndpointTests.swift
//  VenueFeedTests
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import XCTest
import VenueFeed

class VenueEndpointTests: XCTestCase {
    
    func test_feed_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!
        
        let received = VenueEndpoint.getVenue().url(baseURL: baseURL)
        
        XCTAssertEqual(received.scheme, "http", "scheme")
        XCTAssertEqual(received.host, "base-url.com", "host")
        XCTAssertEqual(received.path, "/v2/venues/search", "path")
        
        XCTAssertEqual(received.query?.contains("client_id=0QHGCQHVQ2ZQX2AP4BIGOM3ECMHWOQZ3PMP3VOSFVRKWHCYL"), true, "client id query param")
        XCTAssertEqual(received.query?.contains("client_secret=2I133WOTERQVDHMO33MRT3TUXAY1MYEZIWZEQARUHE0JFYV0"), true, "client secret query param")
        XCTAssertEqual(received.query?.contains("ll="), false, "location query param")
        XCTAssertEqual(received.query?.contains("limit=5"), true, "limit query param")
        XCTAssertEqual(received.query?.contains("v=20220606"), true, "version query param")
    }
    
    func test_feed_endpointURLAfterGivenLocation() {
        let userLoaction = UserLocation(long: 4.5, lat: 4.5)
        let baseURL = URL(string: "http://base-url.com")!
        
        let received = VenueEndpoint.getVenue(from: userLoaction).url(baseURL: baseURL)
        
        XCTAssertEqual(received.scheme, "http", "scheme")
        XCTAssertEqual(received.host, "base-url.com", "host")
        XCTAssertEqual(received.path, "/v2/venues/search", "path")
        
        XCTAssertEqual(received.query?.contains("client_id=0QHGCQHVQ2ZQX2AP4BIGOM3ECMHWOQZ3PMP3VOSFVRKWHCYL"), true, "client id query param")
        XCTAssertEqual(received.query?.contains("client_secret=2I133WOTERQVDHMO33MRT3TUXAY1MYEZIWZEQARUHE0JFYV0"), true, "client secret query param")
        XCTAssertEqual(received.query?.contains("ll=\(userLoaction.long),\(userLoaction.lat)"), true, "location query param")
        XCTAssertEqual(received.query?.contains("limit=5"), true, "limit query param")
        XCTAssertEqual(received.query?.contains("v=20220606"), true, "version query param")
    }
}
