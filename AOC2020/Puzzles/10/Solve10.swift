
import AOCLib
import Foundation

class Solve10: PuzzleSolver {
	let exampleFile = "Example10"
	let exampleFile2 = "Example10-2"
	let inputFile = "Input10"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "35" && solve(exampleFile2) == "220"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile) == "8" && solveB(exampleFile2) == "19208"
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		solveB(inputFile)
	}

	private func solve(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		let values = lines.compactMap { Int($0) }.sorted()
		var previous = 0
		var oneCount = 0
		var threeCount = 0
		for index in 0 ..< values.count {
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

	private func solveB(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		let values = lines.compactMap { Int($0) }.sorted()

		indexToCount = [:]
		let answer = recursiveAdapterCount(values: values, index: -1)
		return answer.description
	}

	func recursiveAdapterCount(values: [Int], index: Int) -> Int {
		// Look it up in our dictionary to save multiple computations
		if let val = indexToCount[index] {
			return val
		}

		// Valid next adapters, highest first (so that memoizing works better)
		let currentValue = index == -1 ? 0 : values[index]
		let possibleNexts = (index + 1 ... index + 3).filter { next in next < values.count && values[next] - currentValue < 4 }.reversed()

		// Base case, nowhere to go.
		if possibleNexts.isEmpty {
			return 1
		}

		var count = 0
		possibleNexts.forEach {
			let val = recursiveAdapterCount(values: values, index: $0)
			indexToCount[$0] = val
			count = count + val
		}
		return count
	}

	// Memoize the count for a given index.
	private var indexToCount: [Int: Int] = [:]
}
