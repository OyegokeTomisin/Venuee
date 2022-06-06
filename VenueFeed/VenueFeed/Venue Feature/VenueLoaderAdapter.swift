//
//  VenueLoaderAdapter.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

public final class VenueLoaderAdapter: VenueLoader {
    
    private let remoteVenueLoader: VenueLoader
    private let localVenueLoader: VenueLoader
    
    public init(remoteLoader: VenueLoader, localLoader: VenueLoader) {
        self.remoteVenueLoader = remoteLoader
        self.localVenueLoader = localLoader
    }
    
    public func load(completion: @escaping (LoadVenueResult) -> Void) {
        remoteVenueLoader.load { [weak self] result in
            switch result {
            case .success(let array):
                completion(.success(array))
            case .failure(let error):
                guard let error =  error as? RemoteVenueLoader.Error, error == .connectivity else {
                    completion(.failure(error))
                    return
                }
                self?.localVenueLoader.load(completion: completion)
            }
        }
    }
}
