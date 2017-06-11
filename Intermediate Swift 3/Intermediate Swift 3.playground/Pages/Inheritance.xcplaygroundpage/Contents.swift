//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

struct Page {
	var words = 0
}

class Story {
	var title = ""
	var pages: [Page] = []
	
	func addPage(_ page: Page) {
		pages.append(page)
	}
}

class ShortStory: Story {
	var maxPageCount = 2
	
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


//: [Next](@next)
