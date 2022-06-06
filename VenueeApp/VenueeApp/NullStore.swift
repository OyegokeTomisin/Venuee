//
//  NullStore.swift
//  VenueeApp
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation
import VenueFeed

class NullStore {}

extension NullStore: VenueStore {
    func deleteCachedVenue() throws { }
    func insert(_ feed: [Venue]) throws { }
    func retrieve() throws -> [Venue]? { return nil }
}
