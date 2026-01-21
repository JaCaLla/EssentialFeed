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
   // typealias Observer<T> = (T) -> Void

    
    private let feedView: FeedView
    private let  loaindingView: FeedLoadingView
    init(feedView: FeedView, loaindingView: FeedLoadingView) {
        self.feedView = feedView
        self.loaindingView = loaindingView
    }
    
    func didStartLoadingFeed() {
        loaindingView.display(FeedLoaderViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loaindingView.display(FeedLoaderViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        loaindingView.display(FeedLoaderViewModel(isLoading: false))
    }
}
