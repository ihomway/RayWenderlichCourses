//
//  ViewController.swift
//  MasteringAutoLayout
//
//  Created by HOMWAY on 27/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	 @IBOutlet var buttonStackView: UIStackView!
	var weatherViewController: WeatherViewController?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		if traitCollection.horizontalSizeClass == .regular {
			setupWeatherView()
			weatherViewController?.view.isHidden = false
		}
	}

	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		super.willTransition(to: newCollection, with: coordinator)

		if newCollection.horizontalSizeClass == .regular, newCollection.horizontalSizeClass != traitCollection.horizontalSizeClass {
			setupWeatherView()
		} else if newCollection.horizontalSizeClass == .compact {
			removeWeatherView()
		}

		coordinator.animate(alongsideTransition: nil) { (context) in
			self.weatherViewController?.view.isHidden = false
		}
	}

	private func setupWeatherView() {
		guard let storyboard = storyboard else {
			return
		}
		guard let weatherViewController = storyboard.instantiateViewController(withIdentifier: String(describing: WeatherViewController.self)) as? WeatherViewController else {
			return
		}

		weatherViewController.view.translatesAutoresizingMaskIntoConstraints = false
		weatherViewController.willMove(toParentViewController: self)
		weatherViewController.view.isHidden = true

		weatherViewController.backgroundImageView.isHidden = true
		view.addSubview(weatherViewController.view)

		weatherViewController.view.centerYAnchor.constraint(equalTo: buttonStackView.centerYAnchor).isActive = true
		weatherViewController.view.leadingAnchor.constraint(equalTo: buttonStackView.trailingAnchor, constant: 100).isActive = true
		addChildViewController(weatherViewController)

		let horizontallyCompact = UITraitCollection(horizontalSizeClass: .compact)
		let verticallyCompact = UITraitCollection(verticalSizeClass: .compact)
		let compact = UITraitCollection(traitsFrom: [horizontallyCompact, verticallyCompact])
		setOverrideTraitCollection(compact, forChildViewController: weatherViewController)

		self.weatherViewController = weatherViewController
	}

	private func removeWeatherView() {
		guard let weatherViewController = weatherViewController else {
			return
		}

		weatherViewController.willMove(toParentViewController: nil)
		weatherViewController.view.removeFromSuperview()
		weatherViewController.removeFromParentViewController()
		self.weatherViewController = nil
	}

}

