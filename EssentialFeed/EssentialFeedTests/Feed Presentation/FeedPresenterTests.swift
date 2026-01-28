//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 27/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import XCTest

final class FeedPresenter {
    init(view: Any) {
        
    }
}

final class FeedPresenterTests: XCTestCase {


    func test_init_doesNotSendMessagestoView() throws {
        let (_,view) = makeSUT()
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    // MARK: - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedPresenter, view: ViewSpy){
        let view = ViewSpy()
        let sut = FeedPresenter(view: view)
        trackForMemoryLeaks(view,file: file, line: line)
        trackForMemoryLeaks(sut,file: file, line: line)
        return (sut, view)
    }
    private  class ViewSpy {
        var messages = [Any]()
    }
}
