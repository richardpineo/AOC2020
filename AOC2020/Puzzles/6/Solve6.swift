
import AOCLib
import Foundation

class Solve6: PuzzleSolver {
	let exampleFile = "Example6"
	let inputFile = "Input6"

	func solveAExamples() -> Bool {
		solvePartA(exampleFile) == 11
	}

	func solveBExamples() -> Bool {
		solvePartB(exampleFile) == 6
	}

	var answerA = "6387"
	var answerB = "3039"

	func solveA() -> String {
		solvePartA(inputFile).description
	}

	func solveB() -> String {
		solvePartB(inputFile).description
	}

	private func solvePartA(_ filename: String) -> Int {
		let groups = loadGroups(filename)
		let allAnswers = findUnionAnswers(groups)
		return countAnswers(allAnswers)
	}

	private func solvePartB(_ filename: String) -> Int {
		let groups = loadGroups(filename)
		let allAnswers = findIntersectionAnswers(groups)
		return countAnswers(allAnswers)
	}

	private func countAnswers(_ answers: [Set<String.Element>]) -> Int {
		var result = 0
		answers.forEach {
			result = result + $0.count
		}
		return result
	}

	private func findIntersectionAnswers(_ groups: [[String]]) -> [Set<String.Element>] {
		var allAnswers: [Set<String.Element>] = []
		for group in groups {
			var intersection = Set(group[0])
			for person in group {
				intersection = intersection.intersection(person)
			}
			allAnswers.append(intersection)
		}
		return allAnswers
	}

	private func findUnionAnswers(_ groups: [[String]]) -> [Set<String.Element>] {
		var allAnswers: [Set<String.Element>] = []
		for group in groups {
			var answers = Set<String.Element>()
			for person in group {
				person.forEach { answers.insert($0) }
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
			} else {
				current.append(line)
			}
		}
		return groups
	}
}
