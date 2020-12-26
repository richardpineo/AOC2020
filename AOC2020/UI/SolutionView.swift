

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
				} else {
					let sol = isA ? puzzle.solutionA : puzzle.solutionB

					if sol.isEmpty {
						Text("UNSOLVED")
					} else {
						Text(shortenIfNeeded(sol))
							.lineLimit(1)
							.minimumScaleFactor(0.5)
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

	private func shortenIfNeeded(_ solution: String) -> String {
		let max = 20
		return solution.count > max ? "Too Long" : solution
	}

	private static let updateHz = 0.1
	private let timer = Timer.publish(every: updateHz, on: .main, in: .common).autoconnect()

	private var elapsed: String {
		guard let elapsed = processing.elapsed(processingId) else {
			return ""
		}
		let sec = elapsed.magnitude
		if sec < 3 {
			let rounded = lround(sec * 1000)
			return "\(rounded) ms"
		} else {
			let rounded = Double(lround(sec * 10)) / 10.0
			return "\(rounded) sec"
		}
	}

	private var processingId: PuzzleProcessingId {
		PuzzleProcessingId(id: puzzle.id, isA: isA)
	}
}

struct Solutionview_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			SolutionView(puzzle: PuzzlePreview.unsolved(), isA: true)
			SolutionView(puzzle: PuzzlePreview.solved(), isA: true)
			SolutionView(puzzle: PuzzlePreview.partSolved(), isA: true)
			SolutionView(puzzle: PuzzlePreview.partSolved(), isA: false)
		}
		.environmentObject(PuzzlePreview.puzzles())
		.environmentObject(PuzzlePreview.processing())
		.previewLayout(.fixed(width: 200, height: 100))
	}
}
