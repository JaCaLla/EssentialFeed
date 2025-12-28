//
//  LoadFeedFromCacheUseCase.swift
//  EssentialFeedTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 28/12/25.
//
import EssentialFeed
import XCTest

final class LoadFeedFromCacheUseCase: XCTestCase {

    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()

        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_load_requestCacheRetreival() {
        let (sut, store) = makeSUT()

        sut.load { _ in }
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_failsOnRetreivalError() {
        let (sut, store) = makeSUT()
        let retreivalError = anyNSError()
        let exp = expectation(description: "Wait for load completion")
        var receivedError: Error?
        sut.load() { error in
            receivedError = error
            exp.fulfill()
        }
        store.completeRetreival(with: retreivalError)
        wait(for: [exp], timeout: 1.0 )
        XCTAssertEqual(receivedError as NSError?, retreivalError)
    }
    
    // MARK: - Helpers

    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}
