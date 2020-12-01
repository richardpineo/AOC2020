

import Foundation

class PuzzlePreview {
	static func solved() -> Puzzle {
		var p = Puzzle(id: 0, name: "An easy one")
		p.solutionA = "69420"
		p.solutionB = "12345"
		return p
	}

	static func partSolved() -> Puzzle {
		var p = Puzzle(id: 1, name: "Almost! This one has a really long name")
		p.solutionA = "FOOO"
		return p
	}

	static func unsolved() -> Puzzle {
		Puzzle(id: 2, name: "A Hard One")
	}

	static func puzzles() -> Puzzles {
		let puzzles = Puzzles()

		puzzles.puzzles.append(PuzzlePreview.solved())
		puzzles.puzzles.append(PuzzlePreview.partSolved())
		puzzles.puzzles.append(PuzzlePreview.unsolved())

		return puzzles
	}

	static func processing() -> PuzzleProcessing {
		PuzzleProcessing.preview(puzzles: Self.puzzles())
	}
}
