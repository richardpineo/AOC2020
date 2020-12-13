
import Foundation

class Solve13: PuzzleSolver {
	let exampleFile = "Example13"
	let exampleFile2 = "Example13-2"
	let exampleFile3 = "Example13-3"
	let exampleFile4 = "Example13-4"
	let exampleFile5 = "Example13-5"
	let exampleFile6 = "Example13-6"
	let inputFile = "Input13"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "295"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile) == "1068781" &&
			solveB(exampleFile2) == "3417" &&
			solveB(exampleFile3) == "754018" &&
			solveB(exampleFile4) == "779210" &&
			solveB(exampleFile5) == "1261476" &&
			solveB(exampleFile6) == "1202161486"
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		solveB(inputFile)
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

	private func solveB(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!.filter { !$0.isEmpty }

		// Don't care about line 2
		let busses = lines[1].components(separatedBy: ",")

		// The constraints are inputs into whether a time works for a bus.
		// Better might have been to use functors here?
		var constraints: [(bus: Int, offset: Int)] = []
		for index in 0 ..< busses.count {
			if let bus = Int(busses[index]) {
				constraints.append((bus: bus, offset: index))
			}
		}

		// A mapping from each bus to whether they pass the constraints (mapping by indices)
		func passesConstraints(_ t: UInt64) -> [Bool] {
			constraints.map { bus, offset in
				(t + UInt64(offset)) % UInt64(bus) == 0
			}
		}

		// We can step at the LCM of all passing tests.
		var memoizedSteps: [[Bool]: Int] = [:]
		func findStepSize(_ passing: [Bool]) -> Int {
			if let found = memoizedSteps[passing] {
				return found
			}
			var goodOnes: [Int] = []
			for index in 0 ..< passing.count {
				if passing[index] {
					goodOnes.append(constraints[index].bus)
				}
			}
			let lcm = Int(MathHelper.lcm(of: goodOnes))
			memoizedSteps[passing] = lcm
			// print("memorize: \(lcm): \(passing.debugDescription)")
			return lcm
		}

		// Find a time that works or loop forever.
		var t: UInt64 = 0
		while true {
			let passing = passesConstraints(t)
			if passing.allSatisfy({ $0 }) {
				return t.description
			}
			t = t + UInt64(findStepSize(passing))
		}
	}
}
