//: [Previous](@previous)

// Create an operator +/- that enables the following test case.

/*
let aboutThree = 3.0 +/- 0.5   // Create a Range(2.5..<3.5)
aboutThree.contains(2.7)
*/

infix operator +/-: RangeFormationPrecedence

func +/-(middle: Double, delta: Double) -> Range<Double> {
	return (middle - delta)..<(middle + delta)
}

let aboutThree = 3.0 +/- 0.5
aboutThree.contains(2.7)

//: [Next](@next)
