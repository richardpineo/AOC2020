
import Foundation

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		return "7" == solveA("Example3")
	}
	
	func solveBExamples() -> Bool {
		return "" == solveB("Example3")
	}
	
	func solveA() -> String {
		solveA( "Input3")
	}

	
	func solveB() -> String {
		solveB( "Input3")
	}
	
	private func isTree(_ lines: [String], _ pos: Position2D) -> Bool {
		if pos.y >= lines.count {
			return false
		}
		let line = lines[pos.y]
		let tree = line[line.index(line.startIndex, offsetBy: pos.x)]
		return tree == "#"
	}

	private func solveA(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		let width = lines[0].count
		let height = lines.count
		
		var pos = Position2D(0, 0)
		let step = Position2D(3, 1)

		var treeCount = 0
		while pos.y <= height {
			if isTree(lines, pos) {
				treeCount += 1
			}
			pos = pos.offset(step)
			pos = Position2D(pos.x % width, pos.y)
		}
		
		return treeCount.description
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
