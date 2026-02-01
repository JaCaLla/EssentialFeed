//
//  RemoteWithLocalFallbackFeedLoaderTests.swift
//  EssentialAppTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 30/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//
import EssentialFeed
import XCTest

class FeedLoaderWithFallbackComposite: FeedLoader {
    private let remote, local: FeedLoader

    init(remote: FeedLoader, local: FeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        local.load(completion: completion)
    }
}

class FeedLoaderWithFallbackCompositeTests: XCTestCase {

    func test_load_deliversPrimaryFeedOnPrimarySuccess() {
        let primaryFeed = uniqueFeed()
        let fallbackFeed = uniqueFeed()
        let primary = LoaderStub(result: .success(primaryFeed))
        let fallback = LoaderStub(result: .success(fallbackFeed))
    
        let sut = FeedLoaderWithFallbackComposite(remote: fallback, local: primary)
        //var receivedFeed: [FeedImage]?
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case let .success(receivedFeed):
                XCTAssertEqual(receivedFeed, primaryFeed)
            case .failure:
                XCTFail("Expected successful load feed result, got \(result) instead")
            }
            exp.fulfill( )
        }
        wait(for: [exp], timeout: 1)
    }
    
    private func uniqueFeed() -> [FeedImage] {
        [FeedImage(id: UUID(), description: "any", location: "any", url: URL(string: "http://any-url.com")!)]
    }
    
    private class LoaderStub: FeedLoader {
        private let result: FeedLoader.Result
        
        init(result: FeedLoader.Result) {
            self.result = result
        }
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            completion(result)
        }
    }

}
