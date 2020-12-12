
import Foundation

class Solve12: PuzzleSolver {
	let exampleFile = "Example12"
	let inputFile = "Input12"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "25"
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

	/*
	 Action N means to move north by the given value.
	 Action S means to move south by the given value.
	 Action E means to move east by the given value.
	 Action W means to move west by the given value.
	 Action L means to turn left the given number of degrees.
	 Action R means to turn right the given number of degrees.
	 Action F means to move forward by the given value in the direction the ship is currently facing.
	 */
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

	struct Ship {
		var position: Position2D
		var heading: Heading
		
		func numTurns(_ degrees: Int) -> Int {
			return degrees / 90
		}
		
		func forwards(_ distance: Int) -> Ship {
			switch heading {
			case .north: return step(.init(command: .moveNorth, value: distance))
			case .south: return step(.init(command: .moveSouth, value: distance))
			case .east: return step(.init(command: .moveEast, value: distance))
			case .west: return step(.init(command: .moveWest, value: distance))
			}
		}
		
		func step(_ step: Step) -> Ship {
			switch step.command {
			case .moveNorth: return Ship(position: position.offset(.init(0, step.value)), heading: heading)
			case .moveSouth: return Ship(position: position.offset(.init(0, -step.value)), heading: heading)
			case .moveEast: return Ship(position: position.offset(.init(step.value, 0)), heading: heading)
			case .moveWest: return Ship(position: position.offset(.init(-step.value, 0)), heading: heading)
			case .turnLeft: return Ship(position: position, heading: heading.turnLeft(numTurns(step.value)))
			case .turnRight: return Ship(position: position, heading:  heading.turnRight(numTurns(step.value)))
			case .moveForward: return forwards(step.value)
			}
		}
	}

	private func solve(_ filename: String) -> String {
		let steps = loadSteps(filename)
		
		var ship = Ship(position: .origin, heading: .east)
		steps.forEach { ship = ship.step($0) }
		
		return ship.position.distance().description
	}
	
	private func loadSteps(_ filename: String) -> [Step] {
		let lines = FileHelper.load(filename)!
		let steps: [Step] = lines.compactMap { line in
			guard !line.isEmpty,
				  let command = Command(rawValue: line.character(at: 0)),
				  let value = Int(line.dropFirst(1)) else {
				return nil
			}
			
			return Step(command: command, value: value)
		}
		return steps
	}
}
