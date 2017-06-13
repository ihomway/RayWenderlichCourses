//: [Previous](@previous)

import Foundation

// Challenge
//
// Inventory contains an array of different models that conform
// to the Item protocol.  Make all of the necessary changes to
// the Item protocol and Inventory to make Inventory Equatable.
//
// Test it out by uncommenting the code below.

protocol Item {
	var name: String { get }
	var weight: Int { get }
	
	func isEqual(to another:Item) -> Bool
}

extension Item {
	func isEqual(to another:Item) -> Bool {
		return name == another.name && weight == another.weight
	}
}

struct Inventory: Equatable {
	var items: [Item]
	
	static func ==(lhs: Inventory, rhs: Inventory) -> Bool {
		
		return lhs.items.count == rhs.items.count &&
			!zip(lhs.items, rhs.items).contains(where: {
				let (item1, item2) = $0
				return !item1.isEqual(to: item2)
			})
	}
}

struct Armor: Item, Equatable {
	let name: String
	let weight: Int
	let armorClass: Int
	
	static func ==(lhs: Armor, rhs: Armor) -> Bool {
		return lhs.name == rhs.name && lhs.weight == rhs.weight &&
			lhs.armorClass == rhs.armorClass
	}
}

struct Weapon: Item, Equatable {
	let name: String
	let weight: Int
	let damage: Int
	
	static func ==(lhs: Weapon, rhs: Weapon) -> Bool {
		return lhs.name == rhs.name && lhs.weight == rhs.weight &&
			lhs.damage == rhs.damage
	}
}

struct Scroll: Item, Equatable {
	let name: String
	var weight: Int { return 1 }
	let magicWord: String
	
	static func ==(lhs: Scroll, rhs: Scroll) -> Bool {
		return lhs.name == rhs.name && lhs.magicWord == rhs.magicWord
	}
}

// Test code

var tankEquipment = Inventory(items:
	[Armor(name: "Plate", weight: 180, armorClass: 2),
	 Weapon(name: "Sword", weight: 20, damage: 30)])

var rogueEquipment = Inventory(items:
	[Armor(name: "Leather", weight: 40, armorClass: 7),
	 Weapon(name: "Dagger", weight: 5, damage: 7)])

var wizardEquipment = Inventory(items:
	[Weapon(name: "Dagger", weight: 5, damage: 7),
	 Scroll(name: "Create Water", magicWord: "Mizu!"),
	 Scroll(name: "Vortex of Teeth", magicWord: "Sakana!"),
	 Scroll(name: "Fireball", magicWord: "Utte!")])

tankEquipment == tankEquipment
wizardEquipment == wizardEquipment
tankEquipment != wizardEquipment
tankEquipment != rogueEquipment
tankEquipment == wizardEquipment
tankEquipment == rogueEquipment


//: [Next](@next)
