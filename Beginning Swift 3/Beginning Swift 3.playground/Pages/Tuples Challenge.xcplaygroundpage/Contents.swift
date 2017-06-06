//: [Previous](@previous)

import UIKit

/*:
#### Beginning Swift Video Tutorial Series - raywenderlich.com
#### Video 5: Tuples

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Declare a constant tuple that contains three Int values followed by a Double. Use this to represent a date (month, day, year) followed by an average temperature for that date.
let date:(Int, Int, Int, Double) = (2017, 6, 6, 20.4)
//: Change the tuple to name the constituent components. Give them names related to the data that they contain: month, day, year and averageTemperature.
let anotherDate = (year: 2017, month: 6, day: 6, averageTemperature: 20.4)
//: In one line, read the day and average temperature values into two constants. You’ll need to employ the underscore to ignore the month and year.
let (_, _, aDay, aTep) = anotherDate
aDay
aTep
//: **Ub3r H4ck3r Challenge** - Create a variable called tuple and inside of it add a tuple. This tuple contains two other tuples. The first tuple has two strings: your first and last name. The second tuple also has two string: your city and states. Create another variable that holds the string: "My is <first name> <last name> and I live in <city> <state>"
var tuple = (("Homway", "Chen"), ("Shanghai", "Shanghai"))
var strings = "My name is \(tuple.0.0) \(tuple.0.1) and I live in \(tuple.1.0) \(tuple.1.1)"
//: [Next](@next)
