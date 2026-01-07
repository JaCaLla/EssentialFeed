//
//  FeedImageCellTableViewCell.swift
//  Prototype
//
//  Created by JAVIER CALATRAVA LLAVERIA on 7/1/26.
//  Copyright © 2026 Essential Developer. All rights reserved.
//

import UIKit

final class FeedImageCell: UITableViewCell {
	@IBOutlet private(set) var locationContainer: UIView!
	@IBOutlet private(set) var locationLabel: UILabel!
	@IBOutlet private(set) var feedImageView: UIImageView!
	@IBOutlet private(set) var descriptionLabel: UILabel!
}
