//: [Previous](@previous)

import Foundation

import CoreGraphics

// Background:
// If you create a range with floating point Bounds,
// the result is a Range or ClosedRange that is not
// countable.  It is useful for telling if a value
// is contained in a range.

let range = 1.0 ..< 2.0
let closedRange = 1.0 ... 2.0
closedRange.contains(1.5)


// Challenge
// Given the following extension on FloatingPoint for generating
// quasi-uniform random numbers create your own random property.
// (Note: Generating true uniform floating point randoms is
//  actually very difficult and beyond the scope of this challenge.
//  See https://mumble.net/~campbell/2014/04/28/uniform-random-float )

extension FloatingPoint {
	// Doesn't include the upperbound.
	static func unitRandom() -> Self {
		return Self(arc4random())/(Self(UInt32.max)+Self(1))
	}
	// Includes the upper bound
	static func closedUnitRandom() -> Self {
		return Self(arc4random())/Self(UInt32.max)
	}
}

// HINT: Use two extensions, one for ClosedRange and one for Range.

// Closed ranges want to include the upperBound so they use Double.closedUnitRandom()
extension ClosedRange where Bound: FloatingPoint {
	var random: Bound {
		return lowerBound + (upperBound - lowerBound) * Bound.closedUnitRandom()
	}
}

// Half open ranges should not include the upperBound.
extension Range where Bound: FloatingPoint {
	var random: Bound {
		return lowerBound + (upperBound - lowerBound) * Bound.unitRandom()
	}
}

// Test Code
range.random
closedRange.random

//: [Next](@next)
