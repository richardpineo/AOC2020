
import Foundation

struct Position2D: Comparable, Positional {
	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}

	init(from arrayIndex: Int, numCols: Int) {
		x = arrayIndex % numCols
		y = arrayIndex / numCols
	}

	static var origin: Position2D { Position2D(0, 0) }

	var x: Int
	var y: Int

	var displayString: String {
		"(\(x),\(y))"
	}

	func offset(_ x: Int, _ y: Int) -> Position2D {
		Position2D(self.x + x, self.y + y)
	}

	func offset(_ step: Position2D) -> Position2D {
		offset(step.x, step.y)
	}

	func arrayIndex(numCols: Int) -> Int {
		x + y * numCols
	}

	func cityDistance(_ from: Position2D = .origin) -> Int {
		abs(x - from.x) + abs(y - from.y)
	}

	static func < (lhs: Position2D, rhs: Position2D) -> Bool {
		lhs.x == rhs.x ? lhs.y < rhs.y : lhs.x < rhs.x
	}
	
	func neighbors(includeSelf: Bool) -> [Position2D] {
		var ns: [Position2D] = []
		for x in -1 ... 1 {
			for y in -1 ... 1 {
				let pos = Position2D(x, y)
				if includeSelf || pos != .origin {
					ns.append(pos)
				}
			}
		}
		return ns.map { self.offset($0) }
	}
}
