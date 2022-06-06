//
//  SceneDelegate.swift
//  VenueeApp
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit
import CoreData
import VenueFeed

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    private lazy var store: VenueStore = {
        do {
            return try CoreDataVenueStore(storeURL: NSPersistentContainer
                .defaultDirectoryURL()
                .appendingPathComponent("venue-store.sqlite"))
        } catch {
            return NullStore()
        }
    }()
    
    private lazy var localVenueLoader: LocalVenueLoader = {
        LocalVenueLoader(store: store)
    }()
    
    private lazy var navigationController = UINavigationController(
        rootViewController: VenueUIComposer.venueControllerComposedWith(location: UserLocation(long: 6.5, lat: 3.8), localVenueLoader: localVenueLoader)
    )
    
    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
