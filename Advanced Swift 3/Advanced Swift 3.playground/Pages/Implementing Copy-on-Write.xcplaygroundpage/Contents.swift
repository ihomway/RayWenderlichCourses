//: [Previous](@previous)

import Foundation

let owlBear = RWMonster(name: "Owl Bear", hitPoints: 30)
var enemies: [RWMonster] = [owlBear]
owlBear.hitPoints += 10
print(enemies)

final class SwiftReference<T> {
	var object: T
	init(_ object: T) {
		self.object = object
	}
}

struct Monster {
	fileprivate var _monster: SwiftReference<RWMonster>
	
	fileprivate var _mutatingMonster: RWMonster {
		mutating get {
			if !isKnownUniquelyReferenced(&_monster) {
				print("Making Coping")
				_monster = SwiftReference(_monster.object.copy() as! RWMonster)
			} else {
				print("No Coping")
			}
			
			return _monster.object
		}
	}
	
	init(name: String, hitPoints: Int) {
		_monster = SwiftReference(RWMonster(name: name, hitPoints: hitPoints))
	}
	
	var name: String {
		get {
			return _monster.object.name
		}
		
		set {
			_mutatingMonster.name = newValue
		}
	}
	var hitPoints: Int {
		get {
			return _monster.object.hitPoints
		}
		
		set {
			_mutatingMonster.hitPoints = newValue
		}
	}
	
	var description: String {
		return _monster.object.description
	}
}

var troll = Monster(name: "Troll", hitPoints: 30)
var monsters: [Monster] = [troll]
troll.hitPoints += 100
troll.hitPoints += 1000
troll.hitPoints += 1000
troll.hitPoints += 1000

print(troll)
print(monsters)

//: [Next](@next)
