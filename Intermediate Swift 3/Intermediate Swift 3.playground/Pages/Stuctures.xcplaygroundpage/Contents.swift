//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

struct Book {
	var title: String
	
}

struct Author {
	var firstName: String
	var lastName: String
	var books: [Book] = []
	
	mutating func addBook(_ aBook: Book) {
		books.append(aBook)
	}
}

var book = Book(title: "The Stand")
book.title

var write = Author(firstName: "Stephen", lastName: "King", books: [book])
var anotherBook = Book(title: "The Gunslinger")

write.addBook(anotherBook)

//: [Next](@next)
