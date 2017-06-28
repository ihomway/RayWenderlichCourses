//
//  WeatherViewController.swift
//  MasteringAutoLayout
//
//  Created by HOMWAY on 28/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
	let daysToForecast = 3
	let gap: CGFloat = 8.0
	var imageViews: [UIImageView] = []
	var containerGuide = UILayoutGuide()
	var spacerGuides: [UILayoutGuide] = []
	var imageConstraints: [NSLayoutConstraint] = []
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		containerGuide.identifier = "container"
		view.addLayoutGuide(containerGuide)
		
		for day in 0..<daysToForecast {
			let weatherImage: UIImageView
			switch day {
			case 0:
				weatherImage = UIImageView(image: #imageLiteral(resourceName: "weather-sun"))
			case 1:
				weatherImage = UIImageView(image: #imageLiteral(resourceName: "weather-windy"))
			case 2:
				weatherImage = UIImageView(image: #imageLiteral(resourceName: "weather-thunderstorm"))
			default:
				fatalError()
			}
			
			weatherImage.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(weatherImage)
			imageViews.append(weatherImage)
			
			if day > 0 {
				let spacer = UILayoutGuide()
				spacer.identifier = "spacer\(day)"
				view.addLayoutGuide(spacer)
				spacerGuides.append(spacer)
			}
		}
		
		setupImageConstraints(forSize: view.bounds.size)
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		
		setupImageConstraints(forSize: size)
	}
	
	func setupImageConstraints(forSize size: CGSize) {
		NSLayoutConstraint.deactivate(imageConstraints)
		imageConstraints.removeAll()
		
		var firstImageView: UIImageView?
		var firstSpacer: UILayoutGuide?
		var previousAnchor = containerGuide.leadingAnchor
		
		for day in 0..<daysToForecast {
			let imageView = imageViews[day]
			imageConstraints.append(imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
			imageConstraints.append(imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor))
			
			if let firstImageView = firstImageView {
				imageConstraints.append(imageView.widthAnchor.constraint(equalTo: firstImageView.widthAnchor))
			} else {
				firstImageView = imageView
			}
			
			imageConstraints.append(imageView.leadingAnchor.constraint(equalTo: previousAnchor))
			if day < daysToForecast - 1 {
				let trailingSpacer = spacerGuides[day]
				imageConstraints.append(imageView.trailingAnchor.constraint(equalTo: trailingSpacer.leadingAnchor))
				if let firstSpacer = firstSpacer {
					imageConstraints.append(trailingSpacer.widthAnchor.constraint(equalTo: firstSpacer.widthAnchor))
				} else {
					firstSpacer = trailingSpacer
					let spacerWidthConstraint = trailingSpacer.widthAnchor.constraint(equalToConstant: gap)
					spacerWidthConstraint.priority = 749
					imageConstraints.append(spacerWidthConstraint)
				}
				previousAnchor = trailingSpacer.trailingAnchor
			} else {
				imageConstraints.append(imageView.trailingAnchor.constraint(equalTo: containerGuide.trailingAnchor))
				previousAnchor = imageView.trailingAnchor
			}
		}
		
		imageConstraints.append(containerGuide.centerXAnchor.constraint(equalTo: view.centerXAnchor))
		imageConstraints.append(containerGuide.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor))
		imageConstraints.append(containerGuide.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor))
		
		NSLayoutConstraint.activate(imageConstraints)
	}
	
}
