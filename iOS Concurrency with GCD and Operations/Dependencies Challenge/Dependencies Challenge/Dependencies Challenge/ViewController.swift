//
//  ViewController.swift
//  Dependencies Challenge
//
//  Created by Homway on 04/06/2017.
//  Copyright © 2017 cc.ihomway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		guard let dataUrl = Bundle.main.url(forResource: "sample_03_small", withExtension: "compressed") else { return }
		
		// NOTE: There is also a TODO in DataLoadOperation.swift
		
		let dataLoad = DataLoadOperation(url: dataUrl)
		let decompressor = ImageDecompressionOperation()
		let filter = TiltShiftOperation()
		filter.completionBlock = {
			
			DispatchQueue.main.async {
				self.imageView.image = filter.outputImage
			}
		}
		
		// TODO: Add the appropriate dependencies
		filter.addDependency(decompressor)
		decompressor.addDependency(dataLoad)
		
		let queue = OperationQueue()
		queue.addOperations([dataLoad, decompressor, filter], waitUntilFinished: false)
	}


}

