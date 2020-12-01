
import SwiftUI

struct PuzzleCard: View {
	var puzzle: Puzzle

	var body: some View {
		ZStack {
			Color(backgroundColor).opacity(0.5)
				.cornerRadius(10)

			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 2)

			VStack {
				Spacer()

				Text("Day \(puzzle.id + 1)")
					.font(.system(size: 24, weight: .semibold))
					.padding(.bottom, 10)

				Group {
					if puzzle.name.isEmpty {
						Text("Not revealed")
							.font(.system(size: 18)).italic()
							.foregroundColor(.secondary)
					} else {
						Text(puzzle.name)
							.font(.system(size: 24))
					}
				}
				.padding(.horizontal)
				.fixedSize(horizontal: false, vertical: true)

				SolutionView(puzzle: puzzle, isA: true)
					.padding()

				SolutionView(puzzle: puzzle, isA: false)
					.padding()

				Spacer()
			}
		}
		.frame(height: 300)
	}

	var backgroundColor: UIColor {
		switch puzzle.state {
		case .unsolved:
			return .systemRed
		case .solvedA:
			return .systemBlue
		case .solved:
			return .systemGreen
		}
	}
}

struct PuzzleCard_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PuzzleCard(puzzle: PuzzlePreview.unsolved())
			PuzzleCard(puzzle: PuzzlePreview.partSolved())
			PuzzleCard(puzzle: PuzzlePreview.solved())
		}
		.previewLayout(.fixed(width: 300, height: 300))
	}
}