
import Foundation

class Puzzles: ObservableObject {
	init() {
		puzzles = [
			Puzzle(id: 1, name: "The first one"),
			Puzzle(id: 2, name: "The second one"),
		]
	}

	@Published var puzzles: [Puzzle] = []
}
