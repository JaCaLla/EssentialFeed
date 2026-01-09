//
//  EssentialFeediOSTests.swift
//
//  Created by JAVIER CALATRAVA LLAVERIA on 9/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//
import EssentialFeed
import UIKit
import XCTest

final class FeedViewController: UIViewController {
    private var loader: FeedLoader?
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader?.load() { _ in }
    }
}

final class FeedViewControllerTests: XCTestCase {
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallcount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadCallcount, 1)
    }
    
    class LoaderSpy: FeedLoader {
        private(set) var loadCallcount: Int = 0
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            loadCallcount += 1
        }
    }

}
