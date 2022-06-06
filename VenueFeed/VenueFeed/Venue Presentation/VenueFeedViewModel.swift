//
//  VenueFeedViewModel.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

final public class VenueFeedViewModel {
    
    private let remoteLoader: VenueLoader
    private(set) var venueList: [Venue] = []
    
    public var reloadData: (() -> Void)?
    public var venueItems: [Venue] {
        return venueList
    }
    
    public init(remoteLoader: VenueLoader) {
        self.remoteLoader = remoteLoader
    }
    
    public func fetchNearestVenue() {
        remoteLoader.load { [weak self] result in
            DispatchQueue.main.async {
                self?.handleResult(result: result)
            }
        }
    }
    
    private func handleResult(result: LoadVenueResult) {
        switch result {
        case .success(let array):
            venueList = array
            reloadData?()
        case .failure(let error):
            if let error =  error as? RemoteVenueLoader.Error {
                switch error {
                case .connectivity:
                    debugPrint(error)
                case .invalidData:
                    debugPrint(error)
                }
            } else {
                debugPrint(error)
            }
        }
    }
}
