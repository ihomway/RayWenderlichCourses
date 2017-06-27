//
//  MapViewController.swift
//  MasteringAutoLayout
//
//  Created by HOMWAY on 27/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
	
	@IBOutlet weak var desiredXConstraint: NSLayoutConstraint!
	@IBOutlet weak var desiredYConstraint: NSLayoutConstraint!
	@IBOutlet weak var marker: UIView!
	@IBOutlet weak var markerImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func decideArrowOrX() {
		// 1
		let currentPoint = marker.frame.origin
		let desiredPoint = CGPoint(x: desiredXConstraint.constant,
		                           // 2
			y: desiredYConstraint.constant)
		if currentPoint == desiredPoint {
			markerImageView.image = UIImage(named: "x")
			markerImageView.transform = CGAffineTransform.identity
		} else { // 3
			markerImageView.image = UIImage(named: "arrow")
			// 4
			let angle = angleBetween(currentPoint, desiredPoint)
			markerImageView.transform =
    CGAffineTransform(rotationAngle: angle)
		}
	}

	func angleBetween(_ firstPoint: CGPoint, _ secondPoint: CGPoint) -> CGFloat {
		let deltaX = secondPoint.x - firstPoint.x
		let deltaY = secondPoint.y - firstPoint.y
		return atan2(deltaY, deltaX)
	}
}

extension MapViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		decideArrowOrX()
	}
}
