//: [Previous](@previous)

import Foundation

// A struct implementation of Point
struct PointStruct: CustomStringConvertible {
	var x, y: Int
	
	var description: String {
		return "(\(x), \(y))"
	}
	
	mutating func transpose() {
		(y, x) = (x, y)
	}
}

// A class implementation of Point
class PointClass: CustomStringConvertible {
	var x, y: Int
	
	init(x: Int, y: Int) {
		self.x = x
		self.y = y
	}
	
	var description: String {
		return "(\(x), \(y))"
	}
	
	func transpose() {
		(y, x) = (x, y)
	}
}

//////////////////////////////////////////////////////////////////////

var ps1 = PointStruct(x: 10, y: 100)
var ps2 = ps1
ps1.x = 200
ps1
ps2

var pc1 = PointClass(x: 10, y: 100)
var pc2 = pc1
pc1.x = 200
pc1
pc2

var arrayOfPointStruct: [PointStruct] = [] {
	didSet {
		print(arrayOfPointStruct)
	}
}

print("Struct Array")
arrayOfPointStruct.append(ps1)
arrayOfPointStruct.append(ps2)
arrayOfPointStruct.append(PointStruct(x: 123, y: 124))
ps1.x = 500
arrayOfPointStruct[0].x = 25
arrayOfPointStruct[1].transpose()

var arrayOfPointClass: [PointClass] = [] {
	didSet {
		print(arrayOfPointClass)
	}
}

print("Class Array")
arrayOfPointClass.append(pc1)
arrayOfPointClass.append(pc2)
arrayOfPointClass.append(pc1)

print("what prints")
pc1.x = 1000
print("Forced", arrayOfPointClass)
arrayOfPointClass[0].x = -300
arrayOfPointClass[1].transpose()
print("Forced", arrayOfPointClass)

// Tracked lets you keep track of the Reads and Writes to a value.


struct Tracked<T>: CustomDebugStringConvertible {
	init(_ value: T) {
		self._value = value
		readCount = 0
		writeCount = 0
	}
	
	private var _value: T
	private(set) var readCount: Int
	private(set) var writeCount: Int
	
	var value: T {
		mutating get {
			readCount += 1
			return _value
		}
		set {
			writeCount += 1
			_value = newValue
		}
	}
	
	mutating func resetCounts() {
		print("Resetting")
		readCount = 0
		writeCount = 0
	}
	
	var debugDescription: String {
		return "\(_value) Reads: \(readCount) Writes: \(writeCount)"
	}
}


func computeNothing(input: inout Int) {
}

func compute100Times(input: inout Int) {
	for _ in 1...100 {
		input += 1
	}
}

var tracked = Tracked(42)
computeNothing(input: &tracked.value)
tracked

tracked.resetCounts()
compute100Times(input: &tracked.value)
tracked






//: [Next](@next)
