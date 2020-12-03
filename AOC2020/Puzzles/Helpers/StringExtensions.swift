
import Foundation

extension String {
	func character(at: Int) -> Character {
		self[index(startIndex, offsetBy: at)]
	}
}
