//
//  VenueItemsMapper.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

internal final class VenueItemsMapper {
    
    private struct Root: Decodable {
        private let response: RootVenue
        internal var venueItem: [Venue] {
            return response.venues.map { Venue(id: $0.id, name: $0.name) }
        }
    }
    
    private struct RootVenue: Decodable {
        let venues: [RemoteVenue]
    }
    
    private struct RemoteVenue: Decodable {
        let id: String
        let name: String
    }
    
    private static var OK_200: Int {
        return 200
    }
    
    internal static func map(data: Data, response: HTTPURLResponse) -> RemoteVenueLoader.Result {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(.invalidData)
        }
        return .success(root.venueItem)
    }
}
