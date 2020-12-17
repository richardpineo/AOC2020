
import Foundation

protocol Positional {
	associatedtype dimensional
	
	func neighbors(includeSelf: Bool) -> [dimensional]
}
