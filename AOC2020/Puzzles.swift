
import Foundation

class Puzzles: ObservableObject {
	static func preview() -> Puzzles {
		let puzzles = Puzzles()

		puzzles.puzzles.append(PuzzlePreview.solved())
		puzzles.puzzles.append(PuzzlePreview.partSolved())
		puzzles.puzzles.append(PuzzlePreview.unsolved())

		return puzzles
	}

	func get(byId id: Int) -> Puzzle? {
		puzzles.first { $0.id == id }
	}

	@Published var puzzles: [Puzzle] = []

	var ordered: [Puzzle] {
		puzzles.sorted { x, y in
			switch (x.name.isEmpty, y.name.isEmpty) {
			case (true, false): return false
			case (false, true): return true
			case (true, true): return x.id < y.id
			case (false, false): return x.id > y.id
			}
		}
	}
}
