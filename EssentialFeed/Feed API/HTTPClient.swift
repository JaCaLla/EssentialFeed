//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 12/12/25.
//
import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

