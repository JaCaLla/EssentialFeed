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
        let view = ViewSpy()
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    private  class ViewSpy {
        var messages = [Any]()
    }
}
