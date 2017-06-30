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
		recenterImage()
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

	func recenterImage() {
		let sWidth = scrollView.bounds.width
		let sHeight = scrollView.bounds.height
		let iWidth = imageView.frame.width
		let iHeight = imageView.frame.height
		
		let hSpace = sWidth > iWidth ?  (sWidth - iWidth) / 2 : 0
		let vSpace = sHeight > iHeight ?  (sHeight - iHeight) / 2 : 0
		scrollView.contentInset = UIEdgeInsetsMake(vSpace, hSpace, vSpace, hSpace)
	}

	override func viewDidLayoutSubviews() {
		setZoomParametersForSize(scrollView.frame.size)
		recenterImage()
	}

}

extension ViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
