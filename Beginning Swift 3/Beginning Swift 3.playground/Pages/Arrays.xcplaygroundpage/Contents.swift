//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var books = ["The Stand", "Game of Thrones", "Levithan Wakes", "The Lost World"]
print(books)
print(books[0])
books[0] = "The Gunslinger"
print(books[0])
//books[1] = 10

books.append("Red Rising")
print(books)
books.remove(at: 4)
print(books)
books += ["Red Rising", "Golden Son"]
print(books)

var authors: [String] = []
//authors[0] = "Stephen King"
authors.append("Stephen King")
authors[0] = "George R R Martin"
print(authors)

for index in 0..<books.count {
	print(books[index])
}

for book in books {
	print(book)
}

//: [Next](@next)
