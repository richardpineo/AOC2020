
import Foundation

class SolveX: PuzzleSolver {
	
	let exampleFile = "ExampleX"

	func solveAExamples() -> Bool {
		solve(exampleFile) == ""
	}

	func solveBExamples() -> Bool {
		return false
	}

	func solveA() -> String {
		return ""
	}

	func solveB() -> String {
		return ""
	}


	private func solve(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		return ""
	}
}
