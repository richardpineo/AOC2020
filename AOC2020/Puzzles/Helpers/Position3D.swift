
import Foundation

struct Position3D: Hashable, Positional {
	init(_ x: Int, _ y: Int, _ z: Int) {
		self.x = x
		self.y = y
		self.z = z
	}

	init(_ x: Int, _ y: Int) {
		self.init(x, y, 0)
	}

	static let origin = Position3D(0, 0, 0)

	var x: Int
	var y: Int
	var z: Int

	var displayString: String {
		"(\(x),\(y), \(z)"
	}

	func offset(_ x: Int, _ y: Int, _ z: Int) -> Position3D {
		Position3D(self.x + x, self.y + y, self.z + z)
	}

	func offset(_ step: Position3D) -> Position3D {
		offset(step.x, step.y, step.z)
	}

	func cityDistance(_ from: Position3D = .origin) -> Int {
		abs(x - from.x) + abs(y - from.y) + abs(z - from.z)
	}

	func neighbors(includeSelf: Bool) -> [Position3D] {
		var ns: [Position3D] = []
		for x in -1 ... 1 {
			for y in -1 ... 1 {
				for z in -1 ... 1 {
					let pos = Position3D(x, y, z)
					if includeSelf || pos != .origin {
						ns.append(pos)
					}
				}
			}
		}
		return ns.map { self.offset($0) }
	}
}
