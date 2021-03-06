
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
		case 12:
			return AnyView(DetailsView12())
		default:
			return nil
		}
	}

	var hasDetailView: Bool {
		[1, 4, 11, 12].contains(id)
	}
}
