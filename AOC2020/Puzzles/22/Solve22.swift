
import Foundation

class Solve22: PuzzleSolver {
	let exampleFile = "Example22"

	func solveAExamples() -> Bool {
		solve(exampleFile) == ""
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		""
	}

	func solveB() -> String {
		""
	}

	class Game {
		var player1 = Deck()
		var player2 = Deck()
	}

	class Deck {
		var cards = Queue<Int>()
	}

	private func solve(_ filename: String) -> String {
		let game = load(filename)
		
		return "Not yet"
	}

	private func load(_ filename: String) -> Game {
		let lines = FileHelper.load(filename)!
		let game = Game()

		var index = 1
		while !lines[index].isEmpty {
			let card = Int(lines[index])!
			game.player1.cards.enqueue(card)
			index += 1
		}
		index += 2
		while !lines[index].isEmpty {
			let card = Int(lines[index])!
			game.player2.cards.enqueue(card)
			index += 1
		}
		
		return game
	}
}
