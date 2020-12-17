
import Foundation

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
		""
	}

	struct State {
		var active: Set<Position3D> = .init()

		func morph() -> State {
			// determine all positions to consider
			let toConsider = active.reduce(Set<Position3D>()) { complete, pos in
				complete.union(pos.neighbors(includeSelf: true))
			}

			// Find new active positions
			let newActive = toConsider.filter { willBeActive($0) }

			// update the new state
			let morphed = State(active: newActive)
			return morphed
		}

		func willBeActive(_ pos: Position3D) -> Bool {
			let nearby = activeNeighbors(pos)
			if active.contains(pos) {
				return nearby == 2 || nearby == 3
			} else {
				return nearby == 3
			}
		}

		func activeNeighbors(_ pos: Position3D) -> Int {
			pos.neighbors(includeSelf: false).filter { active.contains($0) }.count
		}
	}

	private func solve(_ filename: String, is3D _: Bool) -> String {
		var state = load(filename)

		let iterations = 6
		for _ in 0 ..< iterations {
			state = state.morph()
		}

		return state.active.count.description
	}

	private func load(_ filename: String) -> State {
		let lines = FileHelper.load(filename)!
		var active = Set<Position3D>()
		// by convention, 'top-left' at 0,0,0
		for y in 0 ..< lines.count {
			for x in 0 ..< lines[y].count {
				if lines[y].character(at: x) == "#" {
					active.insert(Position3D(x, y, 0))
				}
			}
		}
		return State(active: active)
	}
}
