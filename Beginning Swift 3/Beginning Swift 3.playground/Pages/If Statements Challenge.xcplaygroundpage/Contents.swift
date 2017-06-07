//: [Previous](@previous)

import UIKit

/*:
#### Beginning Swift Video Tutorial Series - raywenderlich.com
#### Video 5: If Statement

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Create a constant called myAge and initialize it with your age. Write an if statement to print out Teenager if your age is between 13 and 19, and Not a teenager if your age is not between 13 and 19.
let myAge = 10
if myAge >= 13 && myAge <= 19 {
	print("Teenager")
} else {
	print("Not a teenager")
}


//: **Ub3r H4ck3r Challenge** - Expand this if statement to print out the categories and subcategories of an age. For all ages greater than 19, print out "Adult". For ages between 40-65 print "Middle Age" and for ages higher than 65, print out "Senior Citizen". For all ages, less than thirteen, print "Pre teen". For ages between "1-4", write "toddler" and for ages between 5-12, write "Child".
if myAge > 19 {
	print("Adult")
	
	if myAge >= 40 && myAge <= 65 {
		print("Middle Age")
	} else if myAge > 65 {
		print("Senior Citizen")
	}
} else if myAge >= 13 && myAge <= 19 {
	print("Teenager")
} else {
	print("Pre teen")
	
	if myAge >= 1 && myAge <= 4 {
		print("toddler")
	} else if myAge >= 5 && myAge <= 12 {
		print("Child")
	}
}
//: [Next](@next)
