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
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.get(from: url)
    }
}
