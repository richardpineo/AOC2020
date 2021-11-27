

import SwiftUI

protocol PuzzleDetails {
	associatedtype Body: View

	@ViewBuilder var body: Self.Body { get }
}

class EmptyDetails: PuzzleDetails {
	var body: some View {
		EmptyView()
	}
}
