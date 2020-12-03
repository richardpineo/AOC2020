
import Foundation

extension String {
	func character(at: Int) -> Character {
		self[self.index(self.startIndex, offsetBy: at)]
	}
}
