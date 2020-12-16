
import Foundation

class Solve16: PuzzleSolver {
	let exampleFile = "Example16"
	let inputFile = "Input16"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "71"
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		""
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

	private func findInvalidValues(_ tickets: Tickets) -> [Int] {
		var invalid: [Int] = []
		tickets.nearbyTickets.forEach { ticket in
			ticket.values.forEach { value in
				let passing = tickets.rules.map { rule in
					rule.range1.contains(value) || rule.range2.contains(value)
				}
				
				if passing.allSatisfy({ !$0 }) {
					invalid.append(value)
				}
			}
		}
		return invalid
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

		return Rule(name: name, range1: range1Start...range1End, range2: range2Start...range2End)
	}

	private func loadTicket(_ line: String) -> Ticket {
		let values = line.components(separatedBy: ",").map { Int($0)! }
		return Ticket(values: values)
	}
}
