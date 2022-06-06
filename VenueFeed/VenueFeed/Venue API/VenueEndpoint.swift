//
//  VenueEndpoint.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

public enum VenueEndpoint {
    case getVenue(from: UserLocation? = nil)
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case let .getVenue(location):
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/v2/venues/search"
            components.queryItems = [
                URLQueryItem(name: "client_id", value: "0QHGCQHVQ2ZQX2AP4BIGOM3ECMHWOQZ3PMP3VOSFVRKWHCYL"),
                URLQueryItem(name: "client_secret", value: "2I133WOTERQVDHMO33MRT3TUXAY1MYEZIWZEQARUHE0JFYV0"),
                URLQueryItem(name: "limit", value: "5"),
                URLQueryItem(name: "v", value: "20220606")
            ].compactMap { $0 }
            if let location = location {
                components.queryItems?.append(URLQueryItem(name: "ll", value: "\(location.long),\(location.lat)"))
            }
            return components.url!
        }
    }
}
