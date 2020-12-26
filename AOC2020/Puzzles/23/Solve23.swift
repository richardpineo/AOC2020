
import Foundation

class Solve23: PuzzleSolver {
	let example = "389125467"
	let input = "523764819"

	func solveAExamples() -> Bool {
		solve(example, iterations: 10) == "92658374" &&
			solve(example, iterations: 100) == "67384529"
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		solve(input, iterations: 100)
	}

	func solveB() -> String {
		""
	}

	class CircularBuffer {
		init(order: String) {
			store = order.compactMap { Int(String($0)) }
		}

		var description: String {
			store.debugDescription
		}

		var solution: String {
			rotate(to: 1)
			store.remove(at: 0)
			return store.map(\.description).joined()
		}

		var firstValue: Int {
			store[0]
		}

		func remove(after: Int, count: Int) -> [Int] {
			let range = (after + 1) ... (after + count)
			let values = Array(store[range])
			store.removeSubrange(range)
			return values
		}

		func insert(after: Int, values: [Int]) {
			let index = store.firstIndex(of: after)! + 1
			store.insert(contentsOf: values, at: index)
		}

		func rotate() {
			rotate(to: store[1])
		}

		func rotate(to: Int) {
			while store[0] != to {
				let v = store.remove(at: 0)
				store.append(v)
			}
		}

		func nextIndex(_ index: Int) -> Int {
			let next = index + 1
			if next == store.count {
				return 0
			}
			return next
		}

		private var store: [Int]
	}

	private func solve(_ order: String, iterations: Int) -> String {
		let circle = CircularBuffer(order: order)

		for _ in 1 ... iterations {
			// print(circle.description)
			let hold = circle.remove(after: 0, count: 3)
			var destination = circle.firstValue - 1
			while hold.contains(destination) || destination < 1 {
				destination -= 1
				if destination < 1 {
					destination = 9
				}
			}
			circle.insert(after: destination, values: hold)
			circle.rotate()
		}

		// print(circle.description)
		let solve = circle.solution
		// print(circle.description)
		return solve
	}
}
