//: [Previous](@previous)

import UIKit

/*:
#### Beginning Swift Video Tutorial Series - raywenderlich.com
#### Video 4: Strings

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Create a string constant called firstName and initialize it to your first name. Also create a string constant called lastName and initialize it to your last name.
let firstName = "Homway"
let lastName = "Chen"
//: Create a string constant called fullName by adding the firstName and lastName constants together, separated by a space.
let fullName = firstName + " " + lastName
//: Using interpolation, create a string constant called myDetails that uses the fullName constant to create a string introducing yourself. For example, my string would read: "Hello, my name is Matt Galloway.".
let myDetails = "Hello, my name is \(fullName)"
//: **Ub3r H4ck3r Challenge** - Declare a variable called declaration and assign it the string: "I love Objective-C" (Use the heart emoji for extra credit). Then, use replacingOccurrences(of:with:) on the string to replace Objective-C with Swift. Watch the end of the demo to see how you can call methods on Strings.
var decalration = "I ❤️ Objective-C"
decalration.replacingOccurrences(of: "Objective-C", with: "Swift")
//: [Next](@next)
