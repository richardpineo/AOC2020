
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

				Text("Day \(puzzle.id)")
					.font(.system(size: 24, weight: .semibold))
					.padding(.bottom, 10)

				Text(puzzle.name)
					.font(.system(size: 24)).italic()
					.padding(.horizontal)
					.fixedSize(horizontal: false, vertical: true)

				SolutionView(solution: puzzle.solutionA)
					.padding()

				SolutionView(solution: puzzle.solutionB)
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
	static let solved = Puzzle(id: 1, name: "An easy one", state: .solved, solutionA: "69420", solutionB: "12345")
	static let partSolved = Puzzle(id: 7, name: "Almost! This one has a really long name", state: .solvedA, solutionA: "FOOO")
	static let unsolved = Puzzle(id: 42, name: "A Hard One", state: .unsolved)

	static var previews: some View {
		Group {
			PuzzleCard(puzzle: unsolved)
			PuzzleCard(puzzle: partSolved)
			PuzzleCard(puzzle: solved)
		}
		.previewLayout(.fixed(width: 300, height: 300))
	}
}
