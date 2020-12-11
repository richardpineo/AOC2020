
import Foundation

class Solve10: PuzzleSolver {
	let exampleFile = "Example10"
	let exampleFile2 = "Example10-2"
	let inputFile = "Input10"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "35" && solve(exampleFile2) == "220"
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
