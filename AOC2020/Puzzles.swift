
import Foundation

class Puzzles: ObservableObject {
	static func application() -> Puzzles {
		
		let puzzles = Puzzles()
		
		puzzles.puzzles = [
			Puzzle(id: 0, name: "The first one"),
			Puzzle(id: 1, name: "The second one"),
		]

		for id in puzzles.puzzles.count ... 30 {
			puzzles.puzzles.append(Puzzle(id: id, name: "Not revealed"))
		}

		// Load the previous answers
		for id in 0 ... 30 {
			puzzles.puzzles[id].solutionA = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(id: id, isA: true))
			puzzles.puzzles[id].solutionA = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(id: id, isA: false))
		}
		
		return puzzles
	}
	
	static func preview() -> Puzzles {
		let puzzles = Puzzles()
		
		puzzles.puzzles.append( PuzzlePreview.solved)
		puzzles.puzzles.append( PuzzlePreview.partSolved)
		puzzles.puzzles.append( PuzzlePreview.unsolved)

		return puzzles
	}

	@Published var puzzles: [Puzzle] = []
}
