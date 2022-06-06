//
//  VenueViewController.swift
//  VenueFeediOS
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit
import VenueFeed

public final class VenueViewController: UIViewController {
    
    private let viewModel: VenueFeedViewModel
    private let layout = VenueLayout()
    
    public init(viewModel: VenueFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpOnLoad()
        viewModel.fetchNearestVenue()
        viewModel.reloadData = { [weak self] in
            self?.layout.venuItemTableView.reloadData()
        }
    }
    
    func setUpOnLoad() {
        view.addSubview(layout)
        view.backgroundColor = .white
        layout.fillSuperview()
        
        layout.venuItemTableView.delegate = self
        layout.venuItemTableView.dataSource = self
        layout.venuItemTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.viewIdentifier)
    }
}

extension VenueViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.venueItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.viewIdentifier) else { fatalError() }
        cell.textLabel?.text = viewModel.venueItems[indexPath.item].name
        cell.detailTextLabel?.text = viewModel.venueItems[indexPath.item].address
        return cell
    }
}
