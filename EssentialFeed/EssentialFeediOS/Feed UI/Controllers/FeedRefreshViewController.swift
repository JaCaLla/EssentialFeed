//
//  FeedRefreshViewController.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 13/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//


import UIKit
//import EssentialFeed

final class FeedRefreshViewController: NSObject {
    private(set) lazy var view: UIRefreshControl = binded(UIRefreshControl())
    
    private let viewModel: FeedViewModel
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
   // var onRefresh: (([FeedImage])-> Void)?
    @objc public func refresh() {
        viewModel.loadFeed()
    }
    
    fileprivate func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onChange = { [weak self] viewModel in
            if viewModel.isLoading {
                self?.view.beginRefreshing()
            } else {
                self?.view.endRefreshing()
            }
//            if let feed = viewModel.feed {
//                self?.onRefresh?(feed)
//            }
        }
        
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
