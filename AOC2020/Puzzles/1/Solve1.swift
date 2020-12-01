
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		return "514579" == solveA(filename: "Example")
	}
	
	func solveBExamples() -> Bool {
		return "241861950" == solveB(filename: "Example")
	}
	
	func solveA() -> String {
		solveA(filename: "InputA")
	}

	func solveB() -> String {
		solveB(filename: "InputA")
	}

	private func solveA(filename: String) -> String {
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

	private func solveB(filename: String) -> String {
		guard let example = FileHelper.load(filename) else {
			return ""
		}

		let numbers = example.compactMap { Int($0) }

		for index in 0 ..< numbers.count {
			for index2 in index ..< numbers.count {
				for index3 in index ..< numbers.count {
					let val = numbers[index] + numbers[index2] + numbers[index3]
					if val == 2020 {
						return (numbers[index] * numbers[index2] * numbers[index3]).description
					}
				}
			}
		}
		return ""
	}
}
