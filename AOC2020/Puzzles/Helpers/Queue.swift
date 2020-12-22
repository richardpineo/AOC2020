
import Foundation

public struct Queue<T> {
	private var list = [T]()

	public init() {
		list = [T]()
	}

	public init(from: [T]) {
		list = from
	}

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

	var count: Int {
		list.count
	}

	var array: [T] {
		list
	}
}
