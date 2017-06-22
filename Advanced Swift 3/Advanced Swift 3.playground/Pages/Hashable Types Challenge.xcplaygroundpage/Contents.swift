//: [Previous](@previous)

import Foundation

protocol HashAlgorithm {
	mutating func consume<S: Sequence>(bytes: S) where S.Iterator.Element == UInt8
	var finalValue: Int { get }
}

// Challenge
// Implement consume for basic types in the protocol extension.
// This will allow you to crete easier to read hashValue methods.

extension HashAlgorithm {
	mutating func consume(_ string: String) {
		consume(bytes: string.utf8)
	}
	
	mutating func consume(_ bool: Bool) {
		let value: UInt8 = bool ? 1 : 0
		consume(bytes: CollectionOfOne(value))
	}
	
	// Implement these two methods.
	
	mutating func consume<I: Integer>(_ value: I) {
		// Challenge: Implement me
		var test = value
		withUnsafeBytes(of: &test) { rawBufferPointer in
			consume(bytes: rawBufferPointer)
		}

	}
	mutating func consume<F: FloatingPoint>(_ value: F) {
		// Challenge: Implement me
		var test = value
		withUnsafeBytes(of: &test) { rawBufferPointer in
			consume(bytes: rawBufferPointer)
		}
	}
}

extension FVN1AHash: HashAlgorithm {}

struct NamedPosition: Hashable {
	var name: String
	var x: Int
	var y: Int
	
	static func ==(lhs: NamedPosition, rhs: NamedPosition) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y && lhs.name == rhs.name
	}
	
	var hashValue: Int {
		var hash = FVN1AHash()
		hash.consume(name)
		hash.consume(x)
		hash.consume(y)
		return hash.finalValue
	}
}

let p1 = NamedPosition(name: "d", x: 10, y: 10)
p1.hashValue

//: [Next](@next)
