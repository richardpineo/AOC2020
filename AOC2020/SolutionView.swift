

import SwiftUI

struct SolutionView: View {
	var puzzle: Puzzle
	var isA: Bool

	var body: some View {
		HStack {
			Spacer()
			VStack {
				if let sol = isA ? puzzle.solutionA : puzzle.solutionB {
					Text(sol)
				} else {
					Text("UNSOLVED")
				}
			}
			Spacer()
			PuzzleProcessingView(processingId: PuzzleProcessingId(id: puzzle.id, isA: isA))
		}
		.padding()
		.frame(maxWidth: .infinity)
		.background(Color(.gray).opacity(0.5))
		.cornerRadius(10)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 2))
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
