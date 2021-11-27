
import AOCLib
import Foundation

class Solve21: PuzzleSolver {
	let exampleFile = "Example21"
	let inputFile = "Input21"

	func solveAExamples() -> Bool {
		solveA(exampleFile) == "5"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile) == "mxmxvkd,sqjhc,fvjkl"
	}

	func solveA() -> String {
		solveA(inputFile)
	}

	func solveB() -> String {
		solveB(inputFile)
	}

	struct Food {
		var ingredients: [String]
		var allergens: [String]
	}

	private func solveA(_ filename: String) -> String {
		let foods = load(filename)
		let dangerFoods = danger(foods: foods)

		var count = 0
		foods.forEach { food in
			food.ingredients.forEach { ingredient in
				if !dangerFoods.values.contains(ingredient) {
					count += 1
				}
			}
		}
		return count.description
	}

	private func solveB(_ filename: String) -> String {
		let foods = load(filename)
		let dangerFoods = Array(danger(foods: foods))
		let canonical = dangerFoods.sorted(by: { $0.key < $1.key })
		let solution = canonical.map(\.value).joined(separator: ",")
		return solution
	}

	// returns allegen -> food
	private func danger(foods: [Food]) -> [String: String] {
		// From allergen to possible ingredient.
		var allergens = [String: Set<String>]()
		foods.forEach { food in
			food.allergens.forEach { allergen in
				if var a = allergens[allergen] {
					a.formIntersection(food.ingredients)
					allergens[allergen] = a
				} else {
					allergens[allergen] = Set<String>(food.ingredients)
				}
			}
		}

		var solution: [String: String] = [:]

		while allergens.count > 0 {
			// Add any singtons to our solution
			allergens.filter { _, value in value.count == 1 }.forEach {
				solution[$0.key] = $0.value.first
			}

			// Find new set to reduce.
			var reduced = [String: Set<String>]()
			allergens.forEach { key, value in
				let newValues = value.filter { !solution.values.contains($0) }
				if newValues.count > 0 {
					reduced[key] = newValues
				}
			}
			allergens = reduced
		}

		return solution
	}

	private func load(_ filename: String) -> [Food] {
		let lines = FileHelper.load(filename)!.filter { !$0.isEmpty }

		var foods: [Food] = []
		lines.forEach {
			let listing = $0.components(separatedBy: "(")
			let ingredients = listing[0].components(separatedBy: " ").filter { !$0.isEmpty }
			let allergenParts = listing[1].dropLast().dropFirst(9)
			let allergens = allergenParts.components(separatedBy: ", ")
			let food = Food(ingredients: ingredients, allergens: allergens)
			foods.append(food)
		}
		return foods
	}
}
