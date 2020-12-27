// From: https://www.raywenderlich.com/947-swift-algorithm-club-swift-linked-list-data-structure

// 1
public class Node<T> {
	// 2
	var value: T
	weak var next: Node<T>?
	weak var previous: Node<T>?

	// 3
	init(value: T) {
		self.value = value
	}
}

// 1. Change the declaration of the Node class to take a generic type T
public class LinkedList<T>: CustomDebugStringConvertible where T: Equatable {
	public var debugDescription: String {
		var c = head
		var values: [T] = []
		while c != nil {
			values.append(c!.value)
			c = c!.next
		}
		return values.debugDescription
	}

	// 2. Change the head and tail variables to be constrained to type T
	private weak var head: Node<T>?
	private weak var tail: Node<T>?

	public var isEmpty: Bool {
		head == nil
	}

	// 3. Change the return type to be a node constrained to type T
	public var first: Node<T>? {
		head
	}

	// 4. Change the return type to be a node constrained to type T
	public var last: Node<T>? {
		tail
	}

	// 5. Update the append function to take in a value of type T
	public func append(node newNode: Node<T>) {
		if let tailNode = tail {
			newNode.previous = tailNode
			tailNode.next = newNode
		} else {
			head = newNode
		}
		tail = newNode
	}

	// 6. Update the nodeAt function to return a node constrained to type T
	public func nodeAt(index: Int) -> Node<T>? {
		if index >= 0 {
			var node = head
			var i = index
			while node != nil {
				if i == 0 { return node }
				i -= 1
				node = node!.next
			}
		}
		return nil
	}

	// very unsafe
	public func extract(index: Int, count: Int) -> Node<T> {
		let start = nodeAt(index: index)
		var end = start
		for _ in 1 ..< count {
			end = end!.next
		}

		if let p = start!.previous {
			p.next = end!.next
		} else {
			head = end!.next
		}
		if let t = end!.next {
			t.previous = start!.previous
		} else {
			tail = start!.previous
		}

		start!.previous = nil
		end!.next = nil

		return start!
	}

	public func rotate() {
		let n = head!
		remove(node: head!)
		append(node: n)
	}

	public func rotate(toValue: T) {
		while head!.value != toValue {
			rotate()
		}
	}

	// very unsafe
	public func inject(afterValue injectPos: Node<T>, node: Node<T>) {
		var end = node
		while end.next != nil {
			end = end.next!
		}

		if let n = injectPos.next {
			n.previous = end
		} else {
			tail = end
		}

		end.next = injectPos.next
		injectPos.next = node
		node.previous = injectPos
	}

	public func insertAfter(node: Node<T>, value: T) -> Node<T> {
		let n = Node(value: value)
		n.next = node.next
		n.previous = node
		if let nodeNext = node.next {
			nodeNext.previous = n
		} else {
			tail = n
		}
		node.next = n
		return n
	}

	public func removeAll() {
		head = nil
		tail = nil
	}

	/*
	 public func find(value: T) -> Node<T>? {
	 	weak var current = head
	 	while current != nil {
	 		if current!.value == value {
	 			return current
	 		}
	 		current = current!.next
	 	}
	 	return nil
	 }
	 */

	// 7. Update the parameter of the remove function to take a node of type T. Update the return value to type T.
	public func remove(node: Node<T>) {
		let prev = node.previous
		let next = node.next

		if let prev = prev {
			prev.next = next
		} else {
			head = next
		}
		next?.previous = prev

		if next == nil {
			tail = prev
		}

		node.previous = nil
		node.next = nil
	}
}
