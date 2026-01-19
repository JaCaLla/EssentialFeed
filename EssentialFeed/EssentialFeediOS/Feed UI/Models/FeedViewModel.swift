//
//  FeedViewModel.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//


import UIKit
import EssentialFeed

final class FeedViewModel {
    typealias Observer<T> = (T) -> Void
    private let feedLoader: FeedLoader
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    // En lugar de un callback aquí podriamos utilizar RxSwift o Combine
    var onLoadingStateChange: Observer<Bool>?
    var onFeedLoad: Observer<[FeedImage]>?
    
    func loadFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
