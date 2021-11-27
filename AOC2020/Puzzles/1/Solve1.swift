
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example1") == "514579"
	}

	func solveBExamples() -> Bool {
		solveB("Example1") == "241861950"
	}

	func solveA() -> String {
		solveA("Input1")
	}

	func solveB() -> String {
		solveB(status: nil)
	}

	func solveB(status: Solve1Status?) -> String {
		solveB("Input1", status)
	}

	private func solveA(_ filename: String) -> String {
		guard let example = FileHelper.load(filename) else {
			return ""
		}

		let numbers = example.compactMap { Int($0) }

		for index in 0 ..< numbers.count {
			for index2 in index ..< numbers.count {
				let val = numbers[index] + numbers[index2]
				if val == 2020 {
					return (numbers[index] * numbers[index2]).description
				}
			}
		}
		return ""
	}

	private func solveB(_ filename: String, _ status: Solve1Status? = nil) -> String {
		guard let example = FileHelper.load(filename) else {
			return ""
		}

		let numbers = example.compactMap { Int($0) }

		if let stat = status {
			stat.numbers = numbers
		}

		for index in 0 ..< numbers.count {
			for index2 in index ..< numbers.count {
				for index3 in index ..< numbers.count {
					let val = numbers[index] + numbers[index2] + numbers[index3]
					if val == 2020 {
						if let stat = status {
							stat.answerIndices = [index, index2, index3]
						}
						return (numbers[index] * numbers[index2] * numbers[index3]).description
					}
				}
			}
		}
		return ""
	}
}
