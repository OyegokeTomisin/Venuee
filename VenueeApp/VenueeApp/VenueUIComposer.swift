//
//  VenueUIComposer.swift
//  VenueeApp
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import Foundation
import VenueFeediOS
import VenueFeed

public final class VenueUIComposer {
    
    private init() {}
    
    public static func venueControllerComposedWith(location: UserLocation?, localVenueLoader: LocalVenueLoader) -> VenueRootViewController {
        let client = URLSessionHTTPClient()
        let urlRequest = VenueEndpoint.getVenue(from: location).urlRequest(baseURL: URL(string: "https://api.foursquare.com")!)
        let loader = RemoteVenueLoader(urlRequest: urlRequest, client: client)
        let venueLoaderAdapter = VenueLoaderAdapter(remoteLoader: loader, localLoader: localVenueLoader)
        let controller = makeVenueRootController(loader: venueLoaderAdapter)
        return controller
    }
    
    private static func makeVenueRootController(loader: VenueLoader) -> VenueRootViewController {
        let viewModel = VenueFeedViewModel(venueLoader: loader)
        let venueController = makeVenueViewController(with: viewModel)
        let aboutUsController = makeAboutUsViewController()
        let rootViewController = VenueRootViewController(venueController: venueController, aboutUsController: aboutUsController)
        return rootViewController
    }
    
    private static func makeVenueViewController(with venueFeedViewModel: VenueFeedViewModel) -> VenueViewController {
        let venueController = VenueViewController(viewModel: venueFeedViewModel)
        return venueController
    }
    
    private static func makeAboutUsViewController() -> AboutUsViewController {
        let url = URL(string: "https://generator.lorem-ipsum.info/terms-and-conditions")
        let aboutUsController = AboutUsViewController(pageURL: url!)
        return aboutUsController
    }
}
