
import Foundation

class Solve11: PuzzleSolver {
	let exampleFile = "Example11"
	let inputFile = "Input11"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "37"
	}

	func solveBExamples() -> Bool {
		false
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

		func neighbors(_ seat: Position2D) -> Int {
			let neighbors = [
				Position2D(seat.x + 1, seat.y),
				Position2D(seat.x + 1, seat.y - 1),
				Position2D(seat.x + 1, seat.y + 1),
				Position2D(seat.x, seat.y - 1),
				Position2D(seat.x - 1, seat.y),
				Position2D(seat.x - 1, seat.y - 1),
				Position2D(seat.x - 1, seat.y + 1),
				Position2D(seat.x, seat.y + 1),
			]
			return neighbors.filter { query($0) == .occupied }.count
		}

		var uniqueId: String {
			let flat = seats.flatMap { key, value in
				"\(key.x),\(key.y),\(value.rawValue),"
			}
			return String(flat)
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

		var ids = Set<String>()
		while true {
			let id = seats.uniqueId
			if ids.contains(id) {
				// count occupied
				return seats.numOccupied.description
			}
			ids.insert(id)
			seats = seats.morph()
		}
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
