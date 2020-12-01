
import Foundation

enum SolutionState {
	case unsolved
	case solved
	case solvedA
}

struct Puzzle: Identifiable {
	var id: Int
	var name: String

	var state: SolutionState = .unsolved

	var inputA: String?
	var inputB: String?

	var solutionA: String? {
		didSet {
			UserDefaults.standard.set(solutionA, forKey: Puzzle.userDefaultKey(id: id, isA: true))
		}
	}

	var solutionB: String? {
		didSet {
			UserDefaults.standard.set(solutionB, forKey: Puzzle.userDefaultKey(id: id, isA: false))
		}
	}

	static func userDefaultKey(id: Int, isA: Bool) -> String {
		"puzzle_\(id)_\(isA ? "A" : "B")"
	}
}
