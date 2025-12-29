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
        expect(sut, toCompleteWithResult: .failure(retreivalError)) {
            store.completeRetreival(with: retreivalError)
        }
    }
    
    func test_load_deliversNoImagesOnEmptyCache() {
        let (sut, store) = makeSUT()
        
        expect(sut, toCompleteWithResult: .success([])) {
            store.completeRetreivalWithEmptyCache()
        }
    }
    
    func test_load_deliversCachedImagesOnLessThanSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let lessThanSevenDaysOldTimestamp = fixedCurrentDate.adding(days: -7).adding(seconds: +1)
        let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
        expect(sut, toCompleteWithResult: .success(feed.models)) {
            store.completeRetreival(with: feed.local, timestamp: lessThanSevenDaysOldTimestamp)
        }
    }
    
    func test_load_deliversNoImagesOnSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let sevenDaysOldTimestamp = fixedCurrentDate.adding(days: -7)
        let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
        expect(sut, toCompleteWithResult: .success([])) {
            store.completeRetreival(with: feed.local, timestamp: sevenDaysOldTimestamp)
        }
    }
    
    func test_load_deliversNoImagesOnMoreHanSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let moreThanSevenDaysOldTimestamp = fixedCurrentDate.adding(days: -7).adding(seconds: -1)
        let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
        expect(sut, toCompleteWithResult: .success([])) {
            store.completeRetreival(with: feed.local, timestamp: moreThanSevenDaysOldTimestamp)
        }
    }
    
    func test_load_deletesCacheOnRetreivalError() {
        let (sut, store) = makeSUT()
        sut.load { _ in }
        store.completeRetreival(with: anyNSError())
        
        XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
    }
    
    func test_load_DoesNotDeleteCacheOnEmptyCache() {
        let (sut, store) = makeSUT()
        sut.load { _ in }
        store.completeRetreivalWithEmptyCache()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_DoesNotDeleteCacheOnLessThanSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let lessThanSevenDaysOldTimestamp = fixedCurrentDate.adding(days: -7).adding(seconds: +1)
        let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
        
        sut.load { _ in }
        store.completeRetreival(with: feed.local, timestamp: lessThanSevenDaysOldTimestamp)
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    
    // MARK: - Helpers

    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalFeedLoader, toCompleteWithResult expectedResult: LocalFeedLoader.LoadResult, when action: () -> Void, file: StaticString = #file, line: UInt = #line ) {
        let exp = expectation(description: "Wait for load completion")
        sut.load() { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedImages), .success( expectedImages)):
                XCTAssertEqual(receivedImages, expectedImages, file: file, line: line)
            case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expedted result \(expectedResult), received \(receivedResult)", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1.0 )
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    private func uniqueImageFeed() -> (models: [FeedImage], local:[LocalFeedImage] ) {
        let items = [uniqueImage(), uniqueImage()]
        let localItems = items.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.imageURL) }
        return (items, localItems)
    }
    
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    private func uniqueImage() -> FeedImage {
        return FeedImage(id: UUID(), description: "any", location: "any", imageURL: anyURL())
    }
}

private extension Date {
    func adding(days: Int) -> Date {
        Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: TimeInterval) -> Date {
        self + seconds
    }
}
