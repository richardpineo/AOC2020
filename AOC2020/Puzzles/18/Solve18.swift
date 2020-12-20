
import Foundation

class Solve18: PuzzleSolver {
	let example1 = "1 + 2 * 3 + 4 * 5 + 6"
	let example2 = "2 * 3 + (4 * 5)"
	let example3 = "5 + (8 * 3 + 9 + 3 * 4 * 3)"
	let example4 = "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"
	let example5 = "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"

	let inputFile1 = "Input18"

	func solveAExamples() -> Bool {
		evaluate(example1) == 71 &&
			evaluate(example2) == 26 &&
			evaluate(example3) == 437 &&
			evaluate(example4) == 12240 &&
			evaluate(example5) == 13632
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		let input = load(inputFile1)
		let sum = input.reduce(0) { $0 + evaluate($1) }
		return sum.description
	}

	func solveB() -> String {
		""
	}

	indirect enum Node {
		case add(Node, Node)
		case multiply(Node, Node)
		case value(Int)

		case rawValue(Character)

		func matches(_ character: Character) -> Bool {
			if case let .rawValue(c) = self {
				return c == character
			}
			return false
		}

		var rawValueToNumber: Int {
			if case let .rawValue(c) = self {
				return Int(String(c))!
			}
			return -666
		}

		var evaluated: Int {
			switch self {
			case let .value(v):
				return v
			case let .add(a, b):
				return a.evaluated + b.evaluated
			case let .multiply(a, b):
				return a.evaluated * b.evaluated
			default:
				return rawValueToNumber
			}
		}
	}

	private func reduce3(_ lhs: Node, _ oper: Node, _ rhs: Node) -> Node {
		guard case let .rawValue(c) = oper else {
			return .value(-666)
		}

		switch c {
		case "+":
			return .add(lhs, rhs)
		case "*":
			return .multiply(lhs, rhs)
		default:
			return .value(-666)
		}
	}

	// All the tokens are one of [0-9+*]
	private func simpleReduce(_ tokens: [Node]) -> Node {
		if tokens.count == 1 {
			return tokens[0]
		}

		// reduce the first 3
		let oneExpr = reduce3(tokens[0], tokens[1], tokens[2])
		var newTokens = Array(tokens.dropFirst(3))
		newTokens.insert(oneExpr, at: 0)
		return simpleReduce(newTokens)
	}

	private func reduce(_ tokens: [Node]) -> Node {
		//  We'll do this by pulling out tokens surrounded by parens
		guard let nested = tokens.lastIndex(where: { $0.matches("(") }) else {
			// No parens found - reduce simply.
			return simpleReduce(tokens)
		}

		for index in nested + 1 ..< tokens.count {
			if tokens[index].matches(")") {
				// pull out the innards
				let subRange = Array(tokens[nested + 1 ... index - 1])
				let reduced = reduce(subRange)
				var newTokens = tokens
				newTokens.removeSubrange(nested ... index)
				newTokens.insert(reduced, at: nested)
				return reduce(newTokens)
			}
		}
		// should never get here
		return Node.value(-666)
	}

	private func parse(_ line: String) -> Node {
		// Let's space out near parens
		let spaced = line.replacingOccurrences(of: "(", with: "( ").replacingOccurrences(of: ")", with: " )")

		let tokens = spaced.components(separatedBy: " ").map { Node.rawValue($0.character(at: 0)) }
		return reduce(tokens)
	}

	private func evaluate(_ line: String) -> Int {
		let node = parse(line)
		let answer = node.evaluated
		return answer
	}

	private func load(_ filename: String) -> [String] {
		let lines = FileHelper.load(filename)!.filter { !$0.isEmpty }
		return lines
	}
}
