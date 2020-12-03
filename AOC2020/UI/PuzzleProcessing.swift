
import Foundation

struct PuzzleProcessingId: Hashable {
	var id: Int
	var isA: Bool

	var description: String {
		"Day \(id + 1)-\(isA ? "A" : "B")"
	}
}

class PuzzleProcessing: ObservableObject {
	enum ProcessingStatus {
		case idle
		case processing(Date)
	}

	init(puzzles: Puzzles) {
		self.puzzles = puzzles
	}

	static func application(puzzles: Puzzles) -> PuzzleProcessing {
		PuzzleProcessing(puzzles: puzzles)
	}

	static func preview(puzzles: Puzzles) -> PuzzleProcessing {
		let processing = PuzzleProcessing(puzzles: puzzles)
		processing.status[.init(id: 1, isA: true)] = .processing(Date())
		return processing
	}

	// A map from puzzle ID and A/B to current processing status
	// If the value isn't in the map, then it's not processing.
	@Published var status: [PuzzleProcessingId: ProcessingStatus] = [:]

	func isProcessing(_ id: PuzzleProcessingId) -> Bool {
		guard let found = status[id] else {
			return false
		}
		switch found {
		case .processing: return true
		default:
			return false
		}
	}

	// Amount of time processing, if processing or nil otherwise.
	func elapsed(_ id: PuzzleProcessingId) -> TimeInterval? {
		guard let found = status[id] else {
			return nil
		}
		switch found {
		case let .processing(start):
			return start.distance(to: Date())
		default:
			return nil
		}
	}

	func startProcessing(_ id: PuzzleProcessingId) {
		if isProcessing(id) {
			return
		}
		status[id] = .processing(Date())

		DispatchQueue.global().async {
			// Solve it
			let solution = self.solve(id)

			// Report out
			DispatchQueue.main.async {
				let puzzle = self.puzzles.puzzles[id.id]
				if !solution.isEmpty {
					Self.log(id, solution)
				}
				if id.isA {
					puzzle.solutionA = solution
				} else {
					puzzle.solutionB = solution
				}

				self.status[id] = .idle
			}
		}
	}

	func clearAll() {
		puzzles.puzzles.forEach { puzzle in
			puzzle.solutionA = ""
			puzzle.solutionB = ""
		}
	}

	func processAll() {
		puzzles.puzzles.forEach { puzzle in
			startProcessing(.init(id: puzzle.id, isA: true))
			startProcessing(.init(id: puzzle.id, isA: false))
		}
	}

	private func solve(_ id: PuzzleProcessingId) -> String {
		let puzzle = puzzles.puzzles[id.id]

		guard let solver = puzzle.makeSolver?() else {
			return ""
		}

		Self.log(id, "Begin solving")
		return id.isA ? solver.solveA() : solver.solveB()
	}

	private static func log(_ id: PuzzleProcessingId, _ text: String) {
		print("\(id.description): \(text)")
	}

	private var puzzles: Puzzles
}
