
import Foundation

protocol PuzzleSolver {
	func solveA() -> String
	func solveB() -> String

	func solveAExamples() -> Bool
	func solveBExamples() -> Bool
}

class EmptySolver: PuzzleSolver {
	func solveA() -> String {
		""
	}

	func solveB() -> String {
		""
	}

	func solveAExamples() -> Bool {
		false
	}

	func solveBExamples() -> Bool {
		false
	}
}
