//: [Previous](@previous)

import Foundation

//MARK: Infinit

//struct InfiniteIterator: IteratorProtocol {
//	let value: Int
//
//	mutating func next() -> Int? {
//		return value
//	}
//}
//
//struct InfiniteSequence: Sequence {
//	let value: Int
//
//	func makeIterator() -> InfiniteIterator {
//		return InfiniteIterator(value: value)
//	}
//}
//
//print("Get 5 values from InfiniteSequence")
//let infinite = InfiniteSequence(value: 24)
//for value in infinite.prefix(5) {
//	print(value)
//}

//MARK: AnySequence

//func infinite(value: Int) -> AnySequence<Int> {
//	return AnySequence {
//		sequence(first: value) { _ in value }
//	}
//}
//
//print("Get 5 values from InfiniteSequence")
//for value in infinite(value: 24).prefix(5) {
//print(value)
//}


//MARK: AnyIterator

//func infinite(value: Int) -> AnySequence<Int> {
//	return AnySequence<Int> { AnyIterator<Int> { value } }
//}
//
//print("Get 5 values from InfiniteSequence")
//for value in infinite(value: 24).prefix(5) {
//	print(value)
//}


//MARK:

public extension Collection {
	func pairs() -> AnySequence<(Iterator.Element, Iterator.Element)> {
		guard var index1 = index(startIndex, offsetBy: 0, limitedBy: endIndex),
			var index2 = index(index1, offsetBy: 1, limitedBy: endIndex) else {
				return AnySequence { EmptyIterator() }
		}
		
		return AnySequence {
			AnyIterator {
				if index1 >= self.endIndex || index2 >= self.endIndex {
					return nil
				}
				
				defer {
					index2 = self.index(after: index2)
					if index2 >= self.endIndex {
						index1 = self.index(after: index1)
						index2 = self.index(after: index1)
					}
				}
				return (self[index1], self[index2])
			}
		}
	}
}




let elements = ["A", "B", "C", "D"]

print("All Unique Pairs of Elements")
//for (index, first) in elements.enumerated() {
//	for second in elements.dropFirst(index+1) {
//		print(first, second)
//	}
//}

for (first, second) in elements.pairs() {
	print(first, second)
}

//: [Next](@next)
