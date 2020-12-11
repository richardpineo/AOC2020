
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
		private var seats: [Position2D: SeatState] = [:]

		func assign(_ seat: Position2D, _ state: SeatState?) {
			seats[seat] = state
		}

		func query(_ seat: Position2D) -> SeatState? {
			seats[seat]
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
			return Self.neighborOffsets.filter { query(seat.offset($0)) == .occupied }.count
		}

		var filledSeats: [Position2D] {
			let occ = Array(seats.filter { $0.value == .occupied }.keys)
			return occ.sorted()
		}

		var numOccupied: Int {
			seats.filter { $0.value == .occupied }.count
		}

		func morph() -> Seats {
			let morphed = Seats()
			seats.forEach {
				switch $0.value {
				case .open:
					let nearby = self.neighbors($0.key)
					morphed.assign($0.key, nearby == 0 ? .occupied : .open)

				case .occupied:
					let nearby = self.neighbors($0.key)
					morphed.assign($0.key, nearby >= 4 ? .open : .occupied)
				}
			}
			return morphed
		}
	}

	private func solve(_ filename: String) -> String {
		var seats = loadSeats(filename)

		var uniqueFilled = Set<[Position2D]>()
		while true {
			let filled = seats.filledSeats
			if uniqueFilled.contains(filled) {
				// count occupied
				return seats.numOccupied.description
			}
			uniqueFilled.insert(filled)
			seats = seats.morph()
		}
	}
	
	private func solveB(_ filename: String) -> String {
		return "dunno"
	}

	private func loadSeats(_ filename: String) -> Seats {
		let lines = FileHelper.load(filename)!
		let seats = Seats()
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
