//
//  FeedRefreshViewController.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 13/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//


import UIKit
//import EssentialFeed

final class FeedRefreshViewController: NSObject, FeedLoadingView {
        
    private(set) lazy var view: UIRefreshControl = loadView()
    
    private let loadFeed: () -> Void
    init(loadFeed: @escaping () -> Void) {
        self.loadFeed = loadFeed
    }
    
    @objc public func refresh() {
        loadFeed()
    }
    
    fileprivate func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
    // MARK: - FeedLoadingView
    func display(_ viewModel: FeedLoaderViewModel) {
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
}
