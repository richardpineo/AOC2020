
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
			Puzzle(id: 2, name: "Toboggan Trajectory") {
				Solve3()
			},
			Puzzle(id: 3, name: "Passport Processing") {
				Solve4()
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
