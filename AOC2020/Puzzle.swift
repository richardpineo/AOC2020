
import Foundation

enum SolutionState {
	case unsolved
	case solved
	case solvedA
}

struct Puzzle: Identifiable {
	init(id: Int, name: String = "", maker: (() -> PuzzleSolver)? = nil) {
		self.id = id
		self.name = name
		makeSolver = maker

		solutionA = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(id: id, isA: true)) ?? ""
		solutionB = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(id: id, isA: false)) ?? ""
	}

	var id: Int
	var name: String
	var makeSolver: (() -> PuzzleSolver)?

	var state: SolutionState {
		if solutionA.isEmpty {
			return .unsolved
		}
		return solutionB.isEmpty ? .solvedA : .solved
	}
	
	var solutionA: String {
		didSet {
			UserDefaults.standard.set(solutionA, forKey: Puzzle.userDefaultKey(id: id, isA: true))
		}
	}

	var solutionB: String {
		didSet {
			UserDefaults.standard.set(solutionB, forKey: Puzzle.userDefaultKey(id: id, isA: false))
		}
	}

	private static func userDefaultKey(id: Int, isA: Bool) -> String {
		"puzzle_\(id)_\(isA ? "A" : "B")"
	}
}
