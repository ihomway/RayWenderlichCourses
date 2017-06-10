//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var closure = { () -> Void in
	print("hello")
}

closure()

var anotherClosure: () -> Void = { print("Hello") }
anotherClosure()

func runClousure(_ aClosure: () -> Void) {
	aClosure()
}

runClousure(anotherClosure )
runClousure {
	print("hello")
}

var yetAnotherClosure:(String, Int) -> Void = { (message: String, times: Int) -> Void in
	for _ in 0..<times {
		print(message)
	}
}

yetAnotherClosure("Hello world", 5)

//var multiply:(Int, Int) -> Int = { (a: Int, b: Int) -> Int in
//	return a * b
//}

//var multiply:(Int, Int) -> Int = {
//	return $0 * $1
//}

var multiply:(Int, Int) -> Int = {
	$0 * $1
}

multiply(5, 5)

var counter = 0
var counterClosure = {
	counter += 1
}
counterClosure()
counterClosure()
counterClosure()
counterClosure()
counterClosure()
counterClosure()
counter

counter = 0
counterClosure()
counter

//: [Next](@next)
