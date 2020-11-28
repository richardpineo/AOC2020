
import SwiftUI

struct PuzzleProcessingView: View {
	@EnvironmentObject var processing: PuzzleProcessing

	var processingStep: Int
	
	var processingId: PuzzleProcessingId

	var body: some View {
		HStack {
			Button(action: {
				processing.startProcessing(processingId)
			}) {
				Image(systemName: image)
			}
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
		return images[self.processingStep % images.count]
	}
}

struct PuzzleProcessingView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PuzzleProcessingView(processingStep: 0, processingId: PuzzleProcessingId(id: 1, isA: true))
			PuzzleProcessingView(processingStep: 1, processingId: PuzzleProcessingId(id: 2, isA: true))
		}
		.environmentObject(PuzzleProcessing(puzzles: PuzzlePreview.puzzles()))
		.previewLayout(.fixed(width: 50, height: 50))
	}
}
