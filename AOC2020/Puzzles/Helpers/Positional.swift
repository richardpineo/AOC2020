
import Foundation

protocol Positional {
	associatedtype dimensional

	// remaining dimensions will be 0
	static func alloc(x: Int, y: Int) -> dimensional

	func neighbors(includeSelf: Bool) -> [dimensional]
}
