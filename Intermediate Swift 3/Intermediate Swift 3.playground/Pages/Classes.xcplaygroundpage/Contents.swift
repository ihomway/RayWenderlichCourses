//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

class Movie {
	var title = ""
	var runningTime = 0
}

var adventureMovie = Movie()
adventureMovie.title = "Raiders of the Lost Ark"
adventureMovie.runningTime = 90
var scienceFictionMovie = adventureMovie

scienceFictionMovie.title = "2001"
print(adventureMovie.title)
print(scienceFictionMovie.title)
print(adventureMovie === scienceFictionMovie)

scienceFictionMovie = Movie()
scienceFictionMovie.title = "The Martian"
print(adventureMovie === scienceFictionMovie)

//: [Next](@next)
