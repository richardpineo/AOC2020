
import Foundation

class Solve11: PuzzleSolver {
	let exampleFile = "Example11"
	let inputFile = "Input11"

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

		static func fromChar(_ char: Character) -> SeatState? {
			char == "L" ? .open : nil
		}
	}

	class Seats {
		init(maxSeat: Position2D) {
			self.maxSeat = maxSeat
			states = [SeatState?](repeating: nil, count: maxSeat.arrayIndex(numCols: numCols))
		}

		var maxSeat: Position2D
		var numCols: Int {
			maxSeat.y - 1
		}

		private var states: [SeatState?] = []

		func assign(_ seat: Position2D, _ state: SeatState?) {
			states[seat.arrayIndex(numCols: numCols)] = state
		}

		func query(_ seat: Position2D) -> SeatState? {
			states[seat.arrayIndex(numCols: numCols)]
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
		func neighbors(_ seats: Seats, _ seat: Position2D) -> Int {
			Self.neighborOffsets.filter {
				let newSeat = seat.offset($0)
				return seats.validSeat(pos: newSeat) && seats.query(newSeat) == .occupied
			}.count
		}

		let pos = Position2D(from: index, numCols: seats.numCols)
		switch seats.query(pos) {
		case .open:
			return neighbors(seats, pos) == 0 ? .occupied : .open

		case .occupied:
			return neighbors(seats, pos) >= 4 ? .open : .occupied

		case .none:
			return nil
		}
	}

	func transformB(seats: Seats, index: Int) -> SeatState? {
		func visible(_ seats: Seats, _ seat: Position2D) -> Int {
			Self.neighborOffsets.filter { direction in
				var trySeat = seat.offset(direction)
				var toCheck = [Position2D]()
				while seats.validSeat(pos: trySeat) {
					toCheck.append(trySeat)
					trySeat = trySeat.offset(direction)
				}
				
				let firstSeat = toCheck.first { seats.query($0) != nil }
				guard let hasSeat = firstSeat else {
					return false
				}
				return seats.query(hasSeat) == .occupied
			}.count
		}
		
		let pos = Position2D(from: index, numCols: seats.numCols)
		switch seats.query(pos) {
		case .open:
			return visible(seats, pos) == 0 ? .occupied : .open

		case .occupied:
			return visible(seats, pos) >= 5 ? .open : .occupied

		case .none:
			return nil
		}
	}

	private func solve(_ filename: String, transform: (Seats, Int) -> SeatState?) -> String {
		var seats = loadSeats(filename)

		var uniqueFilled = Set<[Int]>()
		while true {
			let unique = seats.uniqueId
			if uniqueFilled.contains(unique) {
				// count occupied
				return seats.numOccupied.description
			}
			uniqueFilled.insert(unique)
			seats = seats.morph(transform: transform)
		}
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
