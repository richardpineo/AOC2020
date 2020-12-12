
import SwiftUI

// Not every puzzle has a detail, but some do
extension Puzzle {
	func detailView() -> AnyView? {
		switch id {
		case 1:
			return AnyView(DetailsView1())
		case 4:
			return AnyView(DetailsView4())
		case 11:
			return AnyView(DetailsView11())
		default:
			return nil
		}
	}

	var hasDetailView: Bool {
		detailView() != nil
	}
}
