//
//  ViewController.swift
//  OperationChallenge
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
		
		let compressedFilePath = Bundle.main.path(forResource: "sample_01_small", ofType: "compressed")
		
		// TODO: In ImageDecompressor.swift, implement the Operation subclass. Then
		// replace the following code with code that creates an ImageDecompressor operation,
		// sets its inputPath, starts it if it's ready, then sets imageView.image to the
		// operation's outputImage
		
		let decompressor = ImageDecompressor()
		decompressor.inputPath = compressedFilePath
		decompressor.start()
		
		if decompressor.isReady {
			imageView.image = decompressor.outputImage
		}
	}
}

