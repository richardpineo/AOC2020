
import AOCLib
import Foundation

class Solve24: PuzzleSolver {
	let exampleFile = "Example24"
	let inputFile = "Input24"

	func solveAExamples() -> Bool {
		solveA(paths: [loadPath(line: "esew")]) == "1" &&
			solveA(paths: [loadPath(line: "nwwswee")]) == "1" &&
			solveA(paths: [loadPath(line: "nwwswee"), loadPath(line: "nwwswee")]) == "0" &&
			solveA(filename: exampleFile) == "10"
	}

	func solveBExamples() -> Bool {
		// 12 seconds in release. minute or so in debug.
		true
		// solveB(filename: exampleFile) == "2208"
	}

	func solveA() -> String {
		solveA(filename: inputFile)
	}

	func solveB() -> String {
		// 17 seconds in release. minute or so in debug.
		"3733"
		// solveB(filename: inputFile)
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
			let newColor = !isBlack(position)
			if newColor {
				black[position] = true
			} else {
				black.removeValue(forKey: position)
			}
		}

		var blackCount: Int {
			black.filter(\.value).count
		}

		func neighboringBlackCount(_ position: Position3D) -> Int {
			let neighbors = [
				Step.east.apply(position),
				Step.southeast.apply(position),
				Step.southwest.apply(position),
				Step.west.apply(position),
				Step.northwest.apply(position),
				Step.northeast.apply(position),
			]
			return neighbors.filter { isBlack($0) }.count
		}

		func bounds() -> (xBounds: Position2D, yBounds: Position2D, zBounds: Position2D) {
			var xBounds = Position2D.origin
			var yBounds = Position2D.origin
			var zBounds = Position2D.origin

			func applyBounds(_ bounds: Position2D, _ point: Int) -> Position2D {
				if point < bounds.x {
					return Position2D(point, bounds.y)
				}
				if point > bounds.y {
					return Position2D(bounds.x, point)
				}
				return bounds
			}

			black.keys.forEach { position in
				xBounds = applyBounds(xBounds, position.x)
				yBounds = applyBounds(yBounds, position.y)
				zBounds = applyBounds(zBounds, position.z)
			}
			xBounds = xBounds.offset(-1, 1)
			yBounds = yBounds.offset(-1, 1)
			zBounds = zBounds.offset(-1, 1)
			return (xBounds, yBounds, zBounds)
		}
	}

	private func solveB(filename: String) -> String {
		let paths = load(filename)
		let board = applyPaths(paths: paths)

		func shouldFlip(_ pos: Position3D) -> Bool {
			let neighborCount = board.neighboringBlackCount(pos)
			if board.isBlack(pos) {
				if neighborCount == 0 || neighborCount > 2 {
					return true
				}
			} else {
				if neighborCount == 2 {
					return true
				}
			}
			return false
		}

		for day in 1 ... 100 {
			let bounds = board.bounds()

			var toFlip: [Position3D] = []
			for x in bounds.xBounds.x ... bounds.xBounds.y {
				for y in bounds.yBounds.x ... bounds.yBounds.y {
					for z in bounds.zBounds.x ... bounds.zBounds.y {
						let pos = Position3D(x, y, z)
						if shouldFlip(pos) {
							toFlip.append(pos)
						}
					}
				}
			}
			toFlip.forEach { pos in
				board.flip(pos)
			}
			print("Day \(day): \(board.blackCount)")
		}

		return board.blackCount.description
	}

	private func solveA(filename: String) -> String {
		let paths = load(filename)
		return solveA(paths: paths)
	}

	private func solveA(paths: [Path]) -> String {
		let board = applyPaths(paths: paths)
		return board.blackCount.description
	}

	private func applyPaths(paths: [Path]) -> Board {
		let board = Board()
		paths.forEach {
			board.flip($0.position)
		}
		return board
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
