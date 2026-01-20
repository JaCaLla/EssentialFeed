//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by JAVIER CALATRAVA LLAVERIA on 20/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import Foundation
import EssentialFeed


protocol FeedLoadingView {
    func display(isLoading: Bool)
}

protocol FeedView {
    func display(feed: [FeedImage])
}

final class FeedPresenter {
    typealias Observer<T> = (T) -> Void
    private let feedLoader: FeedLoader
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var feedView: FeedView?
    var loaindingView: FeedLoadingView?
    
    func loadFeed() {
        loaindingView?.display(isLoading: true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.feedView?.display(feed: feed)
            }
            self?.loaindingView?.display(isLoading: true)
        }
    }
}
