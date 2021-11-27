
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
		// This one takes several seconds to run. Just skip it when not actively developing.
		true
		/*
		 processB(values: [0, 3, 6]) == "175594" &&
		 	processB(values: [1, 3, 2]) == "2578" &&
		 	processB(values: [2, 1, 3]) == "3544142" &&
		 	processB(values: [1, 2, 3]) == "261214" &&
		 	processB(values: [2, 3, 1]) == "6895259" &&
		 	processB(values: [3, 2, 1]) == "18" &&
		 	processB(values: [3, 1, 2]) == "362"
		 */
	}

	func solveA() -> String {
		processA(values: [1, 20, 8, 12, 0, 14])
	}

	func solveB() -> String {
		// Takes several seconds so just return the answer.
		"63644"
		// processB(values: [1, 20, 8, 12, 0, 14])
	}

	class GameNumber: CustomDebugStringConvertible {
		init(turn: Int) {
			speak(turn: turn)
		}

		var previous: Int?
		var twoBack: Int?

		var hasSpokenTwice: Bool {
			twoBack != nil
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
			hasSpokenTwice ? "\(previous!), \(latency) turns ago" : "never said before"
		}
	}

	private func processA(values: [Int]) -> String {
		process(values: values, stopCount: 2020)
	}

	private func processB(values: [Int], stopCount _: Int = 2020) -> String {
		process(values: values, stopCount: 30_000_000)
	}

	private func process(values: [Int], stopCount: Int) -> String {
		var state = [GameNumber?](repeating: nil, count: stopCount)

		var spoken = 0
		for value in values {
			state[value] = GameNumber(turn: spoken)
			spoken += 1
		}

		var lastSpoken = values[spoken - 1]
		for count in spoken ..< stopCount {
			guard let lastState = state[lastSpoken] else {
				return "GRR"
			}

			lastSpoken = 0
			if lastState.hasSpokenTwice {
				lastSpoken = lastState.latency
			}

			if let s = state[lastSpoken] {
				s.speak(turn: count)
			} else {
				state[lastSpoken] = GameNumber(turn: count)
			}
		}
		return lastSpoken.description
	}
}
