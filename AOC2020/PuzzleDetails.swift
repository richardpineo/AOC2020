
import SwiftUI

// Not every puzzle has a detail, but some do
extension Puzzle {
	func detailView() -> AnyView? {
		switch id {
		case 1:
			return AnyView(Text("Puzzle 1 detail view"))

		default:
			return nil
		}
	}

	var hasDetailView: Bool {
		switch id {
		case 1:
			return true

		default:
			return false
		}
	}
}
