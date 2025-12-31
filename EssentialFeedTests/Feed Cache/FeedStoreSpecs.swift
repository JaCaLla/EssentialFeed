//
//  FeedStoreSpecs.swift
//  EssentialFeed
//
//  Created by JAVIER CALATRAVA LLAVERIA on 31/12/25.
//


protocol FeedStoreSpecs {

     func test_retrieve_deliversEmptyOnEmptyCache()
     func test_retrieve_hasNoSideEffectsOnEmptyCache()
     func test_retrieve_deliversFoundValueOnNonEmptyCache()
     func test_retrieve_hasNoSideEffectsOnNonEmptyCache()

     func test_insert_overridesPreviouslyInsertedCacheValues()

     func test_delete_hasNoSideEffectsOnEmptyCache()
     func test_delete_emptiesPreviouslyInsertedCache()

     func test_storiesSideEffects_runSerially()
}

protocol FailableRetrieveFeedStoreSpecs: FeedStoreSpecs {
    func test_retrieve_deliversFailureOnRetreivalError()
    func test_retrieve_hasNoSideEffectsOnFailure()
}

protocol FailableInsertFeedStoreSpecs: FeedStoreSpecs {
    func test_insert_deliversErrorOnInsertionError()
    func test_insert_hasNoSideEffectsOnInsertionError()
}

protocol FailableDeleteFeedStoreSpecs: FeedStoreSpecs {
    func test_delete_deliversErrorOnDeletionError()
}