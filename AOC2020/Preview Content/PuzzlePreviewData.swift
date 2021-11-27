

import Foundation
import SwiftUI

class PuzzlePreview: PuzzlesRepo {
	static func solved() -> Puzzle {
		let p = Puzzle(year: 1974, id: 0, name: "An easy one") {
			EmptySolver()
		}
		p.solutionA = "69420"
		p.solutionB = "12345"
		return p
	}

	static func partSolved() -> Puzzle {
		let p = Puzzle(year: 1974, id: 1, name: "Almost! This one has a really long name") {
			EmptySolver()
		}
		p.solutionA = "FOOO"
		return p
	}

	static func unsolved() -> Puzzle {
		Puzzle(year: 1974, id: 2, name: "A Hard One") {
			EmptySolver()
		}
	}

	var title: String {
		"Advent of Code Preview"
	}

	var puzzles: Puzzles {
		let puzzles = Puzzles()

		puzzles.puzzles.append(PuzzlePreview.solved())
		puzzles.puzzles.append(PuzzlePreview.partSolved())
		puzzles.puzzles.append(PuzzlePreview.unsolved())

		return puzzles
	}

	func hasDetails(id _: Int) -> Bool {
		false
	}

	@ViewBuilder
	func details(id _: Int) -> some View {
		EmptyView()
	}

	func processing() -> PuzzleProcessing {
		PuzzleProcessing.preview(puzzles: puzzles)
	}
}
