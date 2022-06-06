//
//  LocalVenueLoader.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

public final class LocalVenueLoader {
    
    private let store: VenueStore
    
    public init(store: VenueStore) {
        self.store = store
    }
    
    public func save(_ items: [Venue]) throws {
        try store.deleteCachedVenue()
        try store.insert(items)
    }
    
    public func load() throws -> [Venue] {
        if let cache = try store.retrieve() {
            return cache
        }
        return []
    }
}
