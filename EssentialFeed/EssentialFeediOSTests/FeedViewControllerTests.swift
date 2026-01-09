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
        _ = makeSUT()
        
        XCTAssertEqual(loader.loadCallcount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadCallcount, 1)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    class LoaderSpy: FeedLoader {
        private(set) var loadCallcount: Int = 0
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            loadCallcount += 1
        }
    }

}
