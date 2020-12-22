
import Foundation

public struct Queue<T> {
	private var list = [T]()

	public var isEmpty: Bool {
		list.isEmpty
	}

	mutating func enqueue(_ element: T) {
		list.append(element)
	}

	mutating func dequeue() -> T? {
		if !list.isEmpty {
			return list.removeFirst()
		} else {
			return nil
		}
	}

	func peek() -> T? {
		if !list.isEmpty {
			return list[0]
		} else {
			return nil
		}
	}
}
