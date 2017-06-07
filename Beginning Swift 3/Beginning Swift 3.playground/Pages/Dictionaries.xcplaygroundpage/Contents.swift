//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var userInfo = ["firstName": "Chris", "lastName": "Belanger", "position" : "Editor"]
print(userInfo["firstName"] as Any)

if let firstName = userInfo["firstName"], let lastName = userInfo["lastName"] {
	print("\(firstName) \(lastName)")
}

var anotherUser: [String: String] = [:]
anotherUser["firstName"] = "Luke"
anotherUser["lastName"] = "Freeman"

if anotherUser["firstName"] != nil && anotherUser["lastName"] != nil {
	print("\(anotherUser["firstName"]!) \(anotherUser["lastName"]!)")
}

anotherUser["lastName"] = nil
print(anotherUser)

for key in anotherUser.keys {
	if let info = anotherUser[key] {
		print(info)
	}
}

for (_, value) in anotherUser {
	print(value)
}
