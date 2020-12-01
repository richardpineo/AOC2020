

import Foundation

class PuzzlePreview {
	static let solved = Puzzle(id: 0, name: "An easy one", state: .solved, solutionA: "69420", solutionB: "12345")
	static let partSolved = Puzzle(id: 1, name: "Almost! This one has a really long name", state: .solvedA, solutionA: "FOOO")
	static let unsolved = Puzzle(id: 2, name: "A Hard One", state: .unsolved)

	static func puzzles() -> Puzzles {
		let puzzles = Puzzles()

		puzzles.puzzles.append(PuzzlePreview.solved)
		puzzles.puzzles.append(PuzzlePreview.partSolved)
		puzzles.puzzles.append(PuzzlePreview.unsolved)

		return puzzles
	}

	static func processing() -> PuzzleProcessing {
		PuzzleProcessing.preview(puzzles: Self.puzzles())
	}
}
