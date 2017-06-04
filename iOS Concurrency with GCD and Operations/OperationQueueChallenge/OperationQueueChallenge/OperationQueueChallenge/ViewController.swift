//
//  ViewController.swift
//  OperationQueueChallenge
//
//  Created by Homway on 04/06/2017.
//  Copyright © 2017 cc.ihomway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imageView0: UIImageView!
	@IBOutlet weak var imageView1: UIImageView!
	@IBOutlet weak var imageView2: UIImageView!
	
	let compressedFilePaths = ["01", "02", "03"].map {
		Bundle.main.path(forResource: "sample_\($0)_small", ofType: "compressed")
	}
	
	var operations = [ImageDecompressor]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// TODO: Use the ImageDecompressor Operation subclass in an OperationQueue
		// to decompress the files whose paths are in compressedFilePaths.
		
		for compressedFile in compressedFilePaths {
			// TODO: create an ImageDecompressor operation and add it to the operations array
			
			let imageDecompressor = ImageDecompressor()
			imageDecompressor.inputPath = compressedFile
			
			operations.append(imageDecompressor)
		}
		
		// TODO: Create an OperationQueue and use its addOperations method.
		// Wrap these statements in a global async so you can set waitUntilFinished to true.
		// Dispatch back to the main queue to set the imageViews' images.
		
		DispatchQueue.global().async {
			let decompressorQueue = OperationQueue()
			decompressorQueue.addOperations(self.operations, waitUntilFinished: true)
			
			DispatchQueue.main.async {
				self.imageView0.image = self.operations[0].outputImage
				self.imageView1.image = self.operations[1].outputImage
				self.imageView2.image = self.operations[2].outputImage
			}
		}
	}

}

