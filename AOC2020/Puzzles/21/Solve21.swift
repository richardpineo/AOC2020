
import Foundation

class Solve21: PuzzleSolver {
	let exampleFile = "Example21"
	let inputFile = "Input21"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "5"
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		""
	}

	struct Food {
		var ingredients: [String]
		var allergens: [String]
	}

	private func solve(_ filename: String) -> String {
		let foods = load(filename)
		
		// From allergen to possible ingredient.
		var allergens = [String: Set<String>]()
		foods.forEach { food in
			food.allergens.forEach { allergen in
				if var a = allergens[allergen] {
					a.formIntersection(food.ingredients)
					allergens[allergen] = a
				}
				else {
					allergens[allergen] = Set<String>(food.ingredients)
				}
			}
		}
		
		// allegen -> food, will be 1:1
		var solution: [String: String] = [:]
		
		while allergens.count > 0{
			// Add any singtons to our solution
			allergens.filter { (key, value) in value.count == 1 }.forEach {
				solution[$0.key] = $0.value.first
			}
			
			// Find new set to reduce.
			var reduced = [String: Set<String>]()
			allergens.forEach { (key, value) in
				let newValues = value.filter { !solution.values.contains( $0 ) }
				if newValues.count > 0 {
					reduced[key] = newValues
				}
			}
			allergens = reduced
		}
		
		var count = 0
		foods.forEach { food in
			food.ingredients.forEach { ingredient in
				if !solution.values.contains(ingredient) {
					count += 1
				}
			}
		}
		
		return count.description
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
