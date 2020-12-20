
import Foundation

class Solve20: PuzzleSolver {
	let exampleFile = "Example20"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "20899048083289"
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
