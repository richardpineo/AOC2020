
import Foundation

class Solve19: PuzzleSolver {
	let exampleFile = "Example19"
	let inputFile = "Input19"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "2"
	}

	func solveBExamples() -> Bool {
		Solve19StolenPart2.run(example: true) == 12
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		Solve19StolenPart2.run(example: false).description
	}

	indirect enum Rule {
		case compound([Int])
		case either([Int], [Int])
		case character(Character)
	}

	private func solve(_ filename: String) -> String {
		let (rules, messages) = load(filename)
		let solver = Solver(rules: rules)
		let allWords = solver.allWords()
		let passing = messages.reduce(0) { count, message in
			let passes = allWords.contains(message)
			return count + (passes ? 1 : 0)
		}
		return passing.description
	}

	class Solver {
		init(rules: [Int: Rule]) {
			self.rules = rules
		}

		private let rules: [Int: Rule]

		func allWords() -> Set<String> {
			var words = Set<String>()
			rules.keys.forEach { id in
				let forRule = wordsForRule(id: id)
				words.formUnion(forRule)
			}
			return words
		}

		func wordsForRule(id: Int) -> [String] {
			if let found = memoized[id] {
				return found
			}

			let words = wordsForRuleRaw(id: id)
			memoized[id] = words
			return words
		}

		private func compoundWords(ids: [Int]) -> [String] {
			if ids.count == 1 {
				return wordsForRule(id: ids[0])
			}

			let first = wordsForRule(id: ids[0])
			let subWords = compoundWords(ids: Array(ids.dropFirst(1)))
			var words: [String] = []
			for prefix in first {
				for sub in subWords {
					words.append(prefix + sub)
				}
			}
			return words
		}

		private func wordsForRuleRaw(id: Int) -> [String] {
			switch rules[id] {
			case let .character(c):
				return [String(c)]

			case let .compound(subs):
				return compoundWords(ids: subs)

			case let .either(first, second):
				let firstWords = compoundWords(ids: first)
				let secondWords = compoundWords(ids: second)
				return firstWords + secondWords

			case .none:
				return []
			}
		}

		var memoized: [Int: [String]] = [:]
	}

	private func loadSubRules(_ line: String) -> [Int] {
		line.components(separatedBy: " ").compactMap { Int($0) }
	}

	private func loadRule(_ line: String) -> (Int, Rule) {
		let tokens = line.components(separatedBy: ":")
		let id = Int(tokens[0])!

		let ruleBody = tokens[1].trimmingCharacters(in: [" "])

		// really only "a" and "b" in input
		if ruleBody == "\"a\"" {
			return (id, .character("a"))
		}
		if ruleBody == "\"b\"" {
			return (id, .character("b"))
		}

		let ruleTokens = tokens[1].components(separatedBy: "|")

		// is it a pipe?
		if ruleTokens.count == 2 {
			let sub1 = loadSubRules(ruleTokens[0])
			let sub2 = loadSubRules(ruleTokens[1])
			return (id, .either(sub1, sub2))
		}

		// Just a rule
		return (id, .compound(loadSubRules(ruleBody)))
	}

	private func load(_ filename: String) -> ([Int: Rule], [String]) {
		let lines = FileHelper.load(filename)!

		var rules: [Int: Rule] = [:]
		var messages: [String] = []
		var lineIndex = 0

		// Part 1 : load the rules
		while !lines[lineIndex].isEmpty {
			let loaded = loadRule(lines[lineIndex])
			rules[loaded.0] = loaded.1
			lineIndex += 1
		}

		// Part 2 : load the messages
		lineIndex += 1
		while !lines[lineIndex].isEmpty {
			messages.append(lines[lineIndex])
			lineIndex += 1
		}

		return (rules, messages)
	}
}
