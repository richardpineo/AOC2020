
import AOCLib
import SwiftUI

class Puzzles2020: PuzzlesRepo {
	init() {
		let year = 2020

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Report Repair") { Solve1() },
			Puzzle(year: year, id: 2, name: "Password Philosophy") { Solve2() },
			Puzzle(year: year, id: 3, name: "Toboggan Trajectory") { Solve3() },
			Puzzle(year: year, id: 4, name: "Passport Processing") { Solve4() },
			Puzzle(year: year, id: 5, name: "Binary Boarding") { Solve5() },
			Puzzle(year: year, id: 6, name: "Custom Customs") { Solve6() },
			Puzzle(year: year, id: 7, name: "Handy Haversacks") { Solve7() },
			Puzzle(year: year, id: 8, name: "Handheld Halting") { Solve8() },
			Puzzle(year: year, id: 9, name: "Encoding Error") { Solve9() },
			Puzzle(year: year, id: 10, name: "Adapter Array") { Solve10() },
			Puzzle(year: year, id: 11, name: "Seating System") { Solve11() },
			Puzzle(year: year, id: 12, name: "Rain Risk") { Solve12() },
			Puzzle(year: year, id: 13, name: "Shuttle Search") { Solve13() },
			Puzzle(year: year, id: 14, name: "Docking Data") { Solve14() },
			Puzzle(year: year, id: 15, name: "Rambunctious Recitation") { Solve15() },
			Puzzle(year: year, id: 16, name: "Ticket Translation") { Solve16() },
			Puzzle(year: year, id: 17, name: "Conway Cubes") { Solve17() },
			Puzzle(year: year, id: 18, name: "Operation Order") { Solve18() },
			Puzzle(year: year, id: 19, name: "Monster Messages") { Solve19() },
			Puzzle(year: year, id: 20, name: "Jurassic Jigsaw") { Solve20() },
			Puzzle(year: year, id: 21, name: "Allergen Assessment") { Solve21() },
			Puzzle(year: year, id: 22, name: "Crab Combat") { Solve22() },
			Puzzle(year: year, id: 23, name: "Crab Cups") { Solve23() },
			Puzzle(year: year, id: 24, name: "Lobby Layout") { Solve24() },
			Puzzle(year: year, id: 25, name: "Combo Breaker") { Solve25() },
		])
	}

	var title: String {
		"Advent of Code 2020"
	}

	var puzzles: Puzzles

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
