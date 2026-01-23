//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
//import EssentialFeed

public protocol FeedImageDataLoaderTask {
	func cancel()
}

protocol FeedViewControllerDelegate {
    func didRequestFeedRefresh()
}

final public class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching, FeedLoadingView {
    //@IBOutlet var refreshController: FeedRefreshViewController?
    var delegate: FeedViewControllerDelegate?

    var tableModel = [FeedImageCellController]() {
        didSet { tableView.reloadData() }
    }

	public override func viewDidLoad() {
		super.viewDidLoad()

		//tableView.prefetchDataSource = self
        refresh()
	}
	
	@IBAction private func refresh() {
		delegate?.didRequestFeedRefresh()
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
    
    // MARK: - FeedLoadingView
    func display(_ viewModel: FeedLoaderViewModel) {
        if viewModel.isLoading {
            refreshControl?.beginRefreshing()
        } else {
            refreshControl?.endRefreshing()
        }
    }
}
