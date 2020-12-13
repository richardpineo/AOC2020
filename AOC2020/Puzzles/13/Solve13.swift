
import Foundation

class Solve13: PuzzleSolver {
	let exampleFile = "Example13"
	let inputFile = "Input13"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "295"
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

	private func solve(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!.filter { !$0.isEmpty }
		
		let departure = Int(lines[0])!
		let busses = lines[1].components(separatedBy: ",").filter { $0 != "x" }.map { Int($0)! }
		
		let timeAfterDeparture = busses.map { bus in
			(bus: bus, delay: bus - departure % bus)
		}
		let best = timeAfterDeparture.min(by: { $0.delay < $1.delay })!
		let answer = best.bus * best.delay
		return answer.description
	}
}
