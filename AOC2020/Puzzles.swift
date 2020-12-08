
import Foundation

class Puzzles: ObservableObject {
	static func application() -> Puzzles {
		let puzzles = Puzzles()

		puzzles.puzzles = [
			Puzzle(id: 1, name: "Report Repair") {
				Solve1()
			},
			Puzzle(id: 2, name: "Password Philosophy") {
				Solve2()
			},
			Puzzle(id: 3, name: "Toboggan Trajectory") {
				Solve3()
			},
			Puzzle(id: 4, name: "Passport Processing") {
				Solve4()
			},
			Puzzle(id: 5, name: "Binary Boarding") {
				Solve5()
			},
			Puzzle(id: 6, name: "Custom Customs") {
				Solve6()
			},
			Puzzle(id: 7, name: "Handy Haversacks") {
				Solve7()
			},
			Puzzle(id: 8, name: "Pineo Poop") {
				Solve8()
			},
		]

		let totalPuzzles = 25
		for index in puzzles.puzzles.count ..< totalPuzzles {
			puzzles.puzzles.append(Puzzle(id: index + 1))
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
