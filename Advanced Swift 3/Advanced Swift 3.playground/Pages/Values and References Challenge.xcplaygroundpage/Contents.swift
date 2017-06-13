//: [Previous](@previous)

import Foundation

// Challenge
// You may already know that enums are value types in Swift.  What about indirect enums?
// Create an indirect enum and show that it exhibits value semantics and not reference
// semantics.

//MARK: Value
enum Direction {
	case top, left, down, right
}

var dir1: Direction = .right
var dir2: Direction = .left
var directions: [Direction] = []
directions.append(dir1)
directions.append(dir2)

dir1 = .top
directions

indirect enum Expression {
	case number(Int)
	case add(Expression, Expression)
	
	func evaluate() -> Int {
		switch self {
		case let .number(value):
			return value
		case let .add(left, right):
			return left.evaluate() + right.evaluate()
		}
	}
}

var first = Expression.number(50)
var firstCopy = first
var second = Expression.number(12)
var sum = Expression.add(first, second)

sum.evaluate()

firstCopy = .number(1000)

sum.evaluate()

//: [Next](@next)
