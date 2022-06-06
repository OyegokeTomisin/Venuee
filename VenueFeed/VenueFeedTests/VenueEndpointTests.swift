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
        
        let received = VenueEndpoint.getVenue().urlRequest(baseURL: baseURL).url!
        
        XCTAssertEqual(received.scheme, "http", "scheme")
        XCTAssertEqual(received.host, "base-url.com", "host")
        XCTAssertEqual(received.path, "/v3/places/search", "path")
        XCTAssertEqual(received.query?.contains("ll="), false, "location query param")
        XCTAssertEqual(received.query?.contains("limit=5"), true, "limit query param")
    }
    
    func test_feed_endpointURLAfterGivenLocation() {
        let userLoaction = UserLocation(long: 4.5, lat: 4.5)
        let baseURL = URL(string: "http://base-url.com")!
        
        let received = VenueEndpoint.getVenue(from: userLoaction).urlRequest(baseURL: baseURL).url!
        
        XCTAssertEqual(received.scheme, "http", "scheme")
        XCTAssertEqual(received.host, "base-url.com", "host")
        XCTAssertEqual(received.path, "/v3/places/search", "path")
        
        XCTAssertEqual(received.query?.contains("ll=\(userLoaction.long),\(userLoaction.lat)"), true, "location query param")
        XCTAssertEqual(received.query?.contains("limit=5"), true, "limit query param")
    }
}
