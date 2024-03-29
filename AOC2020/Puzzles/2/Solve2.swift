
import AOCLib
import Foundation

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example2") == "2"
	}

	func solveBExamples() -> Bool {
		solveB("Example2") == "1"
	}

	var answerA = "643"
	var answerB = "388"

	func solveA() -> String {
		solveA("Input2")
	}

	func solveB() -> String {
		solveB("Input2")
	}

	private func solveA(_ filename: String) -> String {
		let tokens = FileHelper.loadAndTokenize(filename)
		let passing = tokens.filter { toke in
			toke.count == 3 && passesA(toke[0], toke[1], toke[2])
		}

		return passing.count.description
	}

	private func passesA(_ count: String, _ character: String, _ password: String) -> Bool {
		let counts = count.components(separatedBy: "-")
		if counts.count != 2 {
			return false
		}
		let minCount = Int(counts[0])!
		let maxCount = Int(counts[1])!

		let match = character.character(at: 0)

		let occurs = password.filter { $0 == match }
		let occursCount = occurs.count
		return occursCount >= minCount && occursCount <= maxCount
	}

	private func solveB(_ filename: String) -> String {
		let tokens = FileHelper.loadAndTokenize(filename)
		let passing = tokens.filter { toke in
			toke.count == 3 && passesB(toke[0], toke[1], toke[2])
		}

		return passing.count.description
	}

	private func passesB(_ count: String, _ character: String, _ password: String) -> Bool {
		let counts = count.components(separatedBy: "-")
		if counts.count != 2 {
			return false
		}
		let firstPosition = Int(counts[0])! - 1
		let secondPosition = Int(counts[1])! - 1

		let match = character.character(at: 0)

		let passFirst = password.character(at: firstPosition)
		let passSecond = password.character(at: secondPosition)

		return (match == passFirst) != (match == passSecond)
	}
}
