//
//  ViewController.swift
//  CustomScrollView
//
//  Created by HOMWAY on 30/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var imageView: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
//		scrollView.contentSize = imageView.image!.size
		imageView.frame.size = (imageView.image?.size)!
		setZoomParametersForSize(scrollView.frame.size)
	}
	
	func setZoomParametersForSize(_ scrollViewSize: CGSize) {
		let imageSize = imageView.bounds.size
		let widthScale = scrollViewSize.width / imageSize.width
		let heightScale = scrollViewSize.height / imageSize.height
		let minScale = min(widthScale, heightScale)
		
		scrollView.minimumZoomScale = minScale
		scrollView.maximumZoomScale = 3.0
		scrollView.zoomScale = minScale
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewDidLayoutSubviews() {
		setZoomParametersForSize(scrollView.frame.size)
	}

}

extension ViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
