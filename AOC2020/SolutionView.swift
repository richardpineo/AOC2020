

import SwiftUI

struct SolutionView: View {
	@EnvironmentObject var processing: PuzzleProcessing
	
	var puzzle: Puzzle
	var isA: Bool
	@State var processingStep: Int = 0

	var body: some View {
		HStack {
			Spacer()
			VStack {
				if processing.isProcessing(processingId) {
					Text(elapsed)
				}
				else {
					if let sol = isA ? puzzle.solutionA : puzzle.solutionB {
						Text(sol)
					} else {
						Text("UNSOLVED")
					}
				}
			}
			Spacer()
			PuzzleProcessingView(processingStep: processingStep, processingId: PuzzleProcessingId(id: puzzle.id, isA: isA))
		}
		.padding()
		.frame(maxWidth: .infinity)
		.background(Color(.gray).opacity(0.5))
		.cornerRadius(10)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 2))
		.onReceive(self.timer) { _ in
			self.processingStep = self.processingStep + 1
		}
	}
	
	private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


	private var elapsed: String {
		guard let elapsed = processing.elapsed(processingId) else {
			return ""
		}
		let rounded = lround(elapsed.magnitude)
		return "\(rounded) seconds elapsed"
	}
	
	private var processingId: PuzzleProcessingId {
		PuzzleProcessingId(id: puzzle.id, isA: isA)
	}
}

struct Solutionview_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			SolutionView(puzzle: PuzzlePreview.unsolved, isA: true)
			SolutionView(puzzle: PuzzlePreview.solved, isA: true)
			SolutionView(puzzle: PuzzlePreview.partSolved, isA: true)
			SolutionView(puzzle: PuzzlePreview.partSolved, isA: false)
		}
		.environmentObject(PuzzlePreview.puzzles())
		.environmentObject(PuzzlePreview.processing())
		.previewLayout(.fixed(width: 200, height: 100))
	}
}
