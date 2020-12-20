
import Foundation

class Solve19: PuzzleSolver {
	let exampleFile = "Example19"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "2"
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		""
	}

	func solveB() -> String {
		""
	}
	
	indirect enum Rule {
		case compound([Int])
		case either([Int], [Int])
		case character(Character)
	}
	
	private func solve(_ filename: String) -> String {
		
		let (rules, messages) = load(filename)

		return messages.count.description
	}
	
	private func loadSubRules(_ line: String) -> [Int] {
		return line.components(separatedBy: " ").compactMap{ Int($0) }
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
