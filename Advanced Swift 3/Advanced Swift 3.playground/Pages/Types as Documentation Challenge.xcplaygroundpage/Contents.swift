//: [Previous](@previous)

import Foundation
import CoreGraphics

// Challenge 1: Make the CGFloat class more feature complete.
//   Make it conform to Hashable and Comparable.
//   Make a static instance .pi
//   Implement common operators +, -, * by scalar, / by scalar, +=, *=, /=
//   Implement sin, cos, tan
//   Add an extension to CGPoint that finds the angle when interpreted as a vector
//   Add an extension to CGAffineTransform that creates a rotation transform from an Angle

struct CGAngle {
	var radians: CGFloat
	
	init(_ radians: CGFloat) {
		self.radians = radians
	}
}

extension CGAngle: Hashable, Comparable {
	
	static var pi: CGAngle {
		return CGAngle(.pi)
	}
	
	var hashValue: Int {
		return radians.hashValue
	}
	
	public static func ==(lhs: CGAngle, rhs: CGAngle) -> Bool {
		return lhs.radians == rhs.radians
	}
	
	public static func <(lhs: CGAngle, rhs: CGAngle) -> Bool {
		return lhs.radians < rhs.radians
	}
	
	public static func <=(lhs: CGAngle, rhs: CGAngle) -> Bool {
		return lhs.radians <= rhs.radians
	}
	
	public static func >=(lhs: CGAngle, rhs: CGAngle) -> Bool {
		return lhs.radians >= rhs.radians
	}
	
	public static func >(lhs: CGAngle, rhs: CGAngle) -> Bool {
		return lhs.radians > rhs.radians
	}
}

extension CGAngle {
	public static func +(lhs: CGAngle, rhs: CGAngle) -> CGAngle {
		return CGAngle(lhs.radians + rhs.radians)
	}
	
	public static func -(lhs: CGAngle, rhs: CGAngle) -> CGAngle {
		return CGAngle(lhs.radians - rhs.radians)
	}
	
	public static func *(angle: CGAngle, scale: CGFloat) -> CGAngle {
		return CGAngle(angle.radians * scale)
	}
	
	public static func /(angle: CGAngle, scale: CGFloat) -> CGAngle {
		return CGAngle(angle.radians / scale)
	}
	
	public static func +=(lhs: inout CGAngle, rhs: CGAngle) {
		lhs = CGAngle(lhs.radians + rhs.radians)
	}
	
	public static func -=(lhs: inout CGAngle, rhs: CGAngle) {
		lhs = CGAngle(lhs.radians - rhs.radians)
	}
	
	public static func *=(angle: inout CGAngle, scale: CGFloat) {
		angle = CGAngle(angle.radians * scale)
	}
	
	public static func /=(angle: inout CGAngle, scale: CGFloat) {
		angle = CGAngle(angle.radians / scale)
	}
}

func sin(_ angle: CGAngle) -> CGFloat {
	return sin(angle.radians)
}

func cos(_ angle: CGAngle) -> CGFloat {
	return cos(angle.radians)
}

func tan(_ angle: CGAngle) -> CGFloat {
	return tan(angle.radians)
}

extension CGPoint {
	var angle: CGAngle {
		return CGAngle(atan2(y, x))
	}
}

extension CGAffineTransform {
	init(rotationAngle: CGAngle) {
		self.init(rotationAngle: rotationAngle.radians)
	}
}

// Challenge 2
// Implement an inverted method on Tranform<U,V> that produces
// the Transform<V,U>.  Transform a ModelSpace coordinate to DisplaySpace
// and then back to ModelSpace.

protocol CoordinateSpace {}

struct Point<Space: CoordinateSpace>: Equatable {
	var x, y: CGFloat
	
	init(_ x: CGFloat, _ y: CGFloat) {
		self.x = x
		self.y = y
	}
	
	static func ==<Space>(lhs: Point<Space>, rhs: Point<Space>) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y
	}
	
	static func +(lhs: Point<Space>, rhs: Point<Space>) -> Point<Space> {
		return Point(lhs.x+rhs.x, lhs.y+rhs.y)
	}
}

extension Point: CustomDebugStringConvertible {
	var debugDescription: String {
		return "(\(x),\(y)) \(Space.self)"
	}
}

struct Transform<From: CoordinateSpace, To: CoordinateSpace> {
	var matrix: CGAffineTransform
	
	func transforming(point: Point<From>) -> Point<To> {
		let p = CGPoint(x: point.x, y: point.y).applying(matrix)
		return Point<To>(p.x, p.y)
	}
	
	func concatenating<New: CoordinateSpace>(transform: Transform<To,New>) -> Transform<From,New> {
		return Transform<From, New>(matrix: self.matrix.concatenating(transform.matrix))
	}
	
	static func *<Intermediate>(lhs: Transform<From,Intermediate>, rhs: Transform<Intermediate,To>) -> Transform<From,To> {
		return lhs.concatenating(transform: rhs)
	}
	
	static func *(point: Point<From>, transform: Transform<From,To>) -> Point<To> {
		return transform.transforming(point: point)
	}
}

// Start challenge here:

extension Transform {
	func inverted() -> Transform<To, From> {
		return Transform<To, From>(matrix: matrix.inverted())
	}
}

// Now test it out!
enum ModelSpace: CoordinateSpace {}
enum DisplaySpace: CoordinateSpace {}

typealias ModelPoint = Point<ModelSpace>
typealias ModelToDisplay = Transform<ModelSpace, DisplaySpace>

let modelToDisplay = ModelToDisplay(matrix: CGAffineTransform(rotationAngle: CGFloat.pi/4))

let modelPoint = ModelPoint(1,2)
let displayPoint = modelPoint * modelToDisplay
let displayToModel = modelToDisplay.inverted()

displayPoint
let backToModel = displayPoint * displayToModel

//: [Next](@next)
