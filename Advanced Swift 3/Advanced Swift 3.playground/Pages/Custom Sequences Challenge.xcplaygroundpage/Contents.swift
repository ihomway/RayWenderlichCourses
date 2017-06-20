//: [Previous](@previous)

import UIKit
import PlaygroundSupport

// Challenge
//
// Uncomment out run below and look at the view to see the balls
// bouncing around.

// Modify Arena.swift and add an implementation for handle collisions.
// You will want to use the pairs() operation to compare each pair
// of the balls. The Ball class has an overlaps(_ other:) method
// to determine if two balls touch and a collide method to do the
// appropriate collision handling.
//
// Arena.swift can be found in the compiled sources by showing the
// navigator and then opening the Sources folder.

func run() {
	let size = CGSize(width: 400, height: 400)
	let colors: [UIColor] = [.red, .green, .blue, .orange, .yellow]
	let radius: CGFloat = 20
	var balls: [Ball] = []
	
	for _ in 1...10 {
		let randomX = (radius...(size.width-radius)).random
		let randomY = (radius...(size.height-radius)).random
		let position = CGPoint(x: randomX, y: randomY)
		let randomVelocity = CGFloat(-15) ... CGFloat(15)
		let velocity = CGPoint(x: randomVelocity.random, y: randomVelocity.random )
		let color = colors.random
		let ball = Ball(position: position, velocity: velocity, color: color, radius: radius)
		balls.append(ball)
	}
	
	var arena = Arena(size: size, balls: balls)
	
	let view = CircleRenderView(frame: CGRect(origin: .zero, size: size))
	
	for _ in 1 ... 1000 {
		arena.simulationStep()
		view.circles = arena.balls.map {
			return Circle(position: $0.position, radius: $0.radius, color: $0.color)
		}
		// Poke the eye to see the view
		view
		
	}
}

// Comment the run() function back in to watch it go.
 run()

//: [Next](@next)
