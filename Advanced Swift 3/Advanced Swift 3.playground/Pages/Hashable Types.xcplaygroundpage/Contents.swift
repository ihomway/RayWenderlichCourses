//: [Previous](@previous)

import Foundation

protocol HashAlgorithm {
	mutating func consume<S: Sequence>(byte: S) where S.Iterator.Element == UInt8
	
	var finalValue: Int { get }
}

extension HashAlgorithm {
	mutating func consume(_ string: String) {
		consume(byte: string.utf8)
	}
	
	mutating func consume(_ bool: Bool) {
		let value: UInt8 = bool ? 1 : 0
		consume(byte: CollectionOfOne(value))
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
		var tx = x
		withUnsafeBytes(of: &tx) { rawBufferPointer in
			hash.consume(bytes: rawBufferPointer)
		}
		var ty = y
		withUnsafeBytes(of: &ty) { rawBufferPointer in
			hash.consume(bytes: rawBufferPointer)
		}
		
		return hash.finalValue
	}
}

let p1 = NamedPosition(name: "d", x: 1000, y: 1000)
p1.hashValue


//: [Next](@next)
