//: [Previous](@previous)

import UIKit

/*:
#### Beginnng Swift Video Tutorial Series - raywenderlich.com
#### Video 11: Arrays

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Create an array called numbers with the following numbers: 54 10 88 43
let numbers = [54, 10, 88, 43]
//: Create an empty array, called moreNumbers. Next, append those numbers to it.
var moreNumbers: [Int] = []
moreNumbers.append(contentsOf: numbers)
//: Remove the numbers 54 and 43.
moreNumbers.remove(at: 0)
moreNumbers.remove(at: 2)
//: **Ub3r H4ck3r Challenge** Arrays have a reversed() method that returns an array holding the same elements as the original array, in reverse order. Write a function that does the same thing, without using reversed(). This is the signature of the function:  func reversed(_ myArray: [Int]) -> [Int]
func reversed(_ myArray:[Int]) -> [Int] {
	var reversedArray = [Int]()
	
	for number in myArray {
		reversedArray.insert(number, at: 0)
	}
	
	return reversedArray
}

reversed(moreNumbers)
//: [Next](@next)
