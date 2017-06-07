//
//  PhotoOperations.swift
//  ClassicPhotos
//
//  Created by HOMWAY on 07/06/2017.
//  Copyright © 2017 raywenderlich. All rights reserved.
//

import UIKit

enum PhotoRecordState {
	case New, Downloaded, Filtered, Failed
}

class PhotoRecord {
	let name: String
	let url: URL
	var state = PhotoRecordState.New
	var image = UIImage(named: "Placeholder")
	
	init(name: String, url: URL) {
		self.name = name
		self.url = url
	}
}

class PendingOperations {
	lazy var downloadInProgress = [IndexPath: Operation]()
	lazy var downloadQueue: OperationQueue = {
		var queue = OperationQueue()
		queue.name = "Download queue"
		queue.maxConcurrentOperationCount = 1
		return queue
	}()
	
	lazy var filtrationsInProgress = [IndexPath: Operation]()
	lazy var filtrationQueue: OperationQueue = {
		var queue = OperationQueue()
		queue.name = "Image Filtration queue"
		queue.maxConcurrentOperationCount = 1
		return queue
	}()
}

class ImageDownloader: Operation {
	let photoRecord: PhotoRecord
	
	init(photoRecord: PhotoRecord) {
		self.photoRecord = photoRecord
	}
	
	override func main() {
		if self.isCancelled { return }
		let imageData = try? Data(contentsOf: photoRecord.url)
		
		if self.isCancelled { return }
		
		if let imageData = imageData {
			photoRecord.image = UIImage(data: imageData)
			photoRecord.state = .Downloaded
		}
		else
		{
			photoRecord.state = .Failed
			photoRecord.image = UIImage(named: "Failed")
		}
	}
}


class ImageFiltration: Operation {
	let photoRecord: PhotoRecord
	
	init(photoRecord: PhotoRecord) {
		self.photoRecord = photoRecord
	}
	
	override func main() {
		if self.isCancelled { return }
		
		if photoRecord.state != .Downloaded { return }
		
		if let filteredImage = applySepiaFilter(photoRecord.image!) {
			photoRecord.image = filteredImage
			photoRecord.state = .Filtered
		}
	}
	
	func applySepiaFilter(_ image:UIImage) -> UIImage? {
		let inputImage = CIImage(data:UIImagePNGRepresentation(image)!)
		
		if self.isCancelled{ return nil}
		
		let context = CIContext(options:nil)
		let filter = CIFilter(name:"CISepiaTone")
		filter?.setValue(inputImage, forKey: kCIInputImageKey)
		filter?.setValue(0.8, forKey: "inputIntensity")
		if let outputImage = filter?.outputImage {
			
			if self.isCancelled{ return nil}
			let outImage = context.createCGImage(outputImage, from: outputImage.extent)
			return UIImage(cgImage: outImage!)
		}
		
		return nil
	}
}










































