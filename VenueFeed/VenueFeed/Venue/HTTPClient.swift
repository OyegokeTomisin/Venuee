//
//  HTTPClient.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}
