//
//  ImageDecompressor.swift
//  OperationChallenge
//
//  Created by Homway on 04/06/2017.
//  Copyright © 2017 cc.ihomway. All rights reserved.
//

import Foundation
import UIKit


// TODO: Implement this operation to decompress the file at inputPath: String?
// into the outputImage: UIImage?
class ImageDecompressor: Operation {
	
	var inputPath: String?
	var outputImage: UIImage?
	
	override func main() {
		
		guard let filePath = inputPath else { return }
		if let decompressedData = Compressor.loadCompressedFile(filePath) {
			outputImage = UIImage(data: decompressedData)
		}
	}
	
}
