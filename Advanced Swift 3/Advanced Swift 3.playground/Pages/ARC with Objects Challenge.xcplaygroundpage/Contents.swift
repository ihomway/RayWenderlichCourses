//: [Previous](@previous)

import Foundation

// Challenge
// Consider the following binary search tree definition. Fix the leak.

class BinarySearchTree <Element: Comparable> {
	private(set) var element: Element
	private(set) weak var parent: BinarySearchTree?
	private(set) var left: BinarySearchTree?
	private(set) var right: BinarySearchTree?
	
	init(_ element: Element) {
		self.element = element
		
		print("🐣 init \(element)")
	}
	
	deinit {
		print("☠️ deinit \(element)")
	}
	
	func insert(_ element: Element) {
		if element < self.element {
			if let left = left {
				left.insert(element)
			}
			else {
				left = BinarySearchTree(element)
				left?.parent = self
			}
		}
		else {
			if let right = right {
				right.insert(element)
			}
			else {
				right = BinarySearchTree(element)
				right?.parent = self
			}
		}
	}
	
	func search(_ element: Element) -> BinarySearchTree? {
		if element < self.element {
			return left?.search(element)
		} else if element > self.element {
			return right?.search(element)
		} else {
			return self
		}
	}
}

do {
	let tree = BinarySearchTree<Int>(7)
	tree.insert(11)
	tree.insert(4)
	tree.insert(5)
	tree.insert(2)
	
	tree.search(5) != nil
	tree.search(6) == nil
}


//: [Next](@next)
