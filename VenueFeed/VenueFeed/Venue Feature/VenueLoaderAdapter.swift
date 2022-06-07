//
//  VenueLoaderAdapter.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

public final class VenueLoaderAdapter: VenueLoader {
    
    private let remoteVenueLoader: VenueLoader
    private let localVenueLoader: LocalVenueLoader
    
    public init(remoteLoader: VenueLoader, localLoader: LocalVenueLoader) {
        self.remoteVenueLoader = remoteLoader
        self.localVenueLoader = localLoader
    }
    
    public func load(completion: @escaping (LoadVenueResult) -> Void) {
        remoteVenueLoader.load { [weak self] result in
            switch result {
            case let .success(items):
                completion(.success(items))
                try? self?.localVenueLoader.save(items)
            case .failure(let error):
                guard let error = error as? RemoteVenueLoader.Error, error == .connectivity else {
                    completion(.failure(error))
                    return
                }
                self?.handleConnectivityFallback(completion: completion)
            }
        }
    }
    
    private func handleConnectivityFallback(completion: @escaping (LoadVenueResult) -> Void) {
        do {
            let items = try localVenueLoader.load()
            completion(.success(items))
        } catch let error {
            completion(.failure(error))
        }
    }
}
