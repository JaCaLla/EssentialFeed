//
//  FeedCacheHelpers.swift
//  EssentialFeedTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 29/12/25.
//
import EssentialFeed
import Foundation

internal func uniqueImageFeed() -> (models: [FeedImage], local:[LocalFeedImage] ) {
    let items = [uniqueImage(), uniqueImage()]
    let localItems = items.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.imageURL) }
    return (items, localItems)
}

internal func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(), description: "any", location: "any", imageURL: anyURL())
}

extension Date {
    
    func minusFeedCacheMaxAge() -> Date {
        adding(days: -feedCcheMaxAgeInDays)
    }
    
    private var feedCcheMaxAgeInDays: Int { 7 }
    
    private func adding(days: Int) -> Date {
        Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
}

extension Date {
    func adding(seconds: TimeInterval) -> Date {
        self + seconds
    }
}
