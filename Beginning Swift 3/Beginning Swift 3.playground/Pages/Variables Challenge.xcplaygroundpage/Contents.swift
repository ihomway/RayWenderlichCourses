//: [Previous](@previous)

/*:
#### Beginning Swift Video Tutorial Series - raywenderlich.com
#### Video 2: Variables

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

import UIKit

//: Declare a constant of type Int called myAge and set it to your age.
let myAge = 26

//: Declare a variable of type Double called averageAge. Initially, set it to your own age. Then, set it to the average of your age and my own age of 30.
var averageAge = 26.0
averageAge = (averageAge + 30.0) / 2.0
//: Create a variable called answer and initialize it with the value 0. Increment it by 1. Add 10 to it. Multiply it by 10 and divide by 3. After all of these operations, what’s the answer?
var answer = 0
answer += 1
answer += 10
answer *= 10
answer /= 3
print(answer)
//: Declare two constants a and b of type Double and assign both a value. Calculate the average of a and b and store the result in a constant named average.
let a = 13.6
let b = 87.3
let average = (a + b) / 2.0

//: [Next](@next)
