//: [Previous](@previous)

import UIKit

/*:
#### Beginning Swift Video Tutorial Series - raywenderlich.com
#### Video 9: Function

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Write a function named printFullName that takes two strings called firstName and lastName. The function should print out the full name defined as firstName + " " + lastName. Use it to print out your own full name.
func printFullname(firstName: String, lastName: String) {
	print("\(firstName)  \(lastName)")
}
printFullname(firstName: "Brian", lastName: "Moakley")

//: Change calculateFullName to return a tuple containing both the full name and the length of the name. You can find a string’s length by using the following syntax: string.characters.count. Use this function to determine the length of your own full name.
func calculateFullName(firstName: String, lastName: String) -> (String, Int) {
	var fullName = "\(firstName) \(lastName)"
	return (fullName, fullName.characters.count)
}
var name = calculateFullName(firstName: "Brian", lastName: "Moakley")
print("name: \(name.0)")
print("length: \(name.1)")

//: **Ub3r H4ck3r Challenge** - This challenge is from Project Euler. Get the sums of numbers of any two mulitples beneath any max value. For the purposes of this excerise, set the max value to be 1000.

//: For example, if you provide the numbers 3 and 5, then the function will add the sums between numbers such as 5, 9, 15, etc. The resulting sum will be 233,168.

func sumOfMultiples(mult1:Int, mult2:Int) -> Int {
	var sum = 0
	for index in 0 ..< 1000 {
		if index % mult1 == 0 || index % mult2 == 0 {
			sum += index
		}
	}
	return sum
}
sumOfMultiples(mult1: 3, mult2: 5)


//: [Next](@next)
