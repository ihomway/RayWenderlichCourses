//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var str = "Hello, playground"

//MARK: Class
//class Shape {
//	var origin: CGPoint
//	var size: CGSize
//	var color: UIColor
//	var fillColor: UIColor
//	var lineWidth: CGFloat
//
//	init(origin: CGPoint, size: CGSize, color: UIColor, fillColor: UIColor, lineWidth: CGFloat) {
//		self.origin = origin
//		self.size = size
//		self.color = color
//		self.fillColor = fillColor
//		self.lineWidth = lineWidth
//	}
//	func draw(on context: CGContext) {
//		fatalError("overide \(#function)")
//	}
//	func area() -> CGFloat {
//		return size.width * size.height
//	}
//}

//class Circle: Shape {
//	var diameter: CGFloat {
//		return size.width
//	}
//
//	var radius: CGFloat {
//		return size.width / 2
//	}
//
//	override func area() -> CGFloat {
//		return .pi * radius * radius
//	}
//
//	init(origin: CGPoint, radius: CGFloat, color: UIColor, fillColor: UIColor, lineWidth: CGFloat) {
//		let size = CGSize(width: radius*2, height: radius*2)
//		super.init(origin: origin, size: size, color: color, fillColor: fillColor, lineWidth: lineWidth)
//	}
//
//	override func draw(on context: CGContext) {
//		context.setFillColor(fillColor.cgColor)
//		let rect = CGRect(x: origin.x-radius, y: origin.y-radius, width: diameter, height: diameter)
//		context.addEllipse(in: rect)
//		context.fillPath()
//		context.setStrokeColor(color.cgColor)
//		context.addEllipse(in: rect)
//		context.setLineWidth(lineWidth)
//		context.strokePath()
//	}
//}

////////////////////////////////////////////////////////////////////////////////

//final class RenderView: UIView {
//
//	var shapes: [Shape] = [] {
//		didSet {
//			setNeedsDisplay()
//		}
//	}
//
//	override func draw(_ rect: CGRect) {
//		guard let context = UIGraphicsGetCurrentContext() else {
//			return
//		}
//
//		context.setFillColor(UIColor.random.cgColor)
//		context.fill(rect)
//
//		for shape in shapes {
//			shape.draw(on: context)
//		}
//	}
//}

////////////////////////////////////////////////////////////////////////////////

//func testRender(_ count: Int) {
//	let renderView = RenderView(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))
//
//	var shapes: [Shape] = []
//
//	for _ in 1 ... count {
//
//		let position = CGPoint(x: (0...renderView.frame.size.width).random,
//		                       y: (0...renderView.frame.size.height).random)
//		let size = CGSize(width: (CGFloat(50)...CGFloat(80)).random,
//		                  height: (CGFloat(50)...CGFloat(80)).random)
//		let color = UIColor.random
//		let fillColor = UIColor.random
//		let lineWidth = (CGFloat(5)...CGFloat(15)).random
//
//
//		let shape = Circle(origin: position, radius: size.width, color: color, fillColor: fillColor, lineWidth: lineWidth)
//		shapes.append(shape)
//	}
//
//	renderView.shapes = shapes
//	PlaygroundPage.current.liveView = renderView
//}
//testRender(10)


//MARK: Protocol

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

struct Circle: Drawable, Geometry {
	var center: CGPoint
	var radius: CGFloat
	var lineWidth: CGFloat
	var color: UIColor
	var fillColor: UIColor
	
	var diameter: CGFloat {
		return radius * 2
	}
	
	var size: CGSize {
		return CGSize(width: diameter, height: diameter)
	}
	
	func area() -> CGFloat {
		return .pi * radius * radius
	}
	
	func draw(on context: CGContext) {
		context.setFillColor(fillColor.cgColor)
		let rect = CGRect(x: center.x-radius, y: center.y-radius, width: diameter, height: diameter)
		context.addEllipse(in: rect)
		context.fillPath()
		context.setStrokeColor(color.cgColor)
		context.addEllipse(in: rect)
		context.setLineWidth(lineWidth)
		context.strokePath()
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
		
		context.setFillColor(UIColor.random.cgColor)
		context.fill(rect)
		
		for shape in shapes {
			shape.draw(on: context)
		}
	}
}


func testRender(_ count: Int) {
	let renderView = RenderView(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))
	
	var shapes: [Drawable] = []
	
	for _ in 1 ... count {
		
		let position = CGPoint(x: (0...renderView.frame.size.width).random,
		                       y: (0...renderView.frame.size.height).random)
		let size = CGSize(width: (CGFloat(50)...CGFloat(80)).random,
		                  height: (CGFloat(50)...CGFloat(80)).random)
		let color = UIColor.random
		let fillColor = UIColor.random
		let lineWidth = (CGFloat(5)...CGFloat(15)).random
		
		
		let shape = Circle(center: position, radius: size.width, lineWidth: lineWidth, color: color, fillColor: fillColor)
		shapes.append(shape)
	}
	
	renderView.shapes = shapes
	PlaygroundPage.current.liveView = renderView
}
testRender(10)




//: [Next](@next)
