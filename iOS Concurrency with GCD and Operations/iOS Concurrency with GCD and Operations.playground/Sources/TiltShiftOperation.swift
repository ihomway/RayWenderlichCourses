import Foundation
import UIKit

public class TiltShiftOperation: Operation {
	public var inputImage: UIImage?
	public var outputImage: UIImage?
	
	override public func main() {
		outputImage = tiltShift(image: inputImage)
	}
}
