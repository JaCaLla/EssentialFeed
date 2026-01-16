//
//  FeedUIComposer.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 16/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//


import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let refreshController = FeedRefreshViewController(feedLoader: feedLoader)
        let feedController = FeedViewController(refreshController: refreshController)
        feedController.refreshController?.onRefresh = { [weak feedController] feed in
            feedController?.tableModel = feed.map { model in
                    FeedImageCellController(model: model, imageLoader: imageLoader)
            }
        }
        return feedController
    }
}
