//
//  VenueLoader.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

public enum LoadVenueResult {
    case success([Venue])
    case failure(Error)
}

public protocol VenueLoader {
    func load(completion: @escaping (LoadVenueResult) -> Void)
}
