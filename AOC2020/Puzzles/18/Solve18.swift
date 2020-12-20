
import Foundation

class Solve18: PuzzleSolver {
	let example1 = "1 + 2 * 3 + 4 * 5 + 6"
	let example2 = "2 * 3 + (4 * 5)"
	let example3 = "5 + (8 * 3 + 9 + 3 * 4 * 3)"
	let example4 = "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"
	let example5 = "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"

	func solveAExamples() -> Bool {
		evaluate(example1) == 71 &&
		evaluate(example2) == 26 &&
		evaluate(example3) == 437 &&
		evaluate(example4) == 12240 &&
		evaluate(example5) == 13632
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		let inputFile1 = "Input18"
		let input = load(inputFile1)
		let sum = input.reduce(0) { $0 + evaluate($1) }
		return sum.description
	}

	func solveB() -> String {
		""
	}

	private func evaluate(_: String) -> Int {
		
		return 0
	}

	private func load(_ filename: String) -> [String] {
		let lines = FileHelper.load(filename)!
		return [lines.count.description]
	}
}
