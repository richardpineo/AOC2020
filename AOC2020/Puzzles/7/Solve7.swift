
import Foundation

class Solve7: PuzzleSolver {
	let exampleFile = "Example7"
	let inputFile = "Input7"
	let myBagId = "shiny gold"
	func solveAExamples() -> Bool {
		let bags = loadBags(exampleFile)
		let containCount = countContainers(bagId: myBagId, bags: bags)
		return containCount == 4
	}

	func solveBExamples() -> Bool {
		return false
	}

	func solveA() -> String {
		return ""
	}

	func solveB() -> String {
		return ""
	}
	
	struct ContainedBag: CustomDebugStringConvertible {
		var count: Int
		var bagId: String
		var debugDescription: String {
			"\(count) \(bagId)(s)"
		}
	}
	
	struct Bag: CustomDebugStringConvertible {
		var bagId: String // e.g. light red
		var contains: [ContainedBag]

		var debugDescription: String {
			"\(bagId) contains \(contains.debugDescription)"
		}
	}
	
	private func isContained(bagId: String, searchBagIds: [String], in bags: [Bag]) -> Bool {
		let found = searchBagIds.first { searchId in
			if bagId == searchId {
				return true
			}
			guard let foundBag = bags.first(where: { $0.bagId == searchId }) else {
				return false
			}
			return isContained(bagId: bagId, searchBagIds: foundBag.contains.map { $0.bagId }, in: bags)
		}
		return found != nil
	}
	
	private func countContainers( bagId: String, bags: [Bag]) -> Int {
		let count = bags.reduce(0) { curCount, bag in
			curCount + (isContained(bagId: myBagId, searchBagIds: bag.contains.map { $0.bagId }, in: bags) ? 1 : 0)
		}
		return count
	}

	private func loadBags(_ filename: String) -> [Bag] {
		var bags: [Bag] = []
		for line in FileHelper.load(filename)! {
			print(line)
			// split into two halves
			let lineValues = line.components(separatedBy: " bags contain ")
			if lineValues.count == 2 {
				var contained: [ContainedBag] = []
				
				if lineValues[1] != "no other bags." {
					let containedBags = lineValues[1].components(separatedBy: ",")
					containedBags.forEach { rawContained in
						let parsedBag = rawContained.components(separatedBy: " ").filter { !$0.isEmpty }
						if parsedBag.count > 2 {
							let count = Int(parsedBag[0])
							let bagId = "\(parsedBag[1]) \(parsedBag[2])"
							let cbag = ContainedBag(count: count!, bagId: bagId)
							contained.append(cbag)
						}
					}
				}
				
				let bag = Bag(
					bagId: lineValues[0],
					contains: contained
				)
				bags.append(bag)
			}
		}
		return bags
	}
}
