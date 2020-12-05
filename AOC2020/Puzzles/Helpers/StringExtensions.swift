
import Foundation

extension String {
	func character(at: Int) -> Character {
		self[index(startIndex, offsetBy: at)]
	}
	
	func subString(start: Int, count: Int) -> String {
		let startPos = self.index(self.startIndex, offsetBy: start)
		let endPos = self.index(self.startIndex, offsetBy: start + count)
		return String(self[startPos ..< endPos])
	}
}
