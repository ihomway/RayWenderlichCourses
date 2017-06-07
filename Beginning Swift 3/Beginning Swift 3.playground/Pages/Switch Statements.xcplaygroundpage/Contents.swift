//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var north = 0
var south = 1
var east = 2
var west = 3

var direction = 1


switch direction {
case north:
	print("you walk north")
	fallthrough
case south:
	print("you walk south")
case east:
	print("you walk east")
case west:
	print("you walk west")
default:
	print("choose a valid direction")
}

switch direction {
case north...east:
	print("you walk north, south, east")
case west:
	print("you walk west")
default:
	print("choose a valid direction")
}

var name = "Ray"

switch name {
case "Ray", "Vicki":
	print("Hi Ray and Vicke")
default:
	print("Hello")
}

var movingObject = (south, 100)
switch movingObject {
case (north, _):
	print("moving north")
case (_, 100):
	print("moving fast")
default:
	print("not matched")
}

switch movingObject {
case let (direction, speed) where speed >= 100:
	print("moving at \(speed) meters per second")
default:
	print("not matched")
}
//: [Next](@next)
