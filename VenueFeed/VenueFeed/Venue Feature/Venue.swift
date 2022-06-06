//
//  Venue.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

public struct Venue: Equatable {
    public let name: String
    public let address: String?
    
    public init(name: String, address: String?) {
        self.name = name
        self.address = address
    }
}
