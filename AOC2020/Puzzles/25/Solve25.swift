
import Foundation

class Solve25: PuzzleSolver {
	let exampleFile = "Example25"

	func solveAExamples() -> Bool {
		solve(exampleFile) == ""
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		""
	}

	func solveB() -> String {
		""
	}

	private func solve(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		return lines.count.description
	}
}