
import Foundation

protocol Solve11Delegate {
	// nil is passed on completion.
	func newState(seats: Solve11.Seats?)
}

class Solve11: PuzzleSolver {
	let exampleFile = "Example11"
	let inputFile = "Input11"

	var delegate: Solve11Delegate?

	func solveAExamples() -> Bool {
		solve(exampleFile, transform: transformA) == "37"
	}

	func solveBExamples() -> Bool {
		solve(exampleFile, transform: transformB) == "26"
	}

	func solveA() -> String {
		solve(inputFile, transform: transformA)
	}

	func solveB() -> String {
		solve(inputFile, transform: transformB)
	}

	enum SeatState: Int {
		case open
		case occupied
	}

	class Seats {
		init(maxSeat: Position2D) {
			self.maxSeat = maxSeat
			states = [SeatState?](repeating: nil, count: maxSeat.arrayIndex(numCols: numCols))
		}

		var maxSeat: Position2D
		var numCols: Int {
			maxSeat.y
		}

		var maxIndex: Int {
			maxSeat.offset(0, -1).arrayIndex(numCols: numCols)
		}

		private var states: [SeatState?] = []

		func assign(_ seat: Position2D, _ state: SeatState?) {
			states[seat.arrayIndex(numCols: numCols)] = state
		}

		func query(_ seat: Position2D) -> SeatState? {
			query(at: seat.arrayIndex(numCols: numCols))
		}

		func query(at index: Int) -> SeatState? {
			states[index]
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

		func morph(transform: (Seats, Int) -> SeatState?) -> Seats {
			let morphed = Seats(maxSeat: maxSeat)

			let maxArrayIndex = maxSeat.arrayIndex(numCols: numCols)
			for index in 0 ..< maxArrayIndex {
				if let newState = transform(self, index) {
					morphed.states[index] = newState
				}
			}
			return morphed
		}
	}

	static let neighborOffsets = [
		Position2D(1, 0),
		Position2D(1, -1),
		Position2D(1, 1),
		Position2D(0, -1),
		Position2D(0, 1),
		Position2D(-1, 0),
		Position2D(-1, -1),
		Position2D(-1, 1),
	]

	func transformA(seats: Seats, index: Int) -> SeatState? {
		func countNeighbors(_ seats: Seats, _ seat: Position2D) -> Int {
			func neighborOccupied(_ direction: Position2D) -> Bool {
				let newSeat = seat.offset(direction)
				return seats.validSeat(pos: newSeat) && seats.query(newSeat) == .occupied
			}
			return Self.neighborOffsets.reduce(0) { $0 + (neighborOccupied($1) ? 1 : 0) }
		}

		let pos = Position2D(from: index, numCols: seats.numCols)
		guard let state = seats.query(pos) else {
			return nil
		}

		let neighborCount = countNeighbors(seats, pos)
		if state == .open {
			return neighborCount == 0 ? .occupied : .open
		} else {
			return neighborCount >= 4 ? .open : .occupied
		}
	}

	func transformB(seats: Seats, index: Int) -> SeatState? {
		func visibleInDirection(_ seats: Seats, _ seat: Position2D, _ direction: Position2D) -> Bool {
			var trySeat = seat.offset(direction)
			while seats.validSeat(pos: trySeat) {
				if let state = seats.query(trySeat) {
					return state == .occupied
				}
				trySeat = trySeat.offset(direction)
			}
			return false
		}

		func visibleCount(_ seats: Seats, _ seat: Position2D) -> Int {
			Self.neighborOffsets.reduce(0) { $0 + (visibleInDirection(seats, seat, $1) ? 1 : 0) }
		}

		let pos = Position2D(from: index, numCols: seats.numCols)
		guard let state = seats.query(pos) else {
			return nil
		}
		let visibleNeighbors = visibleCount(seats, pos)
		if state == .open {
			return visibleNeighbors == 0 ? .occupied : .open
		} else {
			return visibleNeighbors >= 5 ? .open : .occupied
		}
	}

	private func solve(_ filename: String, transform: (Seats, Int) -> SeatState?) -> String {
		var seats = loadSeats(filename)

		var lastSeats: [Int]?
		while true {
			delegate?.newState(seats: seats)

			let unique = seats.uniqueId
			if lastSeats == unique {
				delegate?.newState(seats: nil)
				// count occupied
				return seats.numOccupied.description
			}
			lastSeats = unique
			seats = seats.morph(transform: transform)
		}
	}

	private func loadSeats(_ filename: String) -> Seats {
		let lines = FileHelper.load(filename)!.filter { !$0.isEmpty }
		let numRow = lines[0].count
		let numCol = lines.count
		let maxSeat = Position2D(numRow, numCol)
		let seats = Seats(maxSeat: maxSeat)

		func fromChar(_ char: Character) -> SeatState? {
			char == "L" ? .open : nil
		}

		for y in 0 ..< lines.count {
			let line = lines[y]
			for x in 0 ..< line.count {
				let char = line.character(at: x)
				if let state = fromChar(char) {
					seats.assign(Position2D(x, y), state)
				}
			}
		}
		return seats
	}
}
