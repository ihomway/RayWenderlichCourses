//: [Previous](@previous)

import UIKit
import PlaygroundSupport

//PlaygroundPage.current.needsIndefiniteExecution = true
//
//// MARK: Closure Capture
//var value = 0
//let show = {
//	print(value)
//}
//
//show()
//value = 10
//show()
//
//let show2 = { [value] in
//	print(value)
//}
//
//show2()
//value = 20
//show2()
//
//let show3 = { [v = value, b = value + 1] in
//	print(v, b)
//}
//
//show3()
//value = 30
//show3()
//
//class Supernova: CelestialBody {
//	lazy var explode: () -> Void = { [unowned self] in
//		self.name = "BOOMED \(self.name)"
//	}
//}
//
//do {
//	let tycho = Supernova("Tycho")
//	tycho.explode()
//	print(tycho.name)
//}
//
//do {
//	let kepler = Supernova("Kepler")
//	
//	DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
//		kepler.explode()
//		print(kepler.name)
//	}
//}
//
///*
//do {
//	let galileo = Supernova("Galileo")
//	
//	DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) { [unowned galileo] in
//		galileo.explode()
//		print(galileo.name)
//	}
//}
//*/
//
//do {
//	let galileo = Supernova("Galileo")
//	
//	DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) { [weak galileo] in
//		
//		guard let galileo = galileo else {
//			print("Nada")
//			return
//		}
//		
//		galileo.explode()
//		print(galileo.name)
//	}
//}

// MARK: Simulation

class PhysicsBody: CelestialBody {
	
	// MARK: - Properties
	var position: CGPoint
	var velocity: CGPoint
	var mass: CGFloat
	var size: CGFloat
	var color: UIColor
	lazy var interact: (_ other: PhysicsBody) -> () =
		{ [unowned self] (other: PhysicsBody) in
			let diff = self.position - other.position
			let r = diff.length
			let dr3 = diff / r*r*r
			let G = CGFloat(0.000001)
			self.velocity += G * other.mass * -dr3
			other.velocity += G * self.mass * dr3
	}
	
	// MARK: Initializer
	init(_ name: String, position: CGPoint, velocity: CGPoint, mass: CGFloat, size: CGFloat, color: UIColor) {
		
		self.position = position
		self.velocity = velocity
		self.mass = mass
		self.size = size
		self.color = color
		super.init(name)
	}
}

// MARK: - Simulation
extension PhysicsBody {
	
	func updatePosition(timeStep: CGFloat = 0.1) {
		position += velocity * timeStep
	}
}

let renderView = CircleRenderView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))

do {
	let o1 = PhysicsBody("O1", position: .zero, velocity: .zero,
	                     mass: 50, size: 10, color: .yellow)
	let o2 = PhysicsBody("O2", position: CGPoint(x: 100, y: 0),
	                     velocity: CGPoint(x: 0, y: -10),
	                     mass: 1, size: 5, color: .blue)
	let o3 = PhysicsBody("O3", position: CGPoint(x: -100, y: 30),
	                     velocity: CGPoint(x: 2, y: 8),
	                     mass: 0.5, size: 3, color: .red)
	
	let objects = [o1,o2,o3]
	
	for _ in 1...2000 {
		
		for (object1, object2) in objects.pairs() {
			object1.interact(object2)
		}
		
		objects.forEach { $0.updatePosition() }
		let circles = objects.map {
			Circle(position: $0.position, radius: $0.size, color: $0.color)
		}
		renderView.circles = circles
	}
}

//: [Next](@next)
