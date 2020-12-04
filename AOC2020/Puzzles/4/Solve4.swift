
import Foundation

class Solve4: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example4") == "2"
	}

	func solveBExamples() -> Bool {
		solve("Example4") == ""
	}

	func solveA() -> String {
		solve("Input4")
	}

	func solveB() -> String {
		solve("Input4")
	}
	
	struct Passport {
		var datas: [String: String] = [:]
		
		var isValid: Bool {
			let required =  [
				"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"
			]
			
			let _ = [
				"cid"
			]
			
			return required.allSatisfy{ datas[$0] != nil }
		}
	}

	private func solve(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		
		var passports: [Passport] = []
		
		var current = Passport()
		for index in 0 ..< lines.count {
			let line = lines[index]
			
			if line.isEmpty {
				passports.append(current)
				current = Passport()
			}
			else {
				let dataLine = line.components(separatedBy: " ")
				dataLine.forEach {
					let kvp = $0.components(separatedBy: ":")
					if kvp.count == 2 {
						current.datas[kvp[0]] = kvp[1]
					}
				}
			}
		}
		
		let valid = passports.filter { $0.isValid }
		return valid.count.description
	}
}
