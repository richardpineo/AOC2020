
import Foundation

class Solve24: PuzzleSolver {
	let exampleFile = "Example24"
	let inputFile = "Input24"

	func solveAExamples() -> Bool {
		solve(paths: [loadPath(line: "esew")]) == "1" &&
			solve(paths: [loadPath(line: "nwwswee")]) == "1" &&
			solve(paths: [loadPath(line: "nwwswee"), loadPath(line: "nwwswee")]) == "0" &&
			solve(filename: exampleFile) == "10"
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		// 313 too high
		solve(filename: inputFile)
	}

	func solveB() -> String {
		""
	}

	// Use cube : https://www.redblobgames.com/grids/hexagons/
	enum Step {
		case east
		case southeast
		case southwest
		case west
		case northwest
		case northeast

		func apply(_ position: Position3D) -> Position3D {
			switch self {
			case .east: return position.offset(1, -1, 0)
			case .southeast: return position.offset(0, -1, 1)
			case .southwest: return position.offset(-1, 0, 1)
			case .west: return position.offset(-1, 1, 0)
			case .northwest: return position.offset(0, 1, -1)
			case .northeast: return position.offset(1, 0, -1)
			}
		}
	}

	class Path {
		var steps = [Step]()

		var position: Position3D {
			// Walk the path
			var pos = Position3D.origin
			steps.forEach {
				pos = $0.apply(pos)
			}
			return pos
		}
	}

	class Board {
		private var black = [Position3D: Bool]()

		func isBlack(_ position: Position3D) -> Bool {
			black[position] ?? false
		}

		func flip(_ position: Position3D) {
			black[position] = !isBlack(position)
		}

		var blackCount: Int {
			black.filter { $0.value }.count
		}
	}

	private func solve(filename: String) -> String {
		let paths = load(filename)
		return solve(paths: paths)
	}

	private func solve(paths: [Path]) -> String {
		let board = Board()
		paths.forEach {
			board.flip($0.position)
		}

		return board.blackCount.description
	}

	private func loadPath(line: String) -> Path {
		let path = Path()

		var index = 0
		while index < line.count {
			switch line.character(at: index) {
			case "e":
				path.steps.append(.east)
			case "w":
				path.steps.append(.west)
			case "n":
				index += 1
				switch line.character(at: index) {
				case "e": path.steps.append(.northeast)
				case "w": path.steps.append(.northwest)
				default: break
				}
			case "s":
				index += 1
				switch line.character(at: index) {
				case "e": path.steps.append(.southeast)
				case "w": path.steps.append(.southwest)
				default: break
				}

			default: break
			}
			index += 1
		}
		return path
	}

	private func load(_ filename: String) -> [Path] {
		let lines = FileHelper.load(filename)!.filter { !$0.isEmpty }
		var paths = [Path]()
		lines.forEach { line in
			let path = loadPath(line: line)
			paths.append(path)
		}

		return paths
	}
}
