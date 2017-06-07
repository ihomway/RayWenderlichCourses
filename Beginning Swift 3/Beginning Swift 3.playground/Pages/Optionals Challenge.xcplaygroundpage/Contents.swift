//: [Previous](@previous)

import UIKit

/*:
#### Beginnng Swift Video Tutorial Series - raywenderlich.com
#### Video 10: Optionals

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Make an optional String called myFavoriteSong. If you have a favorite song, set it to a string representing that song. If you have more than one favorite song or no favorite, set the optional to nil.
let myFavoriteSong: String? = nil

//: Create two variables. Call one name and the other is called greeting. The greeting should be "Hello,". Unwrap the name variable, and if there's a name value, then print out the greeting
let name: String? = "Homway"
let greeting: String = "Hello"

if let name = name {
	print("\(greeting) \(name)")
}

//: Now, write the greeting using force unwrap.
print("\(greeting) \(name!)")

//: **Ub3r H4ck3r Challenge** - Create a function that prints out the greeting. This function will take two strings - both optionals. Use guard syntax to bind the variable and print out the greeting.

func greeting(_ greeting: String?, to name: String?) {
	guard let greeting = greeting, let name = name else {
		return;
	}
	
	print("\(greeting) \(name)")
}

greeting("Hey", to: "Juice")
//: [Next](@next)
