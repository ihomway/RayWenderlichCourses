//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var monster = ("Reaper", 100, true)
monster.0
monster.1
monster.2

var anotherMonster: (String, Int, Bool)
anotherMonster = ("Savager", 100, false)

var yetAnotherMonster = (name: "Blobby", hitPoints: 200, isAggroed: true)
yetAnotherMonster.hitPoints
yetAnotherMonster.name
yetAnotherMonster.isAggroed

var (name, hp, _) = monster
name
hp

//: [Next](@next)
