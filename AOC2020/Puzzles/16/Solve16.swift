
import AOCLib
import Foundation

class Solve16: PuzzleSolver {
	let exampleFile = "Example16"
	let exampleFile2 = "Example16-2"
	let inputFile = "Input16"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "71"
	}

	func solveBExamples() -> Bool {
		let tickets = load(exampleFile2)
		return solveB(tickets) == ["row", "class", "seat"]
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		let tickets = load(inputFile)
		let solved = solveB(tickets)
		var answer = 1
		for index in 0 ..< solved.count {
			let rule = solved[index]
			if rule.starts(with: "departure") {
				answer *= tickets.myTicket.values[index]
			}
		}
		return answer.description
	}

	struct Rule {
		var name: String
		var range1: ClosedRange<Int>
		var range2: ClosedRange<Int>
	}

	struct Ticket {
		var values: [Int]
	}

	struct Tickets {
		var rules: [Rule]
		var myTicket: Ticket
		var nearbyTickets: [Ticket]
	}

	private func solve(_ filename: String) -> String {
		let tickets = load(filename)
		let invalidValues = findInvalidValues(tickets)
		let sum = invalidValues.reduce(0) { $0 + $1 }
		return sum.description
	}

	private func solveB(_ tickets: Tickets) -> [String] {
		let validTickets = tickets.nearbyTickets.filter { isValid(tickets, $0) }

		// Find which values go with which on my ticket
		var possibleRules: [[Rule]] = []
		for valueIndex in 0 ..< tickets.myTicket.values.count {
			// Find the first rule that works for all the valid tickets.
			let foundRules = tickets.rules.filter { rule in
				validTickets.allSatisfy { ticket in
					isValid(rule, ticket.values[valueIndex])
				}
			}
			possibleRules.append(foundRules)
		}

		// Now that we have all the possible rules, reduce them down to the final set.
		var finalRules: [String: Int] = [:]
		while finalRules.count != tickets.myTicket.values.count {
			let candidate = findCandidateRule(possibleRules)
			finalRules[candidate.name] = candidate.position

			possibleRules = possibleRules.map { rules in
				rules.filter { $0.name != candidate.name }
			}
		}
		let ordered = Array(finalRules).sorted { $0.value < $1.value }

		return ordered.map(\.key)
	}

	private func findCandidateRule(_ possibleRules: [[Rule]]) -> (name: String, position: Int) {
		let foundIndex = possibleRules.firstIndex { $0.count == 1 }!
		return (possibleRules[foundIndex][0].name, foundIndex)
	}

	private func findInvalidValues(_ tickets: Tickets) -> [Int] {
		var invalid: [Int] = []
		tickets.nearbyTickets.forEach { ticket in
			if let bad = badValue(tickets, ticket) {
				invalid.append(bad)
			}
		}
		return invalid
	}

	private func isValid(_ rule: Rule, _ value: Int) -> Bool {
		rule.range1.contains(value) || rule.range2.contains(value)
	}

	private func isValid(_ rules: [Rule], _ value: Int) -> Bool {
		let passing = rules.map { isValid($0, value) }
		return !passing.allSatisfy { !$0 }
	}

	private func isValid(_ tickets: Tickets, _ ticket: Ticket) -> Bool {
		badValue(tickets, ticket) == nil
	}

	private func badValue(_ tickets: Tickets, _ ticket: Ticket) -> Int? {
		ticket.values.first { !isValid(tickets.rules, $0) }
	}

	private func load(_ filename: String) -> Tickets {
		let lines = FileHelper.load(filename)!

		var lineIndex = 0

		// Part 1 : load the rules
		var rules: [Rule] = []
		while !lines[lineIndex].isEmpty {
			let rule = loadRule(lines[lineIndex])
			rules.append(rule)
			lineIndex += 1
		}

		// Part 2 : load my ticket
		lineIndex += 2
		let myTicket: Ticket = loadTicket(lines[lineIndex])
		lineIndex += 3

		// Part 3 : load nearby tickets
		var nearby: [Ticket] = []
		while !lines[lineIndex].isEmpty {
			nearby.append(loadTicket(lines[lineIndex]))
			lineIndex += 1
		}

		return Tickets(rules: rules, myTicket: myTicket, nearbyTickets: nearby)
	}

	private func loadRule(_ line: String) -> Rule {
		let values = line.components(separatedBy: CharacterSet(charactersIn: ":-"))
		let values2 = values[2].components(separatedBy: " ")

		// seat: 13-40 or 45-50
		let name = values[0]
		let range1Start = Int(values[1].dropFirst(1))!
		let range1End = Int(values2[0])!
		let range2Start = Int(values2[2])!
		let range2End = Int(values[3])!

		return Rule(name: name, range1: range1Start ... range1End, range2: range2Start ... range2End)
	}

	private func loadTicket(_ line: String) -> Ticket {
		let values = line.components(separatedBy: ",").map { Int($0)! }
		return Ticket(values: values)
	}
}
