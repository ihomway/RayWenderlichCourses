//: [Previous](@previous)

import Foundation

// MARK: Memory Layout 1

//MemoryLayout<Int>.size          // returns 8 (on 64-bit)
//MemoryLayout<Int>.alignment     // returns 8 (on 64-bit)
//MemoryLayout<Int>.stride        // returns 8 (on 64-bit)
//
//MemoryLayout<Int16>.size        // returns 2
//MemoryLayout<Int16>.alignment   // returns 2
//MemoryLayout<Int16>.stride      // returns 2
//
//MemoryLayout<Int32>.size        // returns 4
//MemoryLayout<Int32>.alignment   // returns 4
//MemoryLayout<Int32>.stride      // returns 4
//
//MemoryLayout<Bool>.size         // returns 1
//MemoryLayout<Bool>.alignment    // returns 1
//MemoryLayout<Bool>.stride       // returns 1
//
//MemoryLayout<Float>.size        // returns 4
//MemoryLayout<Float>.alignment   // returns 4
//MemoryLayout<Float>.stride      // returns 4
//
//MemoryLayout<Double>.size       // returns 8
//MemoryLayout<Double>.alignment  // returns 8
//MemoryLayout<Double>.stride     // returns 8

// MARK: Memory Layout 2

//struct EmptyStruct {}
//
//MemoryLayout<EmptyStruct>.size      // returns 0
//MemoryLayout<EmptyStruct>.alignment // returns 1
//MemoryLayout<EmptyStruct>.stride    // returns 1 (must have a unique addresses so can't be zero)
//
//
//
//struct SampleStruct {
//	let number: UInt32
//	let flag: Bool
//}
//
//MemoryLayout<SampleStruct>.size       // returns 5
//MemoryLayout<SampleStruct>.alignment  // returns 4
//MemoryLayout<SampleStruct>.stride     // returns 8

// MARK: Memory Layout 3

//class EmptyClass {}
//
//MemoryLayout<EmptyClass>.size      // returns 8 (on 64-bit)
//MemoryLayout<EmptyClass>.stride    // returns 8 (on 64-bit)
//MemoryLayout<EmptyClass>.alignment // returns 8 (on 64-bit)
//
//class SampleClass {
//	let number: Int64 = 0
//	let flag: Bool = false
//}
//
//MemoryLayout<SampleClass>.size      // returns 8 (on 64-bit)
//MemoryLayout<SampleClass>.stride    // returns 8 (on 64-bit)
//MemoryLayout<SampleClass>.alignment // returns 8 (on 64-bit)

// MARK: Raw Pointers

//let count = 2
//let stride = MemoryLayout<Int>.stride
//let alignment = MemoryLayout<Int>.alignment
//let byteCount = stride * count
//
//let pointer = UnsafeMutableRawPointer.allocate(bytes: byteCount, alignedTo: alignment)
//
//defer {
//	pointer.deallocate(bytes: byteCount, alignedTo: alignment)
//}
//
//pointer.storeBytes(of: 42, as: Int.self)
//pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
//(pointer + stride).storeBytes(of: 2, as: Int.self)
//
//pointer.load(as: Int.self)
//pointer.advanced(by: stride).load(as: Int.self)
//(pointer + stride).load(as: Int.self)
//
//let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
//
//for (offset, value) in bufferPointer.enumerated() {
//	print("value \(offset): \(value)")
//}

// MARK: Typed Pointer

//let count = 2
//
//// Make a Typed pointer
//let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
//pointer.initialize(to: 0, count: count)
//
//defer {
//	pointer.deinitialize(count: count)
//	pointer.deallocate(capacity: count)
//}
//
//pointer.pointee = 42
//pointer.advanced(by: 1).pointee = 6
//(pointer + 1).pointer = 6
//
//
//pointer.pointee
//pointer.advanced(by: 1).pointee
//(pointer + 1).pointee
//
//let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
//for (offset, value) in bufferPointer.enumerated() {
//	print("value \(offset): \(value)")
//}

// MARK: ConvertRawToTyped

//let count = 2
//let stride = MemoryLayout<Int>.stride
//let alignment = MemoryLayout<Int>.alignment
//let byteCount = stride * count
//
//let rawPointer = UnsafeMutableRawPointer.allocate(bytes: byteCount, alignedTo: alignment)
//
//defer {
//	rawPointer.deallocate(bytes: byteCount, alignedTo: alignment)
//}
//
//let typedPointer = rawPointer.bindMemory(to: Int.self, capacity: count)
//typedPointer.initialize(to: 0, count: count)
//defer {
//	typedPointer.deinitialize(count: count)
//}
//
//typedPointer.pointee = 42
//typedPointer.advanced(by: 1).pointee = 6
//typedPointer.pointee
//typedPointer.advanced(by: 1).pointee
//
//let bufferPointer = UnsafeBufferPointer(start: typedPointer, count: count)
//for (offset, value) in bufferPointer.enumerated() {
//	print("value \(offset): \(value)")
//}



// MARK: Getting Bytes

//struct SampleStruct {
//	let number: UInt32
//	let flag: Bool
//}

// Getting the bytes of an instance

//var sampleStruct = SampleStruct(number: 300, flag: true)
//
//withUnsafeBytes(of: &sampleStruct) { bytes in
//	for byte in bytes {
//		print(byte)
//	}
//}
//
//let checkSum = withUnsafeBytes(of: &sampleStruct) { (bytes) -> UInt32 in
//	return ~bytes.reduce(UInt32(0)) { $0 + numericCast($1) }
//}
//
//print("CheckSum: \(checkSum)")

// MARK: Binding

let count = 3
let stride = MemoryLayout<Int16>.stride
let alignment = MemoryLayout<Int16>.alignment
let byteCount =  count * stride

let pointer = UnsafeMutableRawPointer.allocate(bytes: byteCount, alignedTo: alignment)

let typedPointer1 = pointer.bindMemory(to: UInt16.self, capacity: count)
//let typedPointer2 = pointer.bindMemory(to: UInt16.self, capacity: count * 2)
typedPointer1.withMemoryRebound(to: Bool.self, capacity: count * 2) {
	(boolPointer: UnsafeMutablePointer<Bool>) in
	
	print(boolPointer.pointee)
}

//: [Next](@next)
