//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

protocol Vehicle {
	func accelerate()
	func stop()
}

protocol Music {
	func play()
}

class Transport {
	
}

class Unicycle: Vehicle {
	var peddling = false
	
	func accelerate() {
		print("squeaky squeaky")
		peddling = true
	}
	
	func stop() {
		peddling = false
	}
}

class Car: Transport, Vehicle, Music {
	var velocity = 0
	func accelerate() {
		print("vrrrroom")
		velocity += 4
	}
	
	func stop() {
		velocity = 0
	}
	
	func play() {
		//
	}
}

class Cat {
	
}

class Boat {
	var knot = 0
}

extension Boat: Vehicle {
	func accelerate() {
		print("swish swish")
		knot += 10
	}
	
	func stop() {
		knot = 0
	}
}

var vehicles: [Vehicle] = []
vehicles.append(Car())
vehicles.append(Unicycle())
//vehicles.append(Cat())
vehicles.append(Boat())

for vehicle in vehicles {
	vehicle.accelerate()
	//	vehicle.stop()
}

//: [Next](@next)
