//: [Previous](@previous)

import Foundation

//MARK: PlanetsWeak
//do {
//	CelestialBody("Skylab")
//}
//
//class Star: CelestialBody {
//	var planets: [Planet]
//	
//	init(_ name: String, planets: [Planet]) {
//		self.planets = planets
//		super.init(name)
//		
//		self.planets.forEach{ $0.system = self }
//	}
//}
//
//class Planet: CelestialBody {
//	weak var system: Star?
//}
//
//do {
//	let names = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
//	let planets = names.map(Planet.init)
//	let sun = Star("Sun", planets: planets)
//}


//MARK: PlanetsUnowned

class Star: CelestialBody {
	var planets: [Planet] = []
}

class Planet: CelestialBody {
	unowned let system: Star
	
	init(_ name: String, system: Star) {
		self.system = system
		super.init(name)
	}
}

do {
	let sun = Star("Sun")
	let earth = Planet("Earth", system: sun)
	sun.planets.append(earth)
}

//: [Next](@next)
