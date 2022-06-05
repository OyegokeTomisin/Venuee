//
//  VenueRootViewController.swift
//  VenueFeediOS
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit

public final class VenueRootViewController: UIViewController {
    
    private let layout = RootVenueLayout()
    private(set) var venueController: VenueViewController?
    private(set) var aboutUsController: AboutUsViewController?
    
    private let defaultSegment: Int = 0
    
    convenience public init(venueController: VenueViewController, aboutUsController: AboutUsViewController) {
        self.init()
        self.venueController = venueController
        self.aboutUsController = aboutUsController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpOnLoad()
        setupViewBinding()
        switchSegment(to: defaultSegment)
    }
    
    func setUpOnLoad() {
        view.addSubview(layout)
        view.backgroundColor = .white
        layout.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    private func setupViewBinding() {
        layout.segmentedControlView.onTap = { [weak self] index in
            self?.switchSegment(to: index)
        }
    }
    
    private func switchSegment(to index: Int) {
        switch index {
        case 0:
            setupController(byAdding: venueController, removing: aboutUsController)
        case 1:
            setupController(byAdding: aboutUsController, removing: venueController)
        default:
            break
        }
    }
    
    private func setupController(byAdding addedViewController: UIViewController?, removing viewController: UIViewController?) {
        if let controllerToRemoved = viewController {
            self.remove(asChildViewController: controllerToRemoved)
        }
        if let controllerToAdd = addedViewController {
            self.add(asChildViewController: controllerToAdd, view: layout.containerView)
        }
    }
}
