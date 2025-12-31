//
//  CodableFeedStore.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 30/12/25.
//
import Foundation

public final class CodableFeedStore: FeedStore {
    
    private struct Cache: Codable {
        let feed: [CodableFeedImage]
        let timestamp: Date
        
        var localFeed: [LocalFeedImage] {
            return feed.map { $0.local }
        }
    }
    
    private struct CodableFeedImage: Codable {
        private let id: UUID
        private let description: String?
        private let location: String?
        private let imageURL: URL
        
        var local: LocalFeedImage {
            return LocalFeedImage(
                id: id,
                description: description,
                location: location,
                imageURL:  imageURL
            )
        }
        
        init(_ localFeedImage : LocalFeedImage) {
            self.id = localFeedImage.id
            self.description = localFeedImage.description
            self.location = localFeedImage.location
            self.imageURL = localFeedImage.imageURL
        }
    }
    private let queue = DispatchQueue(label: "\(CodableFeedImage.self)Queue", qos: .userInitiated, attributes: .concurrent)
    private let storeURL: URL
    public init(storeURL: URL) {
        self.storeURL = storeURL
    }
    
    public func retrieve(completion: @escaping RetreivalCompletion) {
        let storeURL = self.storeURL
        queue.async {
            guard let data = try? Data(NSData(contentsOf: storeURL)) else {
                return completion(.empty)
            }
            do {
                let decoder = JSONDecoder()
                let cache = try decoder.decode(Cache.self, from: data)
                completion(.found(feed: cache.localFeed, timestamp: cache.timestamp))
            } catch {
                completion(.failure(error: error))
            }
        }
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        let storeURL = self.storeURL
        queue.async(flags: .barrier) {
            do {
                let encoder = JSONEncoder()
                let cache = Cache(feed: feed.map(CodableFeedImage.init) , timestamp: timestamp)
                let encoded = try encoder.encode(cache)
                try encoded.write(to: storeURL)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    public func deleteCachedFeed(completion: @escaping FeedStore.DeletionCompletion) {
        let storeURL = self.storeURL
        queue.async(flags: .barrier) {
            guard FileManager.default.fileExists(atPath: storeURL.path) else {
                return completion(nil)
            }
        
            do {
                try FileManager.default.removeItem(at: storeURL)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
}
