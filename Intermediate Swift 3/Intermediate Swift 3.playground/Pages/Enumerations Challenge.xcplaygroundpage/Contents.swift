//: [Previous](@previous)

import UIKit

/*:
#### Intermediate Swift Video Tutorial Series - raywenderlich.com
#### Video 9: Enumerations

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
**/

//: Create a stars rating system that have the following cases: 1 star, 2 stars, 3 stars, 4 stars, 5 stars. Give each case the following values: terrible, meh, good, great, classic
enum Rating: String {
case oneStars = "terrible", twoStars = "meh", threeStars = "good", fourStars = "greet", fiveStars = "classic"
}

//: Next, add the following, "The Wizard of Oz is rated 5 stars. This makes it (five stars value)

print("This Wizard of Oz is rated 4 stars. This makes it \(Rating.fourStars.rawValue)")

//: Create an enumeration called Months that will hold all the cases for months in the year. Make this enumeration an Int type. Start counting from 1.

enum Month: Int {
	case january = 1, february, march, april, may, june, july, august, september, october, november, december
}

//: //: **Ub3r H4ck3r Challenge** Create a new enumeration function that determines the amount of time for the winter break. The winter break occurs in December. The function should take a month and return an Int. The signature should be something like: func monthsUntilWinterBreak(from month: Month) -> Int
//: You may want to create a new enumeration for this function

extension Month {
	func monthsUntilWinterBreak(from month: Month) -> Int {
		return Month.december.rawValue - month.rawValue
	}
}

Month.september.monthsUntilWinterBreak(from: Month.august)


//: [Next](@next)
