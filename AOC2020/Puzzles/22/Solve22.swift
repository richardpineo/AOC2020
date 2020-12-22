
import Foundation

class Solve22: PuzzleSolver {
	let exampleFile = "Example22"
	let inputFile = "Input22"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "306"
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

	class Game {
		var player1 = Deck()
		var player2 = Deck()

		func play() -> Int? {
			guard let card1 = player1.cards.dequeue() else {
				return 1
			}
			guard let card2 = player2.cards.dequeue() else {
				return 0
			}
			if card1 > card2 {
				player1.cards.enqueue(card1)
				player1.cards.enqueue(card2)
			} else {
				player2.cards.enqueue(card2)
				player2.cards.enqueue(card1)
			}
			return nil
		}
	}

	class Deck {
		var cards = Queue<Int>()
	}

	private func solve(_ filename: String) -> String {
		let game = load(filename)

		while true {
			if let winner = game.play() {
				let winningDeck = winner == 1 ? game.player2 : game.player1

				let deck = winningDeck.cards.array
				var sum = 0
				for index in 0 ..< deck.count {
					let mult = deck.count - index
					sum += mult * deck[index]
				}
				return sum.description
			}
		}
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
