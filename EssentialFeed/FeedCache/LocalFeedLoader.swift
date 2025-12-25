//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 25/12/25.
//
import Foundation

public final class LocalFeedLoader {
    
    public typealias SaveResult = Error?
    
    private let store: FeedStore
    private let currentDate: () -> Date

    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }

    public func save(_ items: [FeedItem], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed { [weak self] cacheDeletionError in
            guard let self else { return }
            if let cacheDeletionError {
                completion(cacheDeletionError)
            } else {
                self.cache(items, completion: completion)
            }
        }
    }
    
    private func cache(_ items: [FeedItem], completion: @escaping (SaveResult) -> Void) {
        store.insert(items, timestamp: self.currentDate(), completion: { [weak self] error in
            guard self != nil else { return }
            completion(error)
        } )
    }
}
