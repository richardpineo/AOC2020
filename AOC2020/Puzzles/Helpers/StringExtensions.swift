
import Foundation

extension String {
	func character(at: Int) -> Character {
		self[index(startIndex, offsetBy: at)]
	}

	func assignCharacter(at index: Int, with newChar: Character) -> String {
		var chars = Array(self)
		chars[index] = newChar
		return String(chars)
	}

	func subString(start: Int, count: Int) -> String {
		let startPos = index(startIndex, offsetBy: start)
		let endPos = index(startIndex, offsetBy: start + count)
		return String(self[startPos ..< endPos])
	}

	func pad(toSize: Int) -> String {
		var padded = self
		for _ in 0 ..< (toSize - count) {
			padded = "0" + padded
		}
		return padded
	}

	func binaryToNumber() -> UInt64 {
		UInt64(self, radix: 2)!
	}
}
