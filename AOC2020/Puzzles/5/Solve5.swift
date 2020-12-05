
import Foundation

class Solve5: PuzzleSolver {
	
	let exampleFile = "Example5"

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
