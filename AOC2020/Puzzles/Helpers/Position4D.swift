
import Foundation

struct Position4D: Hashable, Positional {
	init(_ x: Int, _ y: Int, _ z: Int, _ w: Int) {
		self.x = x
		self.y = y
		self.z = z
		self.w = w
	}

	init(_ x: Int, _ y: Int) {
		self.init(x, y, 0, 0)
	}

	static let origin = Position4D(0, 0, 0, 0)

	var x: Int
	var y: Int
	var z: Int
	var w: Int

	var displayString: String {
		"(\(x),\(y), \(z), \(w)"
	}

	func offset(_ x: Int, _ y: Int, _ z: Int, _ w: Int) -> Position4D {
		Position4D(self.x + x, self.y + y, self.z + z, self.w + w)
	}

	func offset(_ step: Position4D) -> Position4D {
		offset(step.x, step.y, step.z, step.w)
	}

	func cityDistance(_ from: Position4D = .origin) -> Int {
		abs(x - from.x) + abs(y - from.y) + abs(z - from.z)
	}

	func neighbors(includeSelf: Bool) -> [Position4D] {
		var ns: [Position4D] = []
		for x in -1 ... 1 {
			for y in -1 ... 1 {
				for z in -1 ... 1 {
					for w in -1 ... 1 {
						let pos = Position4D(x, y, z, w)
						if includeSelf || pos != .origin {
							ns.append(pos)
						}
					}
				}
			}
		}
		return ns.map { self.offset($0) }
	}
}
