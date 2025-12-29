//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 29/12/25.
//

import Foundation

internal func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

internal func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
