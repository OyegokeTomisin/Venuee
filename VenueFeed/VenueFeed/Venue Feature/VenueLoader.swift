//
//  VenueLoader.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

enum LoadVenueResult {
    case success([Venue])
    case error(Error)
}

protocol VenueLoader {
    func load(completion: @escaping (LoadVenueResult) -> Void)
}
