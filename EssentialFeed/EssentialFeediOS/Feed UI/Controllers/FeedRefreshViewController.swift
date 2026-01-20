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
    
    private let presenter: FeedPresenter
    init(presenter: FeedPresenter) {
        self.presenter = presenter
    }
    
    @objc public func refresh() {
        presenter.loadFeed()
    }
    
    fileprivate func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
    // MARK: - FeedLoadingView
    func display(isLoading: Bool) {
        if isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
}
