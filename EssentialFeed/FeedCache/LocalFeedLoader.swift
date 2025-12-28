//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 25/12/25.
//
import Foundation

public final class LocalFeedLoader {
    
    public typealias SaveResult = Error?
    public typealias LoadResult = LoadFeedResult
    
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed { [weak self] cacheDeletionError in
            guard let self else { return }
            if let cacheDeletionError {
                completion(cacheDeletionError)
            } else {
                self.cache(feed, completion: completion)
            }
        }
    }
    
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { result  in
            switch result {
            case let .found(feed, _):
                completion(.success(feed.toModels()))
            case let .failure(error):
                completion(.failure(error))
            case .empty:
                completion(.success([]))
            }
        }
    }
    
    private func cache(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        store.insert(feed.toLocal(), timestamp: self.currentDate(), completion: { [weak self] error in
            guard self != nil else { return }
            completion(error)
        } )
    }
}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        self.map {
            LocalFeedImage(id: $0.id,
                           description: $0.description,
                           location: $0.location,
                           imageURL: $0.imageURL)
        }
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        self.map {
            FeedImage(id: $0.id,
                           description: $0.description,
                           location: $0.location,
                           imageURL: $0.imageURL)
        }
    }
}
