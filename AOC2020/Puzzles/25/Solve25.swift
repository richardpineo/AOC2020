
import Foundation

class Solve25: PuzzleSolver {
	let exampleCard = 5_764_801
	let exampleDoor = 17_807_724

	let inputCard = 6_270_530
	let inputDoor = 14_540_258

	let subject = 7

	func solveAExamples() -> Bool {
		solve(cardPublicKey: exampleCard, doorPublicKey: exampleDoor) == "14897079"
	}

	func solveBExamples() -> Bool {
		true
	}

	func solveA() -> String {
		solve(cardPublicKey: inputCard, doorPublicKey: inputDoor)
	}

	func solveB() -> String {
		""
	}

	func transform(value: Int, subject: Int) -> Int {
		(value * subject) % 20_201_227
	}

	func findLoopSize(publicKey: Int, subject: Int) -> Int {
		var value = 1
		var loop = 1
		while true {
			value = transform(value: value, subject: subject)
			if value == publicKey {
				return loop
			}
			loop += 1
		}
	}

	func findEncryptionKey(publicKey: Int, loop: Int) -> Int {
		var value = 1
		for _ in 1 ... loop {
			value = transform(value: value, subject: publicKey)
		}
		return value
	}

	private func solve(cardPublicKey: Int, doorPublicKey: Int) -> String {
		let cardLoop = findLoopSize(publicKey: cardPublicKey, subject: subject)
		let doorLoop = findLoopSize(publicKey: doorPublicKey, subject: subject)
		let key1 = findEncryptionKey(publicKey: doorPublicKey, loop: cardLoop)
		let key2 = findEncryptionKey(publicKey: cardPublicKey, loop: doorLoop)
		if key1 == key2 {
			return key1.description
		}
		return ""
	}
}
