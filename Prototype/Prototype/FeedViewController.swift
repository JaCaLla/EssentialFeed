//
//  FeedViewController.swift
//  Prototype
//
//  Created by JAVIER CALATRAVA LLAVERIA on 7/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import UIKit

struct FeedImageViewModel {
	let description: String?
	let location: String?
	let imageName: String
}

final class FeedViewController: UITableViewController {
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCell(withIdentifier: "FeedImageCell")!
	}
	
}
