//
//  FeedViewControllerTests+Localization.swift
//  EssentialFeediOSTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 23/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//
import Foundation
import XCTest
import EssentialFeediOS

extension FeedUIIntegrationTests {
    func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedViewController.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file:file, line:line)
        }
        return value
    }
}
