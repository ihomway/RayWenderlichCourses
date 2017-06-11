//: [Previous](@previous)

import UIKit

/*:
#### Intermediate Swift Video Tutorial Series - raywenderlich.com
#### Video 7: Initializers

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.

*/

//: Create a story class that contains two string properties: name and a writer. Provide an a init() that sets both properties
class Story {
	var name: String
	var writer: String
	
	init(name: String, writer: String) {
		self.name = name
		self.writer = writer
	}
}

//: Create a new Movie class that is a sublcass of the story class. Give it a new string propery called directory. Create a init that sets the director, name, and writer properties.

class Movie: Story {
	var directory: String
	
	init(name: String, writer: String, directory: String) {
		self.directory = directory
		super.init(name: name, writer: writer)
	}
	
	convenience init(directory: String) {
		self.init(name: "Unknown Title", writer: "Unknown writer", directory: directory)
	}
}

//: Create a convenience init that takes just a director's name. Set the name to "Unknown Title" and the writer to "Unknown writer"


//: [Next](@next)
