
import Foundation

struct Position2D: Hashable {
	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}

	var x: Int
	var y: Int

	func offset(_ step: Position2D) -> Position2D {
		Position2D(x + step.x, y + step.y)
	}
}
