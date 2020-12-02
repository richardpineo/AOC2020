
import Foundation

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		return "2" == solveA("Example2")
	}
	
	func solveBExamples() -> Bool {
		return "1" == solveB("Example2")
	}
	
	func solveA() -> String {
		solveA( "Input2")
	}

	
	func solveB() -> String {
		solveB( "Input2")
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
		
		let match = character[character.index(character.startIndex, offsetBy: 0)]

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
		
		let match = character[character.index(character.startIndex, offsetBy: 0)]

		let passFirst = password[password.index(password.startIndex, offsetBy: firstPosition)]
		let passSecond = password[password.index(password.startIndex, offsetBy: secondPosition)]

		return (match == passFirst) != (match == passSecond)
	}
}
