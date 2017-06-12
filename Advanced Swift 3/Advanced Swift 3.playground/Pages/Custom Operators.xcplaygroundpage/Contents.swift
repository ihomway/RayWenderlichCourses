//: [Previous](@previous)

import UIKit

extension CGPoint {
	static func *(lhs: CGPoint, rhs: CGAffineTransform) -> CGPoint {
		return lhs.applying(rhs)
	}
}

extension CGAffineTransform {
	static func *(lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
		return lhs.concatenating(rhs)
	}
}

func *(points: [CGPoint], transform: CGAffineTransform) -> [CGPoint] {
	return points.map{$0 * transform}
}


// Visualization test code


import PlaygroundSupport


extension UIBezierPath {
convenience init(from points: [CGPoint]) {
self.init()
guard let first = points.first else {
return
}
move(to: first)
for point in points.dropFirst() {
addLine(to: point)
}
close()
}
}

// Using the point class.
let points: [CGPoint] = [
CGPoint(x: -1, y: -1),
CGPoint(x:  1, y: -1),
CGPoint(x:  1, y:  1),
CGPoint(x:  0, y:  2),
CGPoint(x: -1, y:  1)]

let modelToScale = CGAffineTransform(scaleX: 30, y: 30)
let scaleToRotated = CGAffineTransform(rotationAngle: .pi/8)
let rotatedToTranslated = CGAffineTransform(translationX: 100, y: 100)

let scaledRotatedAndTranslated = points * modelToScale * scaleToRotated * rotatedToTranslated

let path = UIBezierPath(from: scaledRotatedAndTranslated)

let layer = CAShapeLayer()
layer.path = path.cgPath
layer.strokeColor = UIColor.cyan.cgColor

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.layer.addSublayer(layer)
PlaygroundPage.current.liveView = view

infix operator !!: NilCoalescingPrecedence

func !!<Wrapped>(optional: Wrapped?, fatal:@autoclosure() -> Never) -> Wrapped {
	guard let unwrapped = optional else {
		fatal()
	}
	
	return unwrapped
}

var emptyValue: Int? = nil
var fullValue: Int? = 10

 let value = fullValue !! fatalError("no value when one was expected")


precedencegroup ExponentiationPrecedence {
	higherThan: MultiplicationPrecedence
	associativity: none
}

infix operator **: ExponentiationPrecedence
func **(base: Double, exponent: Double) -> Double {
	return pow(base, exponent)
}

4 ** 2

//: [Next](@next)
