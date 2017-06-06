//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
var str2 = str + ", how are you dong?"
var story = "\"Put down the gun,\" John said."
print(story)

var name = "Ray"
var storyHeader = "\"Put down the gun,\""
var storyFooter = "said"
var anotherStory = storyHeader + name + storyFooter
anotherStory = storyHeader + " " + name + " " + storyFooter
print(anotherStory)

anotherStory = storyHeader + " \t" + name + " " + storyFooter
anotherStory = storyHeader + " \n" + name + " " + storyFooter
print(anotherStory)

var yetAnotherStory = "\"Put down the gun,\" \(name) said"
var quote: Character = "\""
print(quote)
yetAnotherStory = "\(quote)Put down the gun,\(quote) \(name) said"
print(yetAnotherStory)

yetAnotherStory.uppercased()
yetAnotherStory.lowercased()
yetAnotherStory.isEmpty
"".isEmpty
" ".isEmpty
//: [Next](@next)
