
import Foundation

class Solve6: PuzzleSolver {
	
	let exampleFile = "Example6"
	let inputFile = "Input6"

	func solveAExamples() -> Bool {
		return solvePartA(exampleFile) == 11
	}
	
	func solveBExamples() -> Bool {
		return true
	}
	
	func solveA() -> String {
		return solvePartA(inputFile).description
	}

	func solveB() -> String {
		return ""
	}
	
	private func solvePartA(_ filename: String) -> Int {
		let groups = loadGroups(filename)
		let allAnswers = flattenGroups(groups)
		var result = 0
		allAnswers.forEach {
			result = result + $0.count
		}
		return result
	}
	
	private func flattenGroups(_ groups: [[String]]) -> [Set<String.Element>] {
		var allAnswers: [Set<String.Element>] = []
		for group in groups {
			var answers = Set<String.Element>()
			for person in group {
				person.forEach { answers.insert($0 ) }
			}
			allAnswers.append(answers)
		}
		return allAnswers
	}
	
	private func loadGroups(_ filename: String) -> [[String]] {
		var current: [String] = []
		var groups = [[String]]()
		for line in FileHelper.load(filename)! {
			if line.isEmpty {
				if !current.isEmpty {
					groups.append(current)
					current = []
				}
			}
			else {
				current.append(line)
			}
		}
		return groups
	}
}
