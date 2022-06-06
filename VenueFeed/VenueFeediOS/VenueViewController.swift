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
        setUpLayout()
        setUpOnLoad()
        loadVenue()
    }
    
    private func setUpLayout() {
        view.addSubview(layout)
        view.backgroundColor = .white
        layout.fillSuperview()
    }
    
    private func setUpOnLoad() {
        layout.venuItemTableView.delegate = self
        layout.venuItemTableView.dataSource = self
        layout.pullToRefresh.addTarget(self, action: #selector(loadVenue), for: .valueChanged)
        layout.venuItemTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.viewIdentifier)
        
        viewModel.reloadData = { [weak self] in
            self?.reloadTableData()
        }
        
        viewModel.alertErrorMessage = { [weak self] message in
            self?.showErrorMessage(message: message)
        }
    }
    
    @objc private func loadVenue() {
        layout.pullToRefresh.beginRefreshing()
        viewModel.fetchNearestVenue()
    }
    
    private func reloadTableData() {
        layout.pullToRefresh.endRefreshing()
        layout.venuItemTableView.reloadData()
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
