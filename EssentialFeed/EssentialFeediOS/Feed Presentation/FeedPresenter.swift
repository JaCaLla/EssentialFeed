//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by JAVIER CALATRAVA LLAVERIA on 20/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import Foundation
import EssentialFeed

struct FeedLoaderViewModel {
   let isLoading: Bool
}

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoaderViewModel)
}

struct FeedViewModel {
    let feed: [FeedImage]
}

protocol FeedView {
    func display(_ viewModel: FeedViewModel)
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
        loaindingView?.display(FeedLoaderViewModel(isLoading: true))
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.feedView?.display(FeedViewModel(feed: feed))
            }
            self?.loaindingView?.display(FeedLoaderViewModel(isLoading: true))
        }
    }
}
