
import Foundation

struct Position2D {
	 init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}
	
	var x: Int
	var y: Int
	
	func offset(_ step: Position2D) -> Position2D {
		return Position2D(self.x + step.x, self.y + step.y)
	}
}
