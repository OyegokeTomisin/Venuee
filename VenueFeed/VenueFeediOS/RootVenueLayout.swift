//
//  RootVenueLayout.swift
//  VenueFeediOS
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit

final internal class RootVenueLayout: UIView {
    
    let containerView = UIView()
    let segmentedControlView = BaseSegmentControl(padding: nil, title: ["Venue" , "About us"])
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews(segmentedControlView, containerView)
        segmentedControlView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        containerView.anchor(top: segmentedControlView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
