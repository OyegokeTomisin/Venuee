//
//  BaseSegmentControl.swift
//  VenueFeediOS
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit

final internal class BaseSegmentControl: UIView {
    
    var onTap: ((Int) -> ())?
    var padding: UIEdgeInsets?
    let segmentedControl: UISegmentedControl
    
    internal init(padding: UIEdgeInsets? = nil, title: [String]) {
        self.segmentedControl = UISegmentedControl(items: title)
        self.padding = padding
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSegment(to selectedIndex: Int) {
        segmentedControl.selectedSegmentIndex = selectedIndex
        onSegmentedControlChanged(segmentedControl)
    }
    
    @objc private func onSegmentedControlChanged(_ sender: UISegmentedControl) {
        onTap?(sender.selectedSegmentIndex)
    }
    
    private func setupView() {
        addSubview(segmentedControl)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(onSegmentedControlChanged(_ :)), for: .valueChanged)
        
        segmentedControl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding?.left ?? 24).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(padding?.right ?? 24)).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
