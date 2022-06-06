//
//  VenueLayout.swift
//  VenueFeediOS
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import UIKit

final internal class VenueLayout: UIView {
    
    internal let venuItemTableView = UITableView()
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews(venuItemTableView)
        venuItemTableView.fillSuperview()
    }
}
