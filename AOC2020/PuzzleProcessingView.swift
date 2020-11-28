
import SwiftUI

struct PuzzleProcessingView: View {
	@EnvironmentObject var processing: PuzzleProcessing
	
	private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

	@State private var currentIndex = 0
	
	var processingId: PuzzleProcessingId

	var body: some View {
		HStack {
			Button(action: {
				processing.startProcessing(processingId)
			}) {
				Image(systemName: image)
			}
		}
		.onReceive(self.timer) { _ in
			self.currentIndex = (self.currentIndex + 1) % 4
		}
			
	}
	
	private var image: String {
		if !processing.isProcessing(processingId) {
			return "play"
		}
		let images = [
			"circle.grid.cross.up.fill",
			"circle.grid.cross.right.fill",
			"circle.grid.cross.down.fill",
			"circle.grid.cross.left.fill"
		]
		return images[self.currentIndex]
	}
}

struct PuzzleProcessingView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PuzzleProcessingView(processingId: PuzzleProcessingId(id: 1, isA: true))
			PuzzleProcessingView(processingId: PuzzleProcessingId(id: 2, isA: true))
		}
		.environmentObject(PuzzleProcessing(puzzles: PuzzlePreview.puzzles()))
		.previewLayout(.fixed(width: 50, height: 50))
	}
}
