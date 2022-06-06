//
//  VenueEndpoint.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

public enum VenueEndpoint {
    case getVenue(from: UserLocation? = nil)
    
    public func urlRequest(baseURL: URL) -> URLRequest {
        switch self {
        case let .getVenue(location):
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/v3/places/search"
            components.queryItems = [
                URLQueryItem(name: "limit", value: "5"),
            ].compactMap { $0 }
            if let location = location {
                let query = URLQueryItem(name: "ll", value: "\(location.long),\(location.lat)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                components.queryItems?.append(query)
            }
            
            var request = URLRequest(url: components.url!)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("fsq3dvW/hitAzgkHxxrwFRs+gPTkcM1ZhzHPOhsDT4P04AU=", forHTTPHeaderField: "Authorization")
            
            return request
        }
    }
}
