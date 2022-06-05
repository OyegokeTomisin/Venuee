//
//  SceneDelegate.swift
//  VenueeApp
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit
import VenueFeed
import VenueFeediOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        let venueViewController = VenueViewController()
        let aboutUsViewController = AboutUsViewController()
        let rootController = VenueRootViewController(venueController: venueViewController, aboutUsController: aboutUsViewController)
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}

