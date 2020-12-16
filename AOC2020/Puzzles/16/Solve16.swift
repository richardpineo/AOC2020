
import Foundation

class Solve16: PuzzleSolver {
	let exampleFile = "Example16"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "71"
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
		return tickets.nearbyTickets.count.description
	}
	
	private func load(_ filename: String) -> Tickets {
		let lines = FileHelper.load(filename)!
		
		var lineIndex = 0
		
		// Part 1 : load the rules
		var rules: [Rule] = []
		while(!lines[lineIndex].isEmpty) {
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
		while(!lines[lineIndex].isEmpty) {
			nearby.append(loadTicket(lines[lineIndex]))
			lineIndex += 1
		}

		return Tickets(rules: rules, myTicket: myTicket, nearbyTickets: nearby)
	}
	
	private func loadRule(_ line: String) -> Rule {
		let values = line.components(separatedBy: CharacterSet(charactersIn: ": -"))
		
		// seat: 13-40 or 45-50
		let range1 = Int(values[2])!...Int(values[3])!
		let range2 = Int(values[5])!...Int(values[6])!
		return Rule(name: values[0], range1: range1, range2: range2)
	}
	
	private func loadTicket(_ line: String) -> Ticket {
		let values = line.components(separatedBy: ",").map { Int($0)! }
		return Ticket(values: values)
	}
}
