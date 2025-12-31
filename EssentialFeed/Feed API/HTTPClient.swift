//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 12/12/25.
//
import Foundation

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropiate threads, if needed.
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

