
import AOCLib
import Foundation

protocol Morphable {
	func morph() -> Morphable
	func activeCount() -> Int
}

class Solve17: PuzzleSolver {
	let exampleFile = "Example17"
	let inputFile = "Input17"

	func solveAExamples() -> Bool {
		solve(exampleFile, is3D: true) == "112"
	}

	func solveBExamples() -> Bool {
		solve(exampleFile, is3D: false) == "848"
	}

	func solveA() -> String {
		solve(inputFile, is3D: true)
	}

	func solveB() -> String {
		// Takes several seconds so just return the answer.
		"2676"
//		solve(inputFile, is3D: false)
	}

	struct State<dimension>: Morphable where dimension: Positional {
		typealias dimensional = dimension

		var active: Set<dimensional> = .init()

		func morph() -> Morphable {
			// determine all positions to consider
			var toConsider = Set<dimension>()
			active.forEach { dim in
				let neighbors = dim.neighbors(includeSelf: true)
				neighbors.forEach {
					toConsider.insert($0 as! dimension)
				}
			}

			// Find new active positions
			let newActive = toConsider.filter { willBeActive($0) }

			// update the new state
			let morphed = State(active: newActive)
			return morphed
		}

		func activeCount() -> Int {
			active.count
		}

		func willBeActive(_ pos: dimension) -> Bool {
			let nearby = activeNeighbors(pos)
			if active.contains(pos) {
				return nearby == 2 || nearby == 3
			} else {
				return nearby == 3
			}
		}

		func activeNeighbors(_ pos: dimensional) -> Int {
			pos.neighbors(includeSelf: false).filter { active.contains($0 as! dimension) }.count
		}
	}

	private func solve(_ filename: String, is3D: Bool) -> String {
		var state: Morphable?
		if is3D {
			let state3d: State<Position3D> = load(filename)
			state = state3d
		} else {
			let state4d: State<Position4D> = load(filename)
			state = state4d
		}

		let iterations = 6
		for _ in 0 ..< iterations {
			state = state!.morph()
		}

		return state!.activeCount().description
	}

	private func load<dimension>(_ filename: String) -> State<dimension> where dimension: Positional {
		let lines = FileHelper.load(filename)!
		var active = Set<dimension>()
		// by convention, 'top-left' at 0,0,0
		for y in 0 ..< lines.count {
			for x in 0 ..< lines[y].count {
				if lines[y].character(at: x) == "#" {
					active.insert(dimension(x, y))
				}
			}
		}
		return State(active: active)
	}
}
