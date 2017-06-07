//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var firstName: String? = "Nic"
var lastName: String? = "Pringle"

print(firstName as Any)

if let firstName = firstName {
	print(firstName)
	if let lastName = lastName {
		print(lastName)
	}
}

if let firstName = firstName, let lastName = lastName {
	print("\(firstName) \(lastName)")
}

if var firstName = firstName, var lastName = lastName {
	firstName = "Sam"
	lastName = "Davies"
	print("\(firstName) \(lastName)")
}

func print(firstName: String?, andLastName lastName:String?) {
	guard let firstName = firstName, let lastName = lastName else {
		return
	}
	
	print("\(firstName) \(lastName)")
}

print(firstName: "Ray", andLastName: "Wenderlich")
print(firstName: nil, andLastName: "Wenderlich")

//func print()

//: [Next](@next)
