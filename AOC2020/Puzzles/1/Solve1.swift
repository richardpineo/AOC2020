
import Foundation

class Solve1 {
	
	func example() -> String {
		guard let example = FileHelper.load("Example") else {
			return ""
		}
		
		let numbers = example.compactMap { Int($0) }
		
		for index in 0...numbers.count {
			for index2 in index...numbers.count {
				let val = numbers[index] + numbers[index2]
				if val == 2020 {
					return (numbers[index] * numbers[index2]).description
				}
			}
		}
		return ""
	}
	
	func solveA() -> String {
		return ""
	}
}
