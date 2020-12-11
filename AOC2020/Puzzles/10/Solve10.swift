
import Foundation

class Solve10: PuzzleSolver {
	let exampleFile = "Example10"
	let exampleFile2 = "Example10-2"
	let inputFile = "Input10"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "35" && solve(exampleFile2) == "220"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile) == "8" && solveB(exampleFile2) == "19208"
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		""
	}

	private func solve(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		let values = lines.compactMap { Int($0) }.sorted()
		var previous = 0
		var oneCount = 0
		var threeCount = 0
		for index in 0 ..< values.count {
			switch values[index] - previous {
			case 1:
				oneCount = oneCount + 1
			case 3:
				threeCount = threeCount + 1
			default:
				break
			}
			previous = values[index]
		}
		threeCount = threeCount + 1
		let answer = oneCount * threeCount
		return answer.description
	}

	private func solveB(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		let values = lines.compactMap { Int($0) }.sorted()

		let answer = branchCount(values: values)
		return answer.description
		/*
		 let answer2 = recursiveAdapterCount(values: values, index: 0)
		 var curIndex = 0
		 var combinatorics = 1
		 while curIndex < values.count - 1 {
		 	// How many of 1...3 are in the next values
		 	var nextIndex = curIndex + 1
		 	while nextIndex < values.count && values[nextIndex] - values[curIndex] <= 3 {
		 		nextIndex = nextIndex + 1
		 	}
		 	let possibleRoutes = nextIndex - curIndex - 1

		 	func cheapPow(_ count: Int) -> Int {
		 		if count == 1 {
		 			return 1
		 		}
		 		if count == 2 {
		 			return 2
		 		}
		 		return 4
		 	}
		 	let newCombinatorics = cheapPow(possibleRoutes)

		 	print("collapsing \(values[curIndex])...\(values[nextIndex-1]). possible routes: \(possibleRoutes), new comb:  \(newCombinatorics). total: \(combinatorics)")

		 	combinatorics = combinatorics * newCombinatorics

		 	curIndex = nextIndex - 1
		 }
		 return combinatorics.description
		 */
	}

	func branchCount(values: [Int]) -> Int {
		var count = 0
		for index in 0 ..< values.count {
			let possibleNexts = (index + 1 ... index + 3).filter { next in next < values.count && values[next] - values[index] < 4 }
			count = count + possibleNexts.count - 1
		}
		return count
	}

	/*
	 func recursiveAdapterCount(values: [Int], index: Int) -> Int {
	 	let currentValue = values[index]
	 	var branchCount = 0
	 	let possibleNexts = (index + 1...index + 3).filter { next in next < values.count && values[next] - currentValue < 4 }
	 	branchCount += branchCount + possibleNexts.count - 1

	 	possibleNexts.forEach { next in
	 		let branches = recursiveAdapterCount(values: values, index: next)
	 	}
	 	print("Count for value \(values[index]) is \(branchCount).")

	 	return branchCount
	 }
	 */
}
