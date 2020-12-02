
import Foundation

class Puzzles: ObservableObject {
	static func application() -> Puzzles {
		let puzzles = Puzzles()

		puzzles.puzzles = [
			Puzzle(id: 0, name: "Report Repair") {
				Solve1()
			},
			Puzzle(id: 1, name: "Password Philosophy") {
				Solve2()
			},
		]

		let totalPuzzles = 25
		for id in puzzles.puzzles.count ..< totalPuzzles {
			puzzles.puzzles.append(Puzzle(id: id))
		}

		return puzzles
	}

	static func preview() -> Puzzles {
		let puzzles = Puzzles()

		puzzles.puzzles.append(PuzzlePreview.solved())
		puzzles.puzzles.append(PuzzlePreview.partSolved())
		puzzles.puzzles.append(PuzzlePreview.unsolved())

		return puzzles
	}

	@Published var puzzles: [Puzzle] = []
}
