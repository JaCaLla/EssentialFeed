//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 28/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//


import Foundation

public struct FeedErrorViewModel {
    public let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}