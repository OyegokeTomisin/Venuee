//
//  HTTPClient.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 02/06/2022.
//

import Foundation

public enum HTTPClientResult {
    case success(HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
