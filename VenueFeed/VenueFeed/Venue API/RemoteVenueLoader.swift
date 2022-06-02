//
//  RemoteVenueLoader.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

public final class RemoteVenueLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([Venue])
        case failure(RemoteVenueLoader.Error)
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result  in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(VenueItemsMapper.map(data: data, response: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}