//: [Previous](@previous)

import Foundation

// Challenge 1
// Consider the usage of the following WWDCGreeting class.
// Used unowned to fix the leak.

//class WWDCGreeting {
//	let who: String
//	
//	init(who: String) {
//		self.who = who
//	}
//	
//	deinit {
//		print("\(who) went away")
//	}
//	
//	lazy var greetingMaker: () -> String = { [unowned self] in
//		return "Hello \(self.who)."
//	}
//}
//
//do {
//	let mermaid = WWDCGreeting(who: "caffinated mermaid who helped me with this course")
//	print(mermaid.greetingMaker())
//}

// Challenge 2
// Consider the usage of the following WWDCGreeting class.  The
// greetingMaker can escape.  Using unowned results in a trap
// if the closure is called.  Fix it using weak and return
// "Goodbye" if the hosting object has gone away.

class WWDCGreeting {
	let who: String
	
	init(who: String) {
		self.who = who
	}
	
	deinit {
		print("\(who) went away")
	}
	
	lazy var greetingMaker: () -> String = { [weak self] in
		
		guard let strongSelf = self else {
			print("Deinited")
			return "Goodbye"
		}
		
		return "Hello \(strongSelf.who)."
	}
}

var escapedMaker: () -> String

do {
	let meow = WWDCGreeting(who: "poptart cat")
	print(meow.greetingMaker())
	escapedMaker = meow.greetingMaker
}

escapedMaker()

//: [Next](@next)
