
import SwiftUI

protocol PuzzlesRepo {
	associatedtype Details: View

	var title: String { get }

	var puzzles: Puzzles { get }

	func hasDetails(id: Int) -> Bool

	func details(id: Int) -> Details
}

class Puzzles2020: PuzzlesRepo {
	init() {
		_puzzles = Puzzles()
		_puzzles.puzzles = [
			Puzzle(year: 2020, id: 1, name: "Report Repair") { Solve1() },
			Puzzle(year: 2020, id: 2, name: "Password Philosophy") { Solve2() },
			Puzzle(year: 2020, id: 3, name: "Toboggan Trajectory") { Solve3() },
			Puzzle(year: 2020, id: 4, name: "Passport Processing") { Solve4() },
			Puzzle(year: 2020, id: 5, name: "Binary Boarding") { Solve5() },
			Puzzle(year: 2020, id: 6, name: "Custom Customs") { Solve6() },
			Puzzle(year: 2020, id: 7, name: "Handy Haversacks") { Solve7() },
			Puzzle(year: 2020, id: 8, name: "Handheld Halting") { Solve8() },
			Puzzle(year: 2020, id: 9, name: "Encoding Error") { Solve9() },
			Puzzle(year: 2020, id: 10, name: "Adapter Array") { Solve10() },
			Puzzle(year: 2020, id: 11, name: "Seating System") { Solve11() },
			Puzzle(year: 2020, id: 12, name: "Rain Risk") { Solve12() },
			Puzzle(year: 2020, id: 13, name: "Shuttle Search") { Solve13() },
			Puzzle(year: 2020, id: 14, name: "Docking Data") { Solve14() },
			Puzzle(year: 2020, id: 15, name: "Rambunctious Recitation") { Solve15() },
			Puzzle(year: 2020, id: 16, name: "Ticket Translation") { Solve16() },
			Puzzle(year: 2020, id: 17, name: "Conway Cubes") { Solve17() },
			Puzzle(year: 2020, id: 18, name: "Operation Order") { Solve18() },
			Puzzle(year: 2020, id: 19, name: "Monster Messages") { Solve19() },
			Puzzle(year: 2020, id: 20, name: "Jurassic Jigsaw") { Solve20() },
			Puzzle(year: 2020, id: 21, name: "Allergen Assessment") { Solve21() },
			Puzzle(year: 2020, id: 22, name: "Crab Combat") { Solve22() },
			Puzzle(year: 2020, id: 23, name: "Crab Cups") { Solve23() },
			Puzzle(year: 2020, id: 24, name: "Lobby Layout") { Solve24() },
			Puzzle(year: 2020, id: 25, name: "Combo Breaker") { Solve25() },
		]
	}

	private var _puzzles: Puzzles

	var title: String {
		"Advent of Code 2020"
	}

	var puzzles: Puzzles {
		_puzzles
	}

	func hasDetails(id: Int) -> Bool {
		[1, 4, 11, 12].contains(id)
	}

	@ViewBuilder
	func details(id: Int) -> some View {
		switch id {
		case 1:
			DetailsView1()
		case 4:
			DetailsView4()
		case 11:
			DetailsView11()
		case 12:
			DetailsView12()
		default:
			EmptyView()
		}
	}
}
