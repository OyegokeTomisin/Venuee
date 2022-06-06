//
//  RemoteVenueLoader.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

public final class RemoteVenueLoader: VenueLoader {
    
    private let urlRequest: URLRequest
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadVenueResult
    
    public init(urlRequest: URLRequest, client: HTTPClient) {
        self.urlRequest = urlRequest
        self.client = client
    }
    
    public func load(completion: @escaping (LoadVenueResult) -> Void) {
        client.get(from: urlRequest) { [weak self] result  in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(VenueItemsMapper.map(data: data, response: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
