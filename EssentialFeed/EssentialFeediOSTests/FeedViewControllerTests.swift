//
//  EssentialFeediOSTests.swift
//  EssentialFeediOSTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 9/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import XCTest
@testable import EssentialFeediOS

final class FeedViewController {
    init (loader: FeedViewControllerTests.LoaderSpy) {
        
    }
}

final class FeedViewControllerTests: XCTestCase {
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallcount, 0)
    }
    
    class LoaderSpy {
        private(set) var loadCallcount: Int = 0
        
        
    }

}
