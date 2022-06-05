//
//  VenueUIComposer.swift
//  VenueeApp
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import Foundation
import VenueFeediOS

public final class VenueUIComposer {
    
    private init() {}
    
    public static func venueControllerComposedWith() -> VenueRootViewController {
        let controller = makeVenueRootController()
        return controller
    }
    
    private static func makeVenueRootController() -> VenueRootViewController {
        let venueController = makeVenueViewController()
        let aboutUsController = makeAboutUsViewController()
        let rootViewController = VenueRootViewController(venueController: venueController, aboutUsController: aboutUsController)
        return rootViewController
    }
    
    private static func makeVenueViewController() -> VenueViewController {
        let venueController = VenueViewController()
        return venueController
    }
    
    private static func makeAboutUsViewController() -> AboutUsViewController {
        let aboutUsController = AboutUsViewController()
        return aboutUsController
    }
}
