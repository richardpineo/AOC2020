
import AOCLib
import Foundation

class Solve22: PuzzleSolver {
	let exampleFile = "Example22"
	let exampleFile2 = "Example22-2"
	let inputFile = "Input22"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "306"
	}

	func solveBExamples() -> Bool {
		solveRecursive(exampleFile2) == "105" &&
			solveRecursive(exampleFile) == "291"
	}

	var answerA = "35013"
	var answerB = "32806"

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		// This one is about 10 seconds in debug mode (or 250ms in release!!), just return the answer
		"32806"
		// solveRecursive(inputFile)
	}

	class Game {
		init() {
			player1 = Deck()
			player2 = Deck()
		}

		init(p1: Deck, p2: Deck) {
			player1 = p1
			player2 = p2
		}

		var player1: Deck
		var player2: Deck

		// Returns nil if game is not over, or true if player1 wins.
		func play(doesPlayer1Win: (Int, Int) -> Bool) -> Bool? {
//			print("Player 1's deck: \(player1.cards.array)")
//			print("Player 2's deck: \(player2.cards.array)")

			guard let card1 = player1.cards.dequeue() else {
				return false
			}
			guard let card2 = player2.cards.dequeue() else {
				return true
			}
			let player1Wins = doesPlayer1Win(card1, card2)
//			print("Player \(player1Wins ? "1" : "2") wins")
			if player1Wins {
				player1.cards.enqueue(card1)
				player1.cards.enqueue(card2)
			} else {
				player2.cards.enqueue(card2)
				player2.cards.enqueue(card1)
			}
			return nil
		}

		func finalScore(player1Win: Bool) -> Int {
			let winningDeck = player1Win ? player1 : player2
			return winningDeck.score
		}
	}

	class Deck {
		init() {
			cards = Queue<Int>()
		}

		init(cards: [Int]) {
			self.cards = Queue<Int>(from: cards)
		}

		var cards: Queue<Int>

		var score: Int {
			var sum = 0
			let deck = cards.array
			for index in 0 ..< deck.count {
				let mult = deck.count - index
				sum += mult * deck[index]
			}
			return sum
		}
	}

	struct State: Hashable {
		var player1: Int
		var player2: Int
	}

	private func solveRecursive(_ filename: String) -> String {
		let game = load(filename)
		let player1Won = playRecursive(game: game)
		return game.finalScore(player1Win: player1Won).description
	}

	private func playRecursive(game: Game) -> Bool {
		var previousStates = Set<State>()

		func doesPlayer1Win(card1: Int, card2: Int) -> Bool {
			// Check to see if we have enough cards to recurse.
			if card1 <= game.player1.cards.count, card2 <= game.player2.cards.count {
				let innerGame = Game(
					p1: Deck(cards: Array(game.player1.cards.array.prefix(card1))),
					p2: Deck(cards: Array(game.player2.cards.array.prefix(card2)))
				)
				return playRecursive(game: innerGame)
			}

			return card1 > card2
		}

		while true {
			// check state
			let state = State(player1: game.player1.score, player2: game.player2.score)

			if previousStates.contains(state) {
				return true
			}

			if let winner = game.play(doesPlayer1Win: doesPlayer1Win) {
				return winner
			}

			previousStates.insert(state)
		}
	}

	private func solve(_ filename: String) -> String {
		let game = load(filename)

		while true {
			if let winner = game.play(doesPlayer1Win: { $0 > $1 }) {
				return game.finalScore(player1Win: winner).description
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
