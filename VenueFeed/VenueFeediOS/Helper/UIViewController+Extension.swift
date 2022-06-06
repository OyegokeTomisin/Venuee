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
    
    func showErrorMessage(title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
