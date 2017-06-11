//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

enum Coin: Int {
	case penny = 1
	case nickel = 5
	case dime = 10
	case quarter = 25
}

var coin = Coin.quarter

switch coin {
case .penny:
	print("you have a penny")
case .nickel:
	print("you have a nickel")
case .dime:
	print("you habve a dime")
case .quarter:
	print("you have a quarter")
}

var coins: [Coin] = [.quarter, .quarter, .nickel, .dime, .quarter]

var value = 0
for coin in coins {
	
	switch coin {
	case .penny:
		print("you have a penny")
	case .nickel:
		print("you have a nickel")
	case .dime:
		print("you habve a dime")
	case .quarter:
		print("you have a quarter")
	}
	
	value += coin.rawValue
}

enum Icon: String {
	case music
	case sports
	case weather
	
	var fileName: String {
		return "\(rawValue.capitalized).png"
	}
}

let icon = Icon.weather
icon.fileName

enum HTTPMethod {
	case get(address: String)
	case post(body: String)
}

func makeRequest(method: HTTPMethod) {
	switch method {
	case .get(let address):
		print("Address: \(address)")
	case .post(let body):
		print("Body: \(body)")
	}
}

makeRequest(method: .get(address: "www.raywenderlich.com"))
makeRequest(method: .post(body: "Hello World"))

//: [Next](@next)
