
import Foundation

class Solve7: PuzzleSolver {
	let exampleFile = "Example7"
	let exampleFile2 = "Example7-2"
	let inputFile = "Input7"
	let myBagId = "shiny gold"

	func solveAExamples() -> Bool {
		let bags = loadBags(exampleFile)
		let containCount = countContainers(bagId: myBagId, bags: bags)
		return containCount == 4
	}

	func solveBExamples() -> Bool {
		let bags = loadBags(exampleFile)
		let containCount = countContainers(bagId: myBagId, bags: bags)

		let bags2 = loadBags(exampleFile2)
		let containCount2 = countContainers(bagId: myBagId, bags: bags2)

		return containCount == 32 && containCount2 == 126
	}

	func solveA() -> String {
		let bags = loadBags(inputFile)
		let containCount = countContainers(bagId: myBagId, bags: bags)
		return containCount.description
	}

	func solveB() -> String {
		""
	}

	class ContainedBag: CustomDebugStringConvertible {
		convenience init(count: Int, bagId: String) {
			self.init()
			self.count = count
			self.bagId = bagId
		}

		var count: Int = 0
		var bagId: String = ""

		// direct access
		var bag: Bag?
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

	struct Bags {
		init(bags: [Bag]) {
			self.bags = bags
			// Build cache
			bags.forEach {
				self.bagCache[$0.bagId] = $0
			}
			// finalize the contained bags
			bags.forEach {
				$0.contains.forEach { containedBag in
					containedBag.bag = getBag(bagId: containedBag.bagId)
				}
			}
		}

		var bags: [Bag]

		func getBag(bagId: String) -> Bag? {
			bagCache[bagId]
		}

		private var bagCache: [String: Bag] = [:]
	}

	private func isContained(bagId: String, searchBags: [Bag], in bags: Bags) -> Bool {
		let found = searchBags.first { searchBag in
			if bagId == searchBag.bagId {
				return true
			}
			return isContained(bagId: bagId, searchBags: searchBag.contains.map { $0.bag! }, in: bags)
		}
		return found != nil
	}

	private func countContainers(bagId _: String, bags: Bags) -> Int {
		let count = bags.bags.reduce(0) { curCount, bag in
			curCount + (isContained(bagId: myBagId, searchBags: bag.contains.map { $0.bag! }, in: bags) ? 1 : 0)
		}
		return count
	}

	private func loadBags(_ filename: String) -> Bags {
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

		return Bags(bags: bags)
	}
}
