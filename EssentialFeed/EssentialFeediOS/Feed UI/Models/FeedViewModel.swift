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
    private let feedLoader: FeedLoader
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    // En lugar de un callback aquí podriamos utilizar RxSwift o Combine
    var onChange: ((FeedViewModel)-> Void)?
    var onFeedLoad: (([FeedImage])-> Void)?
    
    private(set) var isLoading: Bool = false {
        didSet { onChange?(self) }
    }
    
    func loadFeed() {
        isLoading = true
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.isLoading = false
        }
    }
}
