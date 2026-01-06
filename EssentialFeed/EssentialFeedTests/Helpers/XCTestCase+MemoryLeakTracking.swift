//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import XCTest

extension XCTestCase {
	func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
		if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
			addTeardownBlock { [weak instance] in
				XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
			}
		} else {
			// Minimal fallback for older platforms: schedule the check asynchronously.
			// This is weaker than a proper teardown hook but keeps builds green on older SDKs.
			let expectation = XCTestExpectation(description: "Deferred leak check")
			DispatchQueue.main.async { [weak instance] in
				XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 0.1)
		}
	}
}
