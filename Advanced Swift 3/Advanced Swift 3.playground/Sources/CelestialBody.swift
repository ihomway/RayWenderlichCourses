import Foundation

open class CelestialBody {
	public var name: String
	
	public init(_ name: String) {
		self.name = name
		print("🐣 init \(name)")
	}
	
	deinit {
		print("☠️ deinit \(name)")
	}
}
