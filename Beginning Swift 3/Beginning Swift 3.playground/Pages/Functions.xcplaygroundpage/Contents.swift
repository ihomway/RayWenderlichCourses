//: [Previous](@previous)

import Foundation

var str = "Hello, playground🤗😌😘🤑😤😬🤕🇧🇫🇧🇸🇦🇬"
print(str.count)
print(str.characters.count)

func dance() {
//	print("everybody footloose")
}

dance()

for _ in 0...9 {
	dance()
}

func isEvenNumber(_ number: Int) -> Bool {
	return number % 2 == 0
}

for index in 0...9 {
	print("\(index) is even: \(isEvenNumber(index))")
}

isEvenNumber(7)

func writeMessage(_ text: String, numberOfTimes times: Int) {
	for _ in 0...times {
		print(text)
	}
}

writeMessage("Hi Mom", numberOfTimes: 10)

//: [Next](@next)
