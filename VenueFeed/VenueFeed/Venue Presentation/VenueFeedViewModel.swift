//
//  VenueFeedViewModel.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import Foundation

final public class VenueFeedViewModel {
    
    private let venueLoader: VenueLoader
    private(set) var venueList: [Venue] = []
    
    public var reloadData: (() -> Void)?
    public var alertErrorMessage: ((String) -> Void)?
    public var venueItems: [Venue] {
        return venueList
    }
    
    public init(venueLoader: VenueLoader) {
        self.venueLoader = venueLoader
    }
    
    public func fetchNearestVenue() {
        venueLoader.load { [weak self] result in
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
            alertErrorMessage?(error.localizedDescription)
        }
    }
}
