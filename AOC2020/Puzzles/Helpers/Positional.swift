
import Foundation

protocol Positional: Hashable {
	associatedtype dimensional

	// remaining dimensions will be 0
	init(_ x: Int, _ y: Int)
	
	func neighbors(includeSelf: Bool) -> [dimensional]
	
	func cityDistance(_ from: dimensional) -> Int

	static var origin: dimensional { get }
}
