//
//  EssentialAppUIAcceptanceTests.swift
//  EssentialAppUIAcceptanceTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 8/2/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import XCTest

final class EssentialAppUIAcceptanceTests: XCTestCase {

    func test_onLaunch_displayRemoteFeedWhenCustomerHasConnectivity() throws {
        let app = XCUIApplication()
        
        app.launch()
        let feedCells = app.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(app.cells.count, 22)
        
        let firstImage = app.images.matching(identifier: "feed-image-view").firstMatch
        
        XCTAssertEqual(firstImage.images.count, 1)
        
    }
}
