//
//  PostProcessImageOperation.swift
//  TiltShift
//
//  Created by HOMWAY on 05/06/2017.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

class PostProcessImageOperation: ImageFilterOperation {
	
	override func main() {
		if isCancelled { return }
		guard let inputImage = filterInput else { return }
		
		if isCancelled { return }
		filterOutput = postProcessImage(inputImage)
	}
	
}
