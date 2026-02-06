//
//  FeedLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 5/2/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//
import EssentialFeed
import XCTest

final class FeedLoaderCacheDecorator: FeedLoader {
    
    let decoratee: FeedLoader
    
    init(decoratee: FeedLoader) {
        self.decoratee = decoratee
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load(completion: completion)
    }
}

final class FeedLoaderCacheDecoratorTests:XCTestCase, FeedLoaderTestCase {
    
    func test_load_deliversFeedOnLoaderSuccess() {
        let feed = uniqueFeed()
        let loader = FeedLoaderStub(result: .success(feed))
        let sut = FeedLoaderCacheDecorator(decoratee: loader)
        
        expect(sut, toCompleteWith: .success(feed))
        
    }

    func test_load_deliversFeedOnLoaderFailure() {

        let loader = FeedLoaderStub(result: .failure(anyNSError()))
        let sut = FeedLoaderCacheDecorator(decoratee: loader)
        
        expect(sut, toCompleteWith: .failure(anyNSError()))
        
    }
    
    
    // MARK: - Helper
}
