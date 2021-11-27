
import SwiftUI

protocol PuzzlesRepo {
	associatedtype Details: View

	var title: String { get }

	var puzzles: Puzzles { get }

	func hasDetails(id: Int) -> Bool

	func details(id: Int) -> Details
}
