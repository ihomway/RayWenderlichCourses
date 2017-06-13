//: [Previous](@previous)

import Foundation
import CoreGraphics

var str = "Hello, playground"

protocol Stackable: class {
	associatedtype Element: Comparable
	
	func push(_ element: Element)
	func pop() -> Element?
}

class Stack<Element: Comparable>: Stackable {
	private var storage: [Element] = []
	func push(_ element: Element) { storage.append(element) }
	func pop() -> Element? { return storage.popLast() }
}

func pushToAll<S: Stackable>(stacks: [S], value: S.Element) {
	stacks.forEach{ $0.push(value)}
}

var stack1 = Stack<Int>()
stack1.push(13)
stack1.push(3)
stack1.pop()

var stack2 = Stack<Int>()

dump(stack1)
dump(stack2)


//MARK:
protocol Shape {
	func isEqual(to other: Shape) -> Bool
}

extension Shape where Self: Equatable {
	func isEqual(to other: Shape) -> Bool {
		
		if let other = other as? Self {
			return self == other
		}
		
		return false
	}
}

struct Circle: Shape, Equatable {
	let center: CGPoint
	let radius: CGFloat
	
	static func ==(lhs: Circle, rhs: Circle) -> Bool {
		return lhs.center == rhs.center && lhs.radius == rhs.radius
	}
}

struct Square: Shape, Equatable {
	let origin: CGPoint
	let size: CGFloat
	
	static func ==(lhs: Square, rhs: Square) -> Bool {
		return lhs.origin == rhs.origin && lhs.size == rhs.size
	}
}

struct Diagram: Equatable {
	var shapes: [Shape]
	
	static func ==(lhs: Diagram, rhs: Diagram) -> Bool {
		
		return lhs.shapes.count == rhs.shapes.count &&
		!zip(lhs.shapes, rhs.shapes).contains{
			let (shape1, shape2) = $0
			
			// if return `true`, the `contains` function will be terminated immediately and return ture,
			// so we don't chech if two elements is equal, instead we check if they are unequal
			// if two elements is unequal, we should terminate the function, and it will return a `true`,
			// so there is a `!` outside
			// if two elements is equal, we continue to compare next pair of elements until
			// there is no more elements, and it will return a `false`, with the `!` outside, it will be a `ture`
			return !shape1.isEqual(to: shape2)
		}
	}
}

let diagram1 = Diagram(shapes:
	[Circle(center: .zero, radius: 10),
	 Square(origin: .zero, size: 10)])

let diagram2 = Diagram(shapes:
	[Circle(center: .zero, radius: 10),
	 Square(origin: .zero, size: 10)])

diagram1 == diagram2
diagram2 == diagram1
diagram1 != diagram2










//: [Next](@next)
