//: [Previous](@previous)

import Foundation

10.randomUniform
10.randomUniform
10.randomUniform
10.randomUniform


let range = 0..<256
let closedRange = 0...255


//MARK: Attempt 1
//extension CountableRange where Bound == Int {
//	var random: Int {
//		return count.randomUniform + numericCast(lowerBound)
//	}
//}
//
//let range = 0..<256
//range.random
//range.random
//
//extension CountableClosedRange where Bound == Int {
//	var random: Int {
//		return count.randomUniform + numericCast(lowerBound)
//	}
//}
//
//let closedRange = 0...256
//closedRange.random
//closedRange.random

//MARK: Attempt 2
//protocol BoundedRange {
//	associatedtype Bound
//	
//	var lowerBound: Bound { get }
//	var upperBound: Bound { get }
//}
//
//extension CountableRange: BoundedRange {}
//extension CountableClosedRange: BoundedRange {}
//
//extension BoundedRange where Bound == Int {
//	var random: Int {
//		return lowerBound + (upperBound - lowerBound).randomUniform
//	}
//}

//range.random
//closedRange.random

//MARK Attempt 3
extension RandomAccessCollection where Index == Int {
	var random: Iterator.Element {
		precondition(!isEmpty)
		
		let randomOffset: IndexDistance = numericCast(startIndex + (endIndex - startIndex).randomUniform)
		let index = self.index(startIndex, offsetBy: randomOffset)
		return self[index]
	}
}

range.random
[1,2,3,4,5,6].random
Array("abcde".characters).random
closedRange.random

//MARK: Attempt 4
//extension RandomAccessCollection where Index == Int {
//	var random: Iterator.Element {
//		precondition(!isEmpty)
//		
//		let count: Int = numericCast(self.count)
//		let randomOffset: IndexDistance = numericCast(count.randomUniform)
//		let index = self.index(startIndex, offsetBy: randomOffset)
//		return self[index]
//	}
//}
//
//range.random
//[1,2,3,4,5,6].random
//Array("abcde".characters).random
//closedRange.random

//: [Next](@next)
