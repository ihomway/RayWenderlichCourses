//: [Previous](@previous)

import Foundation

// Given the Array2D model from the Demo

struct Array2D<Element>: BidirectionalCollection, MutableCollection {
	
	let width, height: Int
	private(set) var storage: [Element]
	
	init(width: Int, height: Int, repeating value: Element) {
		self.width = width
		self.height = height
		self.storage = Array(repeating: value, count: width*height)
	}
	
	struct Index: Comparable {
		var x, y: Int
		static func ==(lhs: Index, rhs: Index) -> Bool {
			return lhs.x == rhs.x && lhs.y == rhs.y
		}
		static func <(lhs: Index, rhs: Index) -> Bool {
			return lhs.y < rhs.y || lhs.x < rhs.x
		}
	}
	
	var startIndex: Index {
		return Index(x: 0, y: 0)
	}
	
	var endIndex: Index {
		return Index(x: 0, y: height)
	}
	
	func index(before i: Index) -> Index {
		if i.x > 0 {
			return Index(x: i.x-1, y: i.y)
		}
		return Index(x: width-1, y: i.y-1)
	}
	
	func index(after i: Index) -> Index {
		if i.x < width {
			return Index(x: i.x+1, y: i.y)
		}
		var x = i.x + 1
		var y = i.y
		if x >= width {
			x = 0
			y += 1
		}
		return Index(x: x, y: y)
	}
	
	func inBounds(position: Index) -> Bool {
		return (0..<width).contains(position.x) && (0..<height).contains(position.y)
	}
	
	subscript(position: Index) -> Element {
		get {
			precondition(inBounds(position: position), "out of bounds index")
			return storage[position.y*width + position.x]
		}
		set {
			precondition(inBounds(position: position), "out of bounds index")
			storage[position.y*width + position.x] = newValue
		}
	}
	
	subscript(x x: Int, y y: Int) -> Element {
		get {
			return self[Index(x: x, y: y)]
		}
		set {
			self[Index(x: x, y: y)] = newValue
		}
	}
}

// Challenge
// Add custom sequences that run through a particular row or a particular column of
// the array.

extension Array2D {
	func row(y: Int) -> AnySequence<Element> {
		var position = Index(x: 0, y: y)
		return AnySequence<Element> {
			AnyIterator<Element> {
				guard position.x < self.width else {
					return nil
				}
				defer { position.x += 1 }
				return self[position]
			}
		}
	}
	
	func column(x: Int) -> AnySequence<Element> {
		var position = Index(x: x, y: 0)
		return AnySequence<Element> {
			AnyIterator<Element> {
				guard position.y < self.height else {
					return nil
				}
				defer { position.y += 1 }
				return self[position]
			}
		}
	}
}

var array = Array2D(width: 4, height: 3, repeating: 0)
array[x: 3, y: 2] = 12

for pixels in array.row(y: 2) {
	print(pixels)
}


//: [Next](@next)
