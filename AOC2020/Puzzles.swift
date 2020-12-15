
import Foundation

class Puzzles: ObservableObject {
	static func application() -> Puzzles {
		let puzzles = Puzzles()

		puzzles.puzzles = [
			Puzzle(id: 1, name: "Report Repair") { Solve1() },
			Puzzle(id: 2, name: "Password Philosophy") { Solve2() },
			Puzzle(id: 3, name: "Toboggan Trajectory") { Solve3() },
			Puzzle(id: 4, name: "Passport Processing") { Solve4() },
			Puzzle(id: 5, name: "Binary Boarding") { Solve5() },
			Puzzle(id: 6, name: "Custom Customs") { Solve6() },
			Puzzle(id: 7, name: "Handy Haversacks") { Solve7() },
			Puzzle(id: 8, name: "Handheld Halting") { Solve8() },
			Puzzle(id: 9, name: "Encoding Error") { Solve9() },
			Puzzle(id: 10, name: "Adapter Array") { Solve10() },
			Puzzle(id: 11, name: "Seating System") { Solve11() },
			Puzzle(id: 12, name: "Rain Risk") { Solve12() },
			Puzzle(id: 13, name: "Shuttle Search") { Solve13() },
			Puzzle(id: 14, name: "Docking Data") { Solve14() },
			Puzzle(id: 15, name: "Rambunctious Recitation") { Solve15() },
			Puzzle(id: 16, name: "") { Solve16() },
			Puzzle(id: 17, name: "") { Solve17() },
			Puzzle(id: 18, name: "") { Solve18() },
			Puzzle(id: 19, name: "") { Solve19() },
			Puzzle(id: 20, name: "") { Solve20() },
			Puzzle(id: 21, name: "") { Solve21() },
			Puzzle(id: 22, name: "") { Solve22() },
			Puzzle(id: 23, name: "") { Solve23() },
			Puzzle(id: 24, name: "") { Solve24() },
			Puzzle(id: 25, name: "") { Solve25() },
		]

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
