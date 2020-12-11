
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
		solve(inputFile)
	}

	func solveB() -> String {
		""
	}

	private func solve(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		let values = lines.compactMap { Int($0) }.sorted()
		var previous = 0
		var oneCount = 0
		var threeCount = 0
		for index in 0..<values.count {
			switch values[index] - previous {
			case 1:
				oneCount = oneCount + 1
			case 3:
				threeCount = threeCount + 1
			default:
				break
			}
			previous = values[index]
		}
		threeCount = threeCount + 1
		let answer = oneCount * threeCount
		return answer.description
	}
}
