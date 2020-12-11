
import Foundation

struct Position2D: Hashable, Comparable {
	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}

	var x: Int
	var y: Int

	func offset(_ step: Position2D) -> Position2D {
		Position2D(x + step.x, y + step.y)
	}
	
	static func < (lhs: Position2D, rhs: Position2D) -> Bool {
		lhs.x == rhs.x ? lhs.y < rhs.y : lhs.x < rhs.x
	}
	

}
