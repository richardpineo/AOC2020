
import Foundation

class Solve15: PuzzleSolver {
	let exampleFile = "Example15"

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
