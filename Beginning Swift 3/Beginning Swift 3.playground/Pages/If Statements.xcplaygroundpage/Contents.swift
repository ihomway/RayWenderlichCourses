//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var money = 1000

if money > 1_300 {
	print("you can buy the ceramic apple watch.")
} else if money > 270 {
	print("you can buy a sport band apple watch.")
} else {
	print("you can watch a watch in the Apple store.")
}

var likeSwift = true
if money > 1_300 || likeSwift {
	print("you can buy the ceramic apple watch.")
} else if money > 270 {
	print("you can buy a sport band apple watch.")
} else {
	print("you can watch a watch in the Apple store.")
}


var ownWatch = false
var likesApple = true

if money > 1_300 && likeSwift {
	print("you can buy the ceramic apple watch.")
	ownWatch = true
} else if money > 270 {
	print("you can buy a sport band apple watch.")
	if likesApple {
		ownWatch = true
	}
} else {
	print("you can watch a watch in the Apple store.")
}

ownWatch
//: [Next](@next)
