//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
//import EssentialFeed

public protocol FeedImageDataLoaderTask {
	func cancel()
}



final public class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {
    var refreshController: FeedRefreshViewController?
//	private var imageLoader: FeedImageDataLoader?
    var tableModel = [FeedImageCellController]() {
        didSet { tableView.reloadData() }
    }
 //   var cellControllers = [IndexPath: FeedImageCellController]()

    convenience init(refreshController: FeedRefreshViewController) {
        self.init()
        self.refreshController = refreshController
    }
    
	public override func viewDidLoad() {
		super.viewDidLoad()
		
        refreshControl = refreshController?.view

		tableView.prefetchDataSource = self
        refreshController?.refresh()
	}
	
	public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableModel.count
	}
	    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(indexPath).view()
	}
	
	public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
	}
	
	public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach { indexPath in
            _ = cellController(indexPath).preload()
		}
	}
	
	public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach(cancelCellControllerLoad)
	}
	
	private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        cellController(indexPath).cancelLoad()
	}
    
    private func cellController(_ indexPath: IndexPath) -> FeedImageCellController {
        tableModel[indexPath.row]
    }
}
