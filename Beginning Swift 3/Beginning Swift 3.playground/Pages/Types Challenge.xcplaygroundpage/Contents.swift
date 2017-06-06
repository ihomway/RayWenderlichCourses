//: [Previous](@previous)

//: Playground - noun: a place where people can play

import UIKit

/*:
#### Beginning Swift Video Tutorial Series - raywenderlich.com
#### Video 3: Types

**Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
*/

//: Declare a constant of type Bool called likesPizza. Set it to your preference
let likesPizza = true
//: Declare a variable of type Character called happyPlace. Set it to a happy emoji. (Hint: Access emojis by Edit\Emojis & Symbols)
var happyPlace: Character = "😄"
//: Declare a constant of type Int called myAge and set it to your age.
let myAge: Int = 26
//: Declare a variable of type Double called averageAge. Initially, set it to your own age. Then, set it to the average of your age and my own age of 30.
var averageAge: Double = 26
averageAge = (averageAge + 30) / 2.0
//: **Ub3r H4ck3r Challenge** - Declare a variable of type Character called sadPlace. Set it to a sad emoji. Declare a variable of type String called drama. Combine both happyPlace and sadPlace.
var sadPlace: Character = "😞"
var drama: String = String(sadPlace) + String(happyPlace)
//: [Next](@next)
