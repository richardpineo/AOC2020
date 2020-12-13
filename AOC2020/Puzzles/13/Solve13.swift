
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
		return
			lcm_of_array_elements([ 1, 2, 8, 3 ]) == 24 &&
			lcm_of_array_elements([ 2, 7, 3, 9, 4 ]) == 252 &&
			solveB(exampleFile2) == "3417" &&
			solveB(exampleFile3) == "754018" &&
			solveB(exampleFile4) == "779210" &&
			solveB(exampleFile5) == "1261476" &&
			solveB(exampleFile6) == "1202161486" &&
			solveB(exampleFile) == "1068788"
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
	
	// Stolen from c# example here: https://www.geeksforgeeks.org/lcm-of-given-array-elements/
	private func lcm_of_array_elements(_ element_array_const: [Int]) -> Int64
		{
		var element_array = element_array_const.map { Int64($0) }
		var lcm_of_array_elements: Int64 = 1;
		var divisor: Int64 = 2;
			  
			while (true) {
				  
				var counter = 0;
				var divisible = false;
				for i in 0..<element_array.count {
	  
					// lcm_of_array_elements (n1, n2, ... 0) = 0.
					// For negative number we convert into
					// positive and calculate lcm_of_array_elements.
					if (element_array[i] == 0) {
						return 0;
					}
					else if (element_array[i] < 0) {
						element_array[i] = element_array[i] * (-1);
					}
					if (element_array[i] == 1) {
						counter += 1;
					}
	  
					// Divide element_array by devisor if complete
					// division i.e. without remainder then replace
					// number with quotient; used for find next factor
					if (element_array[i] % divisor == UInt64(0)) {
						divisible = true;
						element_array[i] = element_array[i] / divisor;
					}
				}
	  
				// If divisor able to completely divide any number
				// from array multiply with lcm_of_array_elements
				// and store into lcm_of_array_elements and continue
				// to same divisor for next factor finding.
				// else increment divisor
				if (divisible) {
					lcm_of_array_elements = lcm_of_array_elements * divisor;
				}
				else {
					divisor += 1;
				}
	  
				// Check if all element_array is 1 indicate
				// we found all factors and terminate while loop.
				if (counter == element_array.count) {
					return lcm_of_array_elements;
				}
			}
		}
	
	private func solveB(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!.filter { !$0.isEmpty }
		
		let busses = lines[1].components(separatedBy: ",")


		/*
		find value t so that:
		busNum * t + busIndex = T
		*/
		
		var constraints: [(bus: UInt64, offset: UInt64)] = []
		for index in 0..<busses.count {
			if let bus = UInt64(busses[index]) {
				constraints.append((bus: bus, offset: UInt64(index)))
			}
		}
		
		func passesContraints(_ t: UInt64) -> Bool {
			constraints.allSatisfy { (bus, offset) in
				(t + offset) % bus == 0
			}
		}
		
		let step: UInt64 = 1 // constraints.min { $0.bus < $1.bus }!.bus

		var t = UInt64(constraints[0].bus)
		while (true) {
			
			if passesContraints(t) {
				return t.description
			}
			
			t = t + step
		}
	}
}
