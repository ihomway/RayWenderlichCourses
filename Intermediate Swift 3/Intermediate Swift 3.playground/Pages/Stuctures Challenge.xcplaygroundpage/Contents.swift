//: [Previous](@previous)

import UIKit

/*:
#### Intermediate Swift Video Tutorial Series - raywenderlich.com
#### Video 3: Structures

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Create a T-shirt struct that has size, color and material options. The size prices go from 3, 5, 7. The colors range from red, blue, and white. It should range from 2, 3, and 1. Finally, for material options, choose regular or organic. It should be 5 or 10. Print out the result in calculatePrice()

struct Size {
	var name: String
	var price: Int
}

struct Color {
	var name: String
	var price: Int
}

struct Material {
	var name: String
	var price: Int
}

struct TShirt {
	var size: Size
	var color: Color
	var material: Material
	
	func calculatePrice() -> Int {
		var price = 0
		price += size.price
		price += color.price
		price += material.price
		
		return price
	}
}

//: Here's an example of creating a struct:
//: var tshirt = TShirt(size: "M", color: "red", material: "organic")

//var tshirt = TShirt(size: "M", color: "red", material: "organic")


//: **Ub3r H4ck3r Challenge** Refactor the code so that materials, color, and sizes are structs with a name and a price. Pass these structs into the TShirt and have it calculate the price


var tshirt = TShirt(size: Size(name:"M", price: 3), color: Color(name:"red", price: 2), material: Material(name:"organic", price: 10))
tshirt.calculatePrice()



//: [Next](@next)
