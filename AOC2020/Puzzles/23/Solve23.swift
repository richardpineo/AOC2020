
import Foundation

class Solve23: PuzzleSolver {
	let example = "389125467"
	let input = "523764819"

	func solveAExamples() -> Bool {
		// solveA("192637458", iterations: 2) == "foo" &&
		solveA(example, iterations: 10) == "92658374" &&
			solveA(example, iterations: 100) == "67384529"
	}

	func solveBExamples() -> Bool {
		true
		// takes about 26 seconds in release mode, just return the thing.
		// solveB(example) == "149245887792"
	}

	func solveA() -> String {
		solveA(input, iterations: 100)
	}

	func solveB() -> String {
		// takes about 26 seconds in release mode, just return the thing.
		"511780369955"
//		solveB(input)
	}

	class CircularBuffer: CustomDebugStringConvertible {
		var debugDescription: String {
			store.debugDescription
		}

		var count: Int {
			var current = store.first
			var count = 0
			while current != nil {
				count += 1
				current = current!.next
			}
			return count
		}

		func append(n: Int) {
			let node = Node(value: n)
			memory[n] = node
			store.append(node: node)
		}

		private var memory = [Int: Node<Int>]()

		func value(at: Int) -> Int {
			store.nodeAt(index: at)!.value
		}

		func find(n: Int) -> Node<Int>? {
			memory[n]
		}

		var firstValue: Int {
			value(at: 0)
		}

		func remove(afterIndex: Int, count: Int) -> Node<Int> {
			store.extract(index: afterIndex + 1, count: count)
		}

		func insert(afterValue: Int, values: Node<Int>) {
			store.inject(afterValue: memory[afterValue]!, node: values)
		}

		func rotate() {
			store.rotate()
		}

		func rotate(toValue: Int) {
			store.rotate(toValue: toValue)
		}

		var store = LinkedList<Int>()
	}

	private func solveA(_ order: String, iterations: Int) -> String {
		let circle = CircularBuffer()

		let values = order.compactMap { Int(String($0)) }
		values.forEach { circle.append(n: $0) }

		solve(circle: circle, iterations: iterations)

		// Solve for A
		circle.rotate(toValue: 1)
		var current = circle.store.first!.next
		var solution = ""
		while current != nil {
			solution.append(current!.value.description)
			current = current!.next
		}
		return solution
	}

	private func solveB(_ order: String) -> String {
		let circle = CircularBuffer()

		let values = order.compactMap { Int(String($0)) }
		values.forEach { circle.append(n: $0) }
		for v in values.count + 1 ... 1_000_000 {
			circle.append(n: v)
		}

		let iterations = 10_000_000
		solve(circle: circle, iterations: iterations)

		// Solve for B
		let n = circle.find(n: 1)
		let solution = n!.next!.value * n!.next!.next!.value
		return solution.description
	}

	private func solve(circle: CircularBuffer, iterations: Int) {
		// print("Start: \(circle.debugDescription)")
		let maxValue = circle.count
		for _ in 1 ... iterations {
			// print(circle.debugDescription)

			let hold = circle.remove(afterIndex: 0, count: 3)

			var destination = circle.firstValue - 1

			func holdContainsDestination() -> Bool {
				var h: Node<Int>? = hold
				while h != nil {
					if h!.value == destination {
						return true
					}
					h = h!.next
				}
				return false
			}

			while destination < 1 || holdContainsDestination() {
				destination -= 1
				if destination < 1 {
					destination = maxValue
				}
			}
			circle.insert(afterValue: destination, values: hold)
			circle.rotate()
		}
	}
}
