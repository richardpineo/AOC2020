
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
		solveB(inputFile, chunkSize: 25)
	}

	private func solve(_ filename: String, chunkSize: Int) -> String {
		let values = FileHelper.load(filename)!.compactMap { Int($0) }
		if let invalid = findInvalid(values: values, chunkSize: chunkSize) {
			return invalid.description
		}
		return "nope"
	}
	
	private func solveB(_ filename: String, chunkSize: Int) -> String {
		let values = FileHelper.load(filename)!.compactMap { Int($0) }
		guard let invalid = findInvalid(values: values, chunkSize: chunkSize) else {
			return "notfound"
		}
	
		for start in 0..<values.count {
			var check = 0
			for count in start...values.count {
				check = check + values[count]
				if check == invalid {
					// Found the invalid answer, crack the code.
					let candidates = values[start...count]
					let answer = candidates.min()! + candidates.max()!
					return answer.description
				}
				else if check > invalid {
					// kill the loop.
					break
				}
			}
		}
		return "no answer found"
	}
	
	private func findInvalid(values: [Int], chunkSize: Int) -> Int? {
		for consider in chunkSize..<values.count {
			let range = consider-chunkSize ..< consider
			if !doesSumExist(values: values, value: values[consider], range: range) {
				return values[consider]
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
