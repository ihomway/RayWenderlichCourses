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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
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
		}
		
		for imageView in imageViews {
			imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
		}
		
		var constraints = [NSLayoutConstraint]()
		let leftGap = UILayoutGuide()
		view.addLayoutGuide(leftGap)
		let rightGap = UILayoutGuide()
		view.addLayoutGuide(rightGap)
		
		let imageWidth = imageViews[0].image!.size.width
		let views: [String: Any] = ["monday": imageViews[0], "tuesday": imageViews[1], "wednesday": imageViews[2], "leftGap": leftGap, "rightGap": rightGap]
		let metrics = ["fullWidth": imageWidth, "smaller": imageWidth * 0.7, "bigGap": gap * 3, "gap": gap]
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[leftGap]-[monday(fullWidth@849)]-(bigGap)-[tuesday(smaller@849)]-(gap)-[wednesday(smaller@849)]-(gap)-[rightGap(==leftGap)]|", options: .alignAllCenterY, metrics: metrics, views: views))
		constraints.append(imageViews[0].centerYAnchor.constraint(equalTo: view.centerYAnchor))
		NSLayoutConstraint.activate(constraints)
	}
}
