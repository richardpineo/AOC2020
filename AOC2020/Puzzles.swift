
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
			Puzzle(id: 8, name: "Handheld Halting") {
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
