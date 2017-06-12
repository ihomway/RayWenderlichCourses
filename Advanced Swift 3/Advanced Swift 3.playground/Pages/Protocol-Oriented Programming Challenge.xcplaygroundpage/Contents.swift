//: [Previous](@previous)

import UIKit
import PlaygroundSupport

var str = "Hello, playground"

protocol Drawable {
	func draw(on context: CGContext)
}

protocol Geometry {
	var size: CGSize { get }
	func area() -> CGFloat
}

extension Geometry {
	func area() -> CGFloat { return size.width * size.height }
}

struct Line: Drawable {
	var lineWidth: CGFloat
	var strokeColor: UIColor
	var startPoint: CGPoint
	var endPoint: CGPoint
	
	func draw(on context: CGContext) {
		
		context.move(to: startPoint)
		context.addLine(to: endPoint)
		context.setLineWidth(lineWidth)
		context.setStrokeColor(strokeColor.cgColor)
		context.strokePath()
		
	}
}

extension Line {
	private func update(position: CGPoint, velocity: CGPoint, within boundary: CGRect) -> (newPosition: CGPoint, newVelocity: CGPoint) {
		
		var newPosition = position
		var newVelocity = velocity
		
		newPosition.x += velocity.x
		newPosition.y += velocity.y
		
		// Bounce the point off the boundary and flip velocity if needed
		if newPosition.x >= boundary.maxX {
			newPosition.x = 2*boundary.maxX - newPosition.x
			newVelocity.x *= -1
		}
		if newPosition.x <= boundary.minX {
			newPosition.x = 2*boundary.minX - newPosition.x
			newVelocity.x *= -1
		}
		if newPosition.y >= boundary.maxY {
			newPosition.y = 2*boundary.maxY - newPosition.y
			newVelocity.y *= -1
		}
		if newPosition.y <= boundary.minY {
			newPosition.y = 2*boundary.minY - newPosition.y
			newVelocity.y *= -1
		}
		return (newPosition: newPosition, newVelocity: newVelocity)
	}
	
	mutating func update(velocity1: CGPoint, velocity2: CGPoint, within boundary: CGRect) -> (newVelocity1: CGPoint, newVelocity2: CGPoint) {
		
		// MARK: - Step 2
		//
		//         Update start and end of the line position using two
		//         calls to the update(position:velocity:within:) method.
		//         Return the updated velocities.
		
		let result1 = update(position: startPoint, velocity: velocity1, within: boundary)
		let result2 = update(position: endPoint, velocity: velocity2, within: boundary)
		startPoint = result1.newPosition
		endPoint = result2.newPosition
		
		return (newVelocity1: result1.newVelocity , newVelocity2: result2.newVelocity)
	}
}

final class RenderView: UIView {
	
	var shapes: [Drawable] = [] {
		didSet {
			setNeedsDisplay()
		}
	}
	
	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}
		
		context.setFillColor(UIColor.white.cgColor)
		context.fill(rect)
		
		for shape in shapes {
			shape.draw(on: context)
		}
	}
}

func bounceLine(numberOfLines: Int, iterations: Int) {
	let renderView = RenderView(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))
	
	var line = Line(lineWidth: 4, strokeColor: UIColor.blue, startPoint: CGPoint(x: 50, y: 50), endPoint: CGPoint(x: 300, y: 300))
	var velocity1 = CGPoint(x: 10, y: 8)
	var velocity2 = CGPoint(x: 10, y: -12)
	
	var lines: [Line] = []
	for _ in 0..<numberOfLines {
		lines.append(line)
		(velocity1, velocity2) =
			line.update(velocity1: velocity1,
			            velocity2: velocity2,
			            within: renderView.frame)
	}
	
	for _ in 1 ... iterations {
		let lastIndex = lines.count-1
		lines.append(lines[lastIndex])
		(velocity1, velocity2) =
			lines[lastIndex+1].update(velocity1: velocity1,
			                          velocity2: velocity2,
			                          within: renderView.frame)
		lines.remove(at: 0)
		renderView.shapes = lines
		renderView
	}
}
bounceLine(numberOfLines: 7, iterations: 1000)

//: [Next](@next)
