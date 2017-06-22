//: [Previous](@previous)

import Foundation

// Challenge
// Use the function arc4random_buf() to make a random number
// for all integer types (trivial types) that randomize all
// of the bits.
//
// Hints: Use a protocol extension.
//        Use withUnsafeMutableBytes to get at the memory
//        Use MemoryLayout to get the size.

extension Integer {
	static func random() -> Self {
		var value: Self = 0
		withUnsafeMutableBytes(of: &value) { buffer in
			arc4random_buf(buffer.baseAddress, MemoryLayout<Self>.size)
		}
		return value
	}
}

Int8.random()
UInt8.random()
UInt16.random()
Int.random()

//: [Next](@next)
