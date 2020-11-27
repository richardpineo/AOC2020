
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

	var solutionA: String?
	var solutionB: String?
}
