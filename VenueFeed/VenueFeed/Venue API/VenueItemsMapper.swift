//
//  VenueItemsMapper.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

internal final class VenueItemsMapper {
    
    private struct Root: Decodable {
        
        private let results: [RemoteVenue?]
        
        internal var venueItem: [Venue] {
            let items = results.compactMap( { $0 })
            return items.map { Venue(name: $0.name, address: $0.location?.address) }
        }
    }
    
    private struct RemoteVenue: Decodable {
        let name: String
        let location: RemoteVenueLocation?
    }
    
    private struct RemoteVenueLocation: Decodable {
        let address: String?
    }
    
    private static var OK_200: Int {
        return 200
    }
    
    internal static func map(data: Data, response: HTTPURLResponse) -> RemoteVenueLoader.Result {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(RemoteVenueLoader.Error.invalidData)
        }
        return .success(root.venueItem)
    }
}
