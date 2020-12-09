
import Foundation

class Solve9: PuzzleSolver {
	let exampleFile = "Example9"
	let inputFile = "Input9"

	func solveAExamples() -> Bool {
		solve(exampleFile, chunkSize: 5) == "127"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile, chunkSize: 5) == "62"
	}

	func solveA() -> String {
		solve(inputFile, chunkSize: 25)
	}

	func solveB() -> String {
		""
	}

	private func solve(_ filename: String, chunkSize: Int) -> String {
		let values = FileHelper.load(filename)!.compactMap { Int($0) }
		guard let invalid = findInvalid(values: values, chunkSize: chunkSize) else {
			return "notfound"
		}
		return values[invalid.endIndex].description
	}
	
	private func solveB(_ filename: String, chunkSize: Int) -> String {
	return ""
	}
	
	private func findInvalid(values: [Int], chunkSize: Int) -> Range<Int>? {
		for consider in chunkSize..<values.count {
			let range = consider-chunkSize ..< consider
			if !doesSumExist(values: values, value: values[consider], range: range) {
				return range
			}
		}
		return nil
	}
	
	private func doesSumExist(values: [Int], value: Int, range: Range<Int>) -> Bool {
		for first in range {
			for second in first+1...range.endIndex {
				if values[first] + values[second] == value {
					return true
				}
			}
		}
		return false
	}
}
