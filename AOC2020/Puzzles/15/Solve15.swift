
import Foundation

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve(values: [0,3,6]) == "436" &&
		solve(values: [1,3,2]) == "1" &&
		solve(values: [2,1,3]) == "10" &&
		solve(values: [1,2,3]) == "27" &&
		solve(values: [2,3,1]) == "78" &&
		solve(values: [3,2,1]) == "438" &&
		solve(values: [3,1,2]) == "1836"
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		solve(values: [1,20,8,12,0,14])
	}

	func solveB() -> String {
		""
	}

	class GameNumber: CustomDebugStringConvertible {
		init(turn: Int) {
			speak(turn: turn)
		}
		var previous: Int?
		var twoBack: Int?
		
		var hasSpokenTwice: Bool {
			return twoBack != nil
		}
		
		func speak(turn: Int) {
			twoBack = previous
			previous = turn
		}
		
		var latency: Int {
			guard let b = twoBack else {
				return 666
			}
			return previous! - b
		}
		
		var debugDescription: String {
			return hasSpokenTwice ? "\(previous!), \(latency) turns ago" : "never said before"
		}
	}

	private func solve(values: [Int], stopCount: Int = 2020) -> String {
		var state: [Int: GameNumber] = [:]

		var spoken = 0
		for value in values {
			state[value] = GameNumber(turn: spoken)
			spoken += 1
		}
		
		// print("initialized with \(state.debugDescription)")
		
		var lastSpoken = values[spoken - 1]
		for count in spoken..<stopCount {
			guard let lastState = state[lastSpoken] else {
				return "GRR"
			}
			
			// print("\(count + 1): last said was \(lastSpoken): \(lastState.debugDescription)")
			
			lastSpoken = 0
			if lastState.hasSpokenTwice {
				lastSpoken = lastState.latency
			}

			// print("\(count + 1): said \(lastSpoken)")
	
			if let s = state[lastSpoken]  {
				s.speak(turn: count)
			}
			else {
				state[lastSpoken] = GameNumber(turn: count)
			}
		}
		return lastSpoken.description
	}
}
