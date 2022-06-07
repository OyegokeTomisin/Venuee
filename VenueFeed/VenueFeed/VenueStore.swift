//
//  VenueStore.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

public protocol VenueStore {
    func deleteCachedVenue() throws
    func insert(_ items: [Venue]) throws
    func retrieve() throws -> [Venue]?
}
