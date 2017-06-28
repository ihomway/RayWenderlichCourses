//
//  WeatherViewController.swift
//  MasteringAutoLayout
//
//  Created by HOMWAY on 28/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
	@IBOutlet weak var backgroundImageView: UIImageView!
	@IBOutlet weak var stackView: UIStackView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		setupImages(forTraitCollection: traitCollection)
	}

	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		super.willTransition(to: newCollection, with: coordinator)

		if newCollection.horizontalSizeClass != traitCollection.horizontalSizeClass ||
			newCollection.verticalSizeClass != traitCollection.verticalSizeClass {
			setupImages(forTraitCollection: newCollection)
		}
	}

	private func setupImages(forTraitCollection traintCollection: UITraitCollection) {
		guard stackView.arrangedSubviews.count > 1 else {
			return
		}

		let compact = traintCollection.horizontalSizeClass == .compact && traintCollection.verticalSizeClass == .compact
		for subview in stackView.arrangedSubviews.suffix(from: 1) {
			subview.isHidden = compact
		}
	}
}
