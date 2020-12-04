
import SwiftUI

// Not every puzzle has a detail, but some do
extension Puzzle {
	func detailView() -> AnyView? {
		switch id {
		case 0:
			return AnyView(DetailsView1())
		case 3:
			return AnyView(DetailsView4())

		default:
			return nil
		}
	}

	var hasDetailView: Bool {
		detailView() != nil
	}
}
