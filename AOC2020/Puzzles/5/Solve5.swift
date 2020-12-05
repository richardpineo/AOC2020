
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
		return true
	}

	func solveA() -> String {
		let maxSeat = FileHelper.load(inputFile)!.compactMap { calculateSeatId($0) }.max()
		return maxSeat!.description
	}

	func solveB() -> String {
		let seats = FileHelper.load(inputFile)!.compactMap { calculateSeatId($0) }.sorted()
		
		for index in 0 ..< seats.count {
			let check = seats[index + 1]
			if seats[index] + 1 != check {
				return (seats[index] + 1).description
			}
		}
		
		return "notfound"
	}
	
	func calculateSeatId(_ seat: String) -> Int? {
		if seat.count != 10 {
			return nil
		}
		let row = seat.subString(start: 0, count: 7)
		let col = seat.subString(start: 7, count: 3)
		
		let rowBin = toBinary(row, "B")
		let colBin = toBinary(col, "R")

		let seatId = rowBin * 8 + colBin
		return seatId
	}

	func toBinary(_ string: String, _ highVal: String.Element) -> Int {
		let value = string.reduce(0) { total, char in
			total * 2 + (char == highVal ? 1 : 0)
		}
		return value
	}
}
