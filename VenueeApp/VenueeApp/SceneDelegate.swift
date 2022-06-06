//
//  SceneDelegate.swift
//  VenueeApp
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit
import VenueFeed

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    private lazy var navigationController = UINavigationController(
        rootViewController: VenueUIComposer.venueControllerComposedWith(location: UserLocation(long: 6.5, lat: 3.8))
    )
    
    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
