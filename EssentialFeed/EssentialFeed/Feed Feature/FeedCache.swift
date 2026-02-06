//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 6/2/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void )
}
