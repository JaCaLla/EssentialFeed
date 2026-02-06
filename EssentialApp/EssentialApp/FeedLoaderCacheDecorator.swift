//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 6/2/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import EssentialFeed

public final class FeedLoaderCacheDecorator: FeedLoader {
    
    let decoratee: FeedLoader
    let cache: FeedCache
    
    public init(decoratee: FeedLoader, cache: FeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            completion(result.map { feed in
                self?.cache.save(feed) { _ in }
                return feed
            } )
        }
    }
}
