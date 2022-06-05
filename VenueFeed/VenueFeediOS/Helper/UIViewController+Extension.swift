//
//  UIViewController+Extension.swift
//  VenueFeediOS
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit

extension UIViewController {
    
    func add(asChildViewController viewController: UIViewController, view: UIView) {
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.fillSuperview()
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
