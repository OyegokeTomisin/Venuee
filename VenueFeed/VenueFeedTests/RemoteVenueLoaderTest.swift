//
//  RemoteVenueLoaderTest.swift
//  VenueFeedTests
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import XCTest
import VenueFeed

class RemoteVenueLoaderTest: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty )
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(from: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(from: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    // MARK: - Helpers
    private func makeSUT(from url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteVenueLoader, cliennt: HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (RemoteVenueLoader(url: url, client: client), client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] = []
        
        func get(from url: URL) {
            requestedURLs.append(url)
        }
    }
}
