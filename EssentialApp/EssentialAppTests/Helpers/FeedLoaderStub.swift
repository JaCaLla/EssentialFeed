//
//  FeedLoaderStub.swift
//  EssentialApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 5/2/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import EssentialFeed

    class FeedLoaderStub: FeedLoader {
        private let result: FeedLoader.Result
        
        init(result: FeedLoader.Result) {
            self.result = result
        }

        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            completion(result)
        }
    }
