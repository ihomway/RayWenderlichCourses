//: [Previous](@previous)

import Foundation

// FizzBuzz Collection
// "Write a program that prints the numbers from 1 to 100. But for multiples of three print “Fizz” instead of the number and for the multiples of five print “Buzz”. For numbers which are multiples of both three and five print “FizzBuzz”."

struct FizzBuzz: BidirectionalCollection {
	var startIndex: Int {
		return 1
	}
	
	var endIndex: Int {
		return 101
	}
	
	func index(after i: Int) -> Int {
		return i + 1
	}
	
	func index(before i: Int) -> Int {
		return i - 1
	}
	
	subscript (position: Int) -> String {
		precondition(indices.contains(position), "Out of 1-100")
		
		switch (position%3 == 0, position%5 == 0) {
		case (false, false):
			return String(position)
		case (true, false):
			return "Fizz"
		case (false, true):
			return "Buzz"
		case (true, true):
			return "FizzBuzz"
		}
	}
}

for fb in FizzBuzz().reversed().prefix(4) {
	print(fb)
}
	/*
	.filter { $0.element == "Buzz" }
	.map{ $0.offset + 1}
*/
//fb

// A two dimensional array with non-integer indices.

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

var array = Array2D(width: 4, height: 3, repeating: 0)
array[x: 3, y: 2] = 13


//: [Next](@next)
