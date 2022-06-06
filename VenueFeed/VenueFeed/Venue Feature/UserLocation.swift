//
//  UserLocation.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

public struct UserLocation {
    public let long: Double
    public let lat: Double
    
    public init(long: Double, lat: Double) {
        self.long = long
        self.lat = lat
    }
}
