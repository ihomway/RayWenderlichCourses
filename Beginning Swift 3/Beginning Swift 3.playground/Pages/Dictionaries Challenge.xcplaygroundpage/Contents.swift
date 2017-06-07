//: [Previous](@previous)

import UIKit

/*:
#### Beginnng Swift Video Tutorial Series - raywenderlich.com
#### Video 12: Dictionaries

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Create a new dictionary and add the following values: Stephen King - Under the Dome, Elizabeth Peters - Crocodile on the Sandbank, Clive Cussler - The Wrecker
var authorInfo = ["Stephen King": "Under the Dome", "Elizabeth Peters": "Crocodile on the Sandbank", "Clive Cussler": "The Wrecker"]
//: Add a new key: Robert Heinlein - The Moon is a Harsh Mistress
authorInfo["Robert Heinlein"] = "The Moon is a Harsh Mistress"
//: Print out the Stephen King value
print(authorInfo["Stephen King"])
//: Now delete the Stephen King key/value pair

//: Loop through the dictionary and print out all the key/values
for (key, value) in authorInfo {
	print("\(key) - \(value)")
}
//: **Ub3r H4ck3r Challenge** Declare a function occurrencesOfCharacters that calculates which characters occur in a string, as well as how often each of these characters occur. Return the result as a dictionary: func occurrencesOfCharacters(text: String) -> [Character: Int]
func occurrencesOfCharacters(text: String) -> [Character: Int] {
	var chars = [Character: Int]()
	
	for character in text.characters {
		let count = chars[character] ?? 0
		chars[character] = count + 1
	}
	
	return chars
}

print(occurrencesOfCharacters(text: "These are the days of our lines"))
//: [Next](@next)
