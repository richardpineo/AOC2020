
import Foundation

class Solve3: PuzzleSolver {
	private let slopesA = [Position2D(3,1)]
	private let slopesB = [
		Position2D(1,1),
		Position2D(3,1),
		Position2D(5,1),
		Position2D(7,1),
		Position2D(1,2)
	]

	func solveAExamples() -> Bool {
		return "7" == solve("Example3", slopes: slopesA)
	}
	
	func solveBExamples() -> Bool {
		return "336" == solve("Example3", slopes: slopesB)
	}
	
	func solveA() -> String {
		solve( "Input3", slopes: slopesA)
	}

	
	func solveB() -> String {
		solve( "Input3", slopes: slopesB)
	}
	
	private func isTree(_ lines: [String], _ pos: Position2D) -> Bool {
		if pos.y >= lines.count {
			return false
		}
		let line = lines[pos.y]
		let tree = line[line.index(line.startIndex, offsetBy: pos.x)]
		return tree == "#"
	}

	private func solve(_ filename: String, slopes: [Position2D]) -> String {
		let lines = FileHelper.load(filename)!
		let width = lines[0].count
		let height = lines.count
		var treeCounts = [Int]()
		for index in 0..<slopes.count {
			var treeCount = 0
			var pos = Position2D(0, 0)
			while pos.y <= height {
				if isTree(lines, pos) {
					treeCount += 1
				}
				pos = pos.offset(slopes[index])
				pos = Position2D(pos.x % width, pos.y)
			}
			treeCounts.append(treeCount)
		}
		let answer = treeCounts.reduce(1, { x, y in
			x * y
		})
		return answer.description
	}
}
