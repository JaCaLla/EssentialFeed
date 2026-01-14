//
//  FeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 14/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//


import UIKit
import EssentialFeed

public protocol FeedImageDataLoader {
	typealias Result = Swift.Result<Data, Error>

	func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}