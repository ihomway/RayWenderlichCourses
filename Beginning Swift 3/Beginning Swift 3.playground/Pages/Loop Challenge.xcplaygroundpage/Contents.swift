//: [Previous](@previous)

import UIKit

/*:
#### Beginning Swift Video Tutorial Series - raywenderlich.com
#### Video 7: Loops

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Create a loop to iterate through a range of 0 through 10 and print out the event numbers. Use a for-in loop.
for index in 0...10 {
	if index % 2 == 0 {
		print(index)
	}
}

//: Do the same with a while loop
var temp = 0
while temp <= 10 {
	if temp % 2 == 0 {
		print(temp)
	}
	temp += 1
}

//: Do the same with a repeat-while loop
temp = 0
repeat {
	if temp % 2 == 0 {
		print(temp)
	}
	
	temp += 1
} while temp <= 10

//: **Ub3r H4ck3r Challenge** - Creata an outer loop to count between 1 to 10 and create an inner loop to also count to 1 to 10. Multiply the index of the outer loop with the index of the inner loop, and print out the result. The result should read: 1 * 1 = 1

//: [Next](@next)
