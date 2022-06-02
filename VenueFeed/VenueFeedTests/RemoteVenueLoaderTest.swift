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
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(from: url)
        
        sut.load { _  in }
        sut.load { _  in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [RemoteVenueLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        [199, 201, 300, 400, 500].enumerated().forEach { index, code in
            var capturedErrors = [RemoteVenueLoader.Error]()
            sut.load { capturedErrors.append($0) }
            
            client.complete(withStatusCode: code, at: index)
            XCTAssertEqual(capturedErrors, [.invalidData])
        }
    }
    
    // MARK: - Helpers
    private func makeSUT(from url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteVenueLoader, cliennt: HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (RemoteVenueLoader(url: url, client: client), client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        
        var requestedURLs: [URL] {
            return messages.map { $0.url  }
        }
        
        private var messages: [(url: URL , completions: (HTTPClientResult) -> Void)] = []
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completions(.failure(error))
        }
        
        func complete(withStatusCode code: Int, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[0], statusCode: code, httpVersion: nil, headerFields: nil)!
            messages[index].completions(.success(response))
        }
    }
}
