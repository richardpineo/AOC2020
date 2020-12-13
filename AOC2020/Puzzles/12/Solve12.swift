
import Foundation

protocol Solve12Delegate {
	// nil is passed on completion. waypoint is nil for part A
	func shipMoved(ship: Solve12.Ship?, waypoint: Position2D?)
}

class Solve12: PuzzleSolver {
	let exampleFile = "Example12"
	let inputFile = "Input12"

	var delegate: Solve12Delegate?

	func solveAExamples() -> Bool {
		solve(exampleFile) == "25"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile) == "286"
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		solveB(inputFile)
	}

	enum Command: Character {
		case moveNorth = "N"
		case moveSouth = "S"
		case moveEast = "E"
		case moveWest = "W"
		case turnLeft = "L"
		case turnRight = "R"
		case moveForward = "F"
	}

	struct Step {
		var command: Command
		var value: Int
	}

	static func numTurns(_ degrees: Int) -> Int {
		degrees / 90
	}

	struct Ship {
		var position: Position2D
		var heading: Heading
	}

	private func solve(_ filename: String) -> String {
		let steps = loadSteps(filename)
		var ship = Ship(position: .origin, heading: .east)

		func forwards(_ distance: Int) -> Ship {
			switch ship.heading {
			case .north: return step(.init(command: .moveNorth, value: distance))
			case .south: return step(.init(command: .moveSouth, value: distance))
			case .east: return step(.init(command: .moveEast, value: distance))
			case .west: return step(.init(command: .moveWest, value: distance))
			}
		}

		func step(_ step: Step) -> Ship {
			switch step.command {
			case .moveNorth: return Ship(position: ship.position.offset(0, step.value), heading: ship.heading)
			case .moveSouth: return Ship(position: ship.position.offset(0, -step.value), heading: ship.heading)
			case .moveEast: return Ship(position: ship.position.offset(step.value, 0), heading: ship.heading)
			case .moveWest: return Ship(position: ship.position.offset(-step.value, 0), heading: ship.heading)
			case .turnLeft: return Ship(position: ship.position, heading: ship.heading.turnLeft(Self.numTurns(step.value)))
			case .turnRight: return Ship(position: ship.position, heading: ship.heading.turnRight(Self.numTurns(step.value)))
			case .moveForward: return forwards(step.value)
			}
		}

		delegate?.shipMoved(ship: ship, waypoint: nil)
		steps.forEach {
			ship = step($0)
			delegate?.shipMoved(ship: ship, waypoint: nil)
		}
		delegate?.shipMoved(ship: nil, waypoint: nil)
		return ship.position.cityDistance().description
	}

	private func solveB(_ filename: String) -> String {
		let steps = loadSteps(filename)

		var ship = Ship(position: .origin, heading: .east)
		var waypoint = Position2D(10, 1)

		func rotateWaypoint(rightwards: Bool, degrees: Int) {
			var wp = waypoint
			for _ in 0 ..< Self.numTurns(degrees) {
				if rightwards {
					wp = Position2D(wp.y, -wp.x)
				} else {
					wp = Position2D(-wp.y, wp.x)
				}
			}
			waypoint = wp
		}

		func moveWaypoint(times: Int) {
			var pos = ship.position
			for _ in 0 ..< times {
				pos = pos.offset(waypoint)
			}
			ship = Ship(position: pos, heading: ship.heading)
		}

		func wayPointStep(_ step: Step) {
			switch step.command {
			case .moveNorth: waypoint = waypoint.offset(0, step.value)
			case .moveSouth: waypoint = waypoint.offset(0, -step.value)
			case .moveEast: waypoint = waypoint.offset(step.value, 0)
			case .moveWest: waypoint = waypoint.offset(-step.value, 0)
			case .turnLeft: rotateWaypoint(rightwards: false, degrees: step.value)
			case .turnRight: rotateWaypoint(rightwards: true, degrees: step.value)
			case .moveForward: moveWaypoint(times: step.value)
			}

			// print("Ship at \(ship.position.displayString), waypoint at \(waypoint.displayString)")
		}

		delegate?.shipMoved(ship: ship, waypoint: nil)
		steps.forEach {
			wayPointStep($0)
			delegate?.shipMoved(ship: ship, waypoint: nil)
		}
		delegate?.shipMoved(ship: nil, waypoint: nil)
		return ship.position.cityDistance().description
	}

	private func loadSteps(_ filename: String) -> [Step] {
		let lines = FileHelper.load(filename)!
		let steps: [Step] = lines.compactMap { line in
			guard !line.isEmpty,
			      let command = Command(rawValue: line.character(at: 0)),
			      let value = Int(line.dropFirst(1))
			else {
				return nil
			}

			return Step(command: command, value: value)
		}
		return steps
	}
}
