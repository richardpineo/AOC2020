
import Foundation

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		processA(values: [0, 3, 6]) == "436" &&
			processA(values: [1, 3, 2]) == "1" &&
			processA(values: [2, 1, 3]) == "10" &&
			processA(values: [1, 2, 3]) == "27" &&
			processA(values: [2, 3, 1]) == "78" &&
			processA(values: [3, 2, 1]) == "438" &&
			processA(values: [3, 1, 2]) == "1836"
	}

	func solveBExamples() -> Bool {
		false &&
		processB(values: [0, 3, 6]) == "175594" &&
			processB(values: [1, 3, 2]) == "2578" &&
			processB(values: [2, 1, 3]) == "3544142" &&
			processB(values: [1, 2, 3]) == "261214" &&
			processB(values: [2, 3, 1]) == "6895259" &&
			processB(values: [3, 2, 1]) == "18" &&
			processB(values: [3, 1, 2]) == "362"
	}

	func solveA() -> String {
		processA(values: [1, 20, 8, 12, 0, 14])
	}

	func solveB() -> String {
		processB(values: [1, 20, 8, 12, 0, 14])
	}

	class GameNumber: CustomDebugStringConvertible {
		init(turn: Int) {
			previous = turn
		}

		private var previous: Int
		private var maybeLatency: Int = -1

		var hasSpokenTwice: Bool {
			maybeLatency != -1
		}

		func speak(turn: Int) {
			maybeLatency = turn - previous
			previous = turn
		}

		var latency: Int {
			return maybeLatency
		}

		var debugDescription: String {
			hasSpokenTwice ? "\(previous), \(latency) turns ago" : "never said before"
		}
	}

	private func processA(values: [Int]) -> String {
		process(values: values, stopCount: 2020)
	}

	private func processB(values: [Int], stopCount _: Int = 2020) -> String {
		process(values: values, stopCount: 30_000_000)
	}

	private func process(values: [Int], stopCount: Int) -> String {
		var state: [Int: GameNumber] = [:]

		var spoken = 0
		for value in values {
			state[value] = GameNumber(turn: spoken)
			spoken += 1
		}

		var lastSpoken = values[spoken - 1]
		var lastState: GameNumber = state[lastSpoken]!
		
		// The main event
		for count in spoken ..< stopCount {
			lastSpoken = lastState.latency

			if let s = state[lastSpoken] {
				lastState = s
				s.speak(turn: count)
			} else {
				lastState = GameNumber(turn: count)
				state[lastSpoken] = lastState
			}
		}
		print("\(state.count) values in state")
		return lastSpoken.description
	}
}
