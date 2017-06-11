//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

struct Page {
	var words = 0
}

class Story {
	var title: String
	var author: String
	var year: Int
	var pages: [Page]
	
	init(title: String, author: String, year: Int) {
		self.title = title;
		self.author = author
		self.year = year
		pages = [Page]()
	}
	
	convenience init(title: String) {
		self.init(title: title, author: "Unkown", year: 2016)
	}
	
	func addPage(_ page: Page) {
		pages.append(page)
	}
}

class ShortStory: Story {
	var maxPageCount = 2
	
	init() {
		maxPageCount = 2
		
		super.init(title: "Unkown Story", author: "Unknown Author", year: 2016)
	}
	
	override func addPage(_ page: Page) {
		if pages.count < maxPageCount {
			super.addPage(page)
		}
	}
}

var story = ShortStory()
story.title = "The Haunting of Hill house"
story.addPage(Page(words: 300))
story.addPage(Page(words: 300))
story.addPage(Page(words: 300))
story.addPage(Page(words: 300))
story.pages.count
story.author

//: [Next](@next)
