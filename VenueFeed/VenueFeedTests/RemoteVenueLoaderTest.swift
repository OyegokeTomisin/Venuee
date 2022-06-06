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
        expect(sut, toCompleteWithResult: .failure(RemoteVenueLoader.Error.connectivity)) {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        }
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        [199, 201, 300, 400, 500].enumerated().forEach { index, code in
            expect(sut, toCompleteWithResult: .failure(RemoteVenueLoader.Error.invalidData)) {
                client.complete(withStatusCode: code, at: index)
            }
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        expect(sut, toCompleteWithResult: .failure(RemoteVenueLoader.Error.invalidData)) {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        }
    }
    
    func test_load_deliversNoVenueOn200HTTPResponseWithEmptyJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWithResult: .success([])) {
            let emptyListJSON = makeResultsJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        }
    }
    
    func test_load_deliversVenueItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        
        let venue1 = Venue(name: "FirstBank Allen Avenue branch", address: nil)
        let venue2 = Venue(name: "Washyard Laundromat",  address: nil)
        
        let jsonItem1 = ["name": venue1.name]
        let jsonItem2 = ["name": venue2.name]
        
        let responseJSON = ["results": [jsonItem1, jsonItem2]]
        
        expect(sut, toCompleteWithResult: .success([venue1, venue2])) {
            let json = try! JSONSerialization.data(withJSONObject: responseJSON)
            client.complete(withStatusCode: 200, data: json)
        }
    }
    
    func test_load_doesNotDeliverResultAfterSUTDeallocation() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://a-url.com")!
        var sut: RemoteVenueLoader? = RemoteVenueLoader(urlRequest: URLRequest(url: url), client: client)
        
        var capturedResults = [RemoteVenueLoader.Result]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        
        let emptyListJSON = makeResultsJSON([])
        client.complete(withStatusCode: 200, data: emptyListJSON)
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // MARK: - Helpers
    private func makeSUT(from url: URL = URL(string: "https://a-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteVenueLoader, cliennt: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteVenueLoader(urlRequest: URLRequest(url: url), client: client)
        
        trackForMemoryLeaks(sut, file, line)
        trackForMemoryLeaks(client, file, line)
        
        return (sut, client)
    }
    
    func makeResultsJSON(_ items: [[String: Any]]) -> Data {
        let json = ["results": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    fileprivate func trackForMemoryLeaks(_ instance: AnyObject, _ file: StaticString, _ line: UInt) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Potential memory leak ", file: file, line: line)
        }
    }
    
    private func expect(_ sut: RemoteVenueLoader, toCompleteWithResult expectedResult: RemoteVenueLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
            case let (.failure(receivedError as RemoteVenueLoader.Error), .failure(expectedError as RemoteVenueLoader.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) but got \(receivedResult)", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private class HTTPClientSpy: HTTPClient {
        
        var requestedURLs: [URL] {
            return messages.map { $0.url  }
        }
        
        private var messages: [(url: URL , completions: (HTTPClientResult) -> Void)] = []
        
        func get(from request: URLRequest, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((request.url!, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completions(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[0], statusCode: code, httpVersion: nil, headerFields: nil)!
            messages[index].completions(.success(data, response))
        }
    }
}
extension Data {
    
    // MARK: Helper extension to print data in json-like format
    
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}
