//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed
import EssentialFeediOS
import Foundation
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//		guard let _ = (scene as? UIWindowScene) else { return }
//        
//        let remoteURL = URL(string: "https://any-url.com/rss")!
//        let remoteClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
//        let remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: remoteClient)
//        let remoteImageLoader = RemoteFeedImageDataLoader(client: remoteClient)
//        
//        let localStoreURL = NSPersistentContainer
//            .defaultDirectoryURL()
//            .appendingPathComponent("Feed.sqlite")
//        
//        let feedViewController = FeedUIComposer.feedComposedWith(
//            feedLoader: remoteFeedLoader,
//            imageLoader: remoteImageLoader)
//        
//        let localStore = try! CoreDataFeedStore(storeURL: localStoreURL)
//        let localFeedLoader = LocalFeedLoader(store: localStore, currentDate: Date.init)
//        let localImageLoader = LocalFeedImageDataLoader(store: localStore)
//        
//        window?.rootViewController = FeedUIComposer.feedComposedWith(
//            feedLoader: FeedLoaderWithFallbackComposite(
//                primary: FeedLoaderCacheDecorator(
//                    decoratee: remoteFeedLoader,
//                    cache: localFeedLoader
//                ),
//                fallback: localFeedLoader),
//            imageLoader: FeedImageDataLoaderWithFallbackComposite(
//                primary: localImageLoader,
//                fallback: remoteImageLoader))
	}
}

