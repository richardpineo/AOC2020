
import Foundation

class Solve5: PuzzleSolver {
	
	let exampleFile = "Example5"
	let inputFile = "Input5"

	func solveAExamples() -> Bool {
		for line in FileHelper.load(exampleFile)! {
			let test = line.components(separatedBy: " ")
			if test.count == 2 {
				if Int(test[1])! != calculateSeatId(test[0]) {
					return false
				}
			}
		}
		return true
	}
	
	func solveBExamples() -> Bool {
		return false
	}

	func solveA() -> String {
		let maxSeat = FileHelper.load(inputFile)!.map { calculateSeatId($0) }.max()
		return maxSeat!.description
	}

	func solveB() -> String {
		return ""
	}
	
	func calculateSeatId(_ seat: String) -> Int {
		if seat.count != 10 {
			return 0
		}
		let row = seat.subString(start: 0, count: 7)
		let col = seat.subString(start: 7, count: 3)
		
		let rowBin = toBinary(row, "B")
		let colBin = toBinary(col, "R")

		let seatId = rowBin * 8 + colBin
		print("\(seat) -> \(seatId)")
		return seatId
	}

	func toBinary(_ string: String, _ highVal: String.Element) -> Int {
		let value = string.reduce(0) { total, char in
			total * 2 + (char == highVal ? 1 : 0)
		}
		return value
	}
	
	private func solve(_ filename: String) -> String {
		let lines = FileHelper.load(filename)!
		return ""
	}
}
