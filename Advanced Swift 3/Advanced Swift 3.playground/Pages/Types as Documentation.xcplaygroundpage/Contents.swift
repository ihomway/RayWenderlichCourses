//: [Previous](@previous)

import Foundation
import CoreGraphics

//MARK: Angel
//struct CGAngle {
//	var radians: CGFloat
//}
//
//extension CGAngle {
//	init(degrees: CGFloat) {
//		radians = degrees / 180.0 * CGFloat.pi
//	}
//	
//	var degrees: CGFloat {
//		get {
//			return radians / CGFloat.pi * 180.0
//		}
//		
//		set  {
//			radians = newValue / 180.0 * CGFloat.pi
//		}
//	}
//}
//
//extension CGAngle: CustomStringConvertible {
//	var description: String {
//		return String(format: "%0.2f°", degrees)
//	}
//}
//
//let angle = CGAngle(radians: .pi)

//MARK: StatesCapitals
//var capitalLookup: [String: String] =
//	["Alabama": "Montgomery",
//	 "Alaska": "Juneau",
//	 "Arizona": "Phoenix"]

//struct State: Hashable {
//	var name: String
//	init(_ name: String) {
//		self.name = name
//	}
//	
//	static func ==(lhs: State, rhs: State) -> Bool {
//		return lhs.name == rhs.name
//	}
//	
//	var hashValue: Int {
//		return name.hashValue
//	}
//}
//
//struct Capital {
//	var name: String
//	
//	init(_ name: String) {
//		self.name = name
//	}
//	
//	static func ==(lhs: Capital, rhs: Capital) -> Bool {
//		return lhs.name == rhs.name
//	}
//	
//	var hashValue: Int {
//		return name.hashValue
//	}
//	
//}
//
//var lookup = [
//	State("Alabama"): Capital("Montgomery"),
//	State("Alaska"): Capital("Juneau"),
//	State("Arizona"): Capital("Phoenix")
//]

//MARK: Named
//struct Named<T>: Hashable {
//	var name: String
//	init(_ name: String) {
//		self.name = name
//	}
//	
//	static func ==(lhs: Named, rhs: Named) -> Bool {
//		return lhs.name == rhs.name
//	}
//	
//	var hashValue: Int {
//		return name.hashValue
//	}
//}
//
//enum StateTag {}
//enum CapitalTag {}
//typealias State = Named<StateTag>
//typealias Capital = Named<CapitalTag>
//
//var lookup = [
//	State("Alabama"): Capital("Montgomery"),
//	State("Alaska"): Capital("Juneau"),
//	State("Arizona"): Capital("Phoenix")
//]

//MARK: Transforms
// Define an arbitrary coordinate space
protocol CoordinateSpace {}

// Point class
struct Point<Space: CoordinateSpace>: Equatable {
	var x, y: CGFloat
	
	init(_ x: CGFloat, _ y: CGFloat) {
		self.x = x
		self.y = y
	}
	
	static func  ==(lhs: Point<Space>, rhs: Point<Space>) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y
	}
	
	static func  +(lhs: Point<Space>, rhs: Point<Space>) -> Point<Space> {
		return Point<Space>(lhs.x + rhs.x, lhs.y + rhs.y)
	}
}

extension Point: CustomStringConvertible {
	var description: String {
		return"(\(x), \(y)) \(Space.self)"
	}
}

enum ModelSpace: CoordinateSpace {}
enum ScaledSpace: CoordinateSpace {}
enum DisplaySpace: CoordinateSpace {}

var p1 = Point<DisplaySpace>(10, 10)
var p2 = Point<ModelSpace>(10, 10)

//p1 == p1
//p1 == p2
//p1 + p1
//p1 + p2


/////////////////////////////////////////////////////////////////////




struct Transform<From: CoordinateSpace, To: CoordinateSpace> {
	var matrix: CGAffineTransform
	
	func transforming(point: Point<From>) -> Point<To> {
		let p = CGPoint(x: point.x, y: point.y).applying(matrix)
		return Point<To>(p.x, p.y)
	}
	
	static func *(point: Point<From>, transform: Transform<From,To>) -> Point<To> {
		return transform.transforming(point: point)
	}
	
	func concatenating<New: CoordinateSpace>(transform: Transform<To,New>) -> Transform<From,New> {
		return Transform<From, New>(matrix: self.matrix.concatenating(transform.matrix))
	}
	
	static func *<Intermediate>(lhs: Transform<From,Intermediate>, rhs: Transform<Intermediate,To>) -> Transform<From,To> {
		return lhs.concatenating(transform: rhs)
	}
}

print("Model Points")
let unitBox: [Point<ModelSpace>] = [Point(-1, -1), Point(1, -1), Point(1, 1), Point(-1, 1)]
unitBox.forEach{ print($0) }

let modelToScaled = Transform<ModelSpace, ScaledSpace>(matrix: CGAffineTransform(scaleX: 300, y: 100))
let scaledToDisplay = Transform<ScaledSpace, DisplaySpace>(matrix: CGAffineTransform(translationX: 1000, y: 1000))
let modelToDisplay = modelToScaled * scaledToDisplay

let displayPoints = unitBox.map{ $0 * modelToDisplay}

print("Display Points")
displayPoints.forEach{ print($0) }

//: [Next](@next)
