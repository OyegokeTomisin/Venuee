//
//  AboutUsViewController.swift
//  VenueFeediOS
//
//  Created by Oyegoke Oluwatomisin on 05/06/2022.
//

import UIKit
import WebKit

final public class AboutUsViewController: UIViewController {
    
    private let pageURL: URL
    private let webView = WKWebView()
    
    public init(pageURL: URL) {
        self.pageURL = pageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
        loadRequest()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadRequest()
    }
    
    private func setupOnLoad() {
        view.addSubviews(webView)
        view.backgroundColor = .white
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 5, bottom: 0, right: 5))
    }
    
    private func loadRequest() {
        let request = URLRequest(url: pageURL)
        // Show activity indicator
        webView.load(request)
    }
}

extension AboutUsViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Hide activity indicator
    }
}
