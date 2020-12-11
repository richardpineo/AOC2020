
import Foundation

class Solve11: PuzzleSolver {
	let exampleFile = "Example11"
	let inputFile = "Input11"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "37"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile) == "26"
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		""
	}

	enum SeatState: Int {
		case open
		case occupied

		static func fromChar(_ char: Character) -> SeatState? {
			char == "L" ? .open : nil
		}
	}

	class Seats {
		init(maxSeat: Position2D) {
			self.maxSeat = maxSeat
			states = [SeatState?](repeating: nil, count: maxSeat.arrayIndex(numCols: numCols))
		}

		private var maxSeat: Position2D
		private var numCols: Int {
			maxSeat.y - 1
		}

		private var states: [SeatState?] = []

		func assign(_ seat: Position2D, _ state: SeatState?) {
			states[seat.arrayIndex(numCols: numCols)] = state
		}

		func query(_ seat: Position2D) -> SeatState? {
			states[seat.arrayIndex(numCols: numCols)]
		}

		private static let neighborOffsets = [
			Position2D(1, 0),
			Position2D(1, -1),
			Position2D(1, 1),
			Position2D(0, -1),
			Position2D(0, 1),
			Position2D(-1, 0),
			Position2D(-1, -1),
			Position2D(-1, 1),
		]

		func neighbors(_ seat: Position2D) -> Int {
			Self.neighborOffsets.filter {
				let newSeat = seat.offset($0)
				return validSeat(pos: newSeat) && query(newSeat) == .occupied
			}.count
		}

		func validSeat(pos: Position2D) -> Bool {
			pos.x >= 0 && pos.x < maxSeat.x && pos.y >= 0 && pos.y < maxSeat.y
		}

		var uniqueId: [Int] {
			let maxArrayIndex = maxSeat.arrayIndex(numCols: numCols)
			var filled: [Int] = []
			for index in 0 ..< maxArrayIndex {
				if states[index] == .occupied {
					filled.append(index)
				}
			}
			return filled
		}

		var numOccupied: Int {
			states.filter { $0 == .occupied }.count
		}

		func morph() -> Seats {
			let morphed = Seats(maxSeat: maxSeat)

			let maxArrayIndex = maxSeat.arrayIndex(numCols: numCols)
			for index in 0 ..< maxArrayIndex {
				let pos = Position2D(from: index, numCols: numCols)
				switch query(pos) {
				case .open:
					let nearby = neighbors(pos)
					morphed.assign(pos, nearby == 0 ? .occupied : .open)

				case .occupied:
					let nearby = neighbors(pos)
					morphed.assign(pos, nearby >= 4 ? .open : .occupied)

				case .none:
					break
				}
			}
			return morphed
		}
	}

	private func solve(_ filename: String) -> String {
		var seats = loadSeats(filename)

		var uniqueFilled = Set<[Int]>()
		while true {
			let unique = seats.uniqueId
			if uniqueFilled.contains(unique) {
				// count occupied
				return seats.numOccupied.description
			}
			uniqueFilled.insert(unique)
			seats = seats.morph()
		}
	}

	private func solveB(_: String) -> String {
		"dunno"
	}

	private func loadSeats(_ filename: String) -> Seats {
		let lines = FileHelper.load(filename)!
		let numRow = lines[0].count
		let numCol = lines.count
		let maxSeat = Position2D(numRow, numCol)
		let seats = Seats(maxSeat: maxSeat)
		for y in 0 ..< lines.count {
			let line = lines[y]
			for x in 0 ..< line.count {
				let char = line.character(at: x)
				if let state = SeatState.fromChar(char) {
					seats.assign(Position2D(x, y), state)
				}
			}
		}
		return seats
	}
}
