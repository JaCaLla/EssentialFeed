//
//  FeedRefreshViewController.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 13/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//


import UIKit

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshViewController: NSObject, FeedLoadingView {
        
    @IBOutlet private var view: UIRefreshControl?
    
    var delegate: FeedRefreshViewControllerDelegate?
    
    @IBAction public func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
//    fileprivate func loadView() -> UIRefreshControl {
//        let view = UIRefreshControl()
//        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        return view
//    }
    
    // MARK: - FeedLoadingView
    func display(_ viewModel: FeedLoaderViewModel) {
        if viewModel.isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
}
