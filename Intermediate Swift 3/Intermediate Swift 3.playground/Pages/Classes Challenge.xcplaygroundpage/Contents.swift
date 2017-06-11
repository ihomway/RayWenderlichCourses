//: [Previous](@previous)

import UIKit

/*:
#### Intermediate Swift Video Tutorial Series - raywenderlich.com
#### Video 5: Classes

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.

Make the following objects and determine whether they are structs or classes. For the properties, use properties unless noted below.

TShirt: size, color
Address: street, city, state, zipCode
User: firstName, lastName, address (Address object)
ShoppingCart: shirts (array of TShirt), User (user object)

*/

struct Tshirt {
	
}

struct Address {
	var street: String = ""
	var city: String = ""
	var state: String = ""
	var zipCode: Int = 0
}

class User {
	var firstName = ""
	var lastName = ""
	var address: Address = Address()
}

class ShoppingCart {
	var shirts: [Tshirt] = []
	var user = User()
}

//: [Next](@next)
