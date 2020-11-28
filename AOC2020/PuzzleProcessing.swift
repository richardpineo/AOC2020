
import Foundation

struct PuzzleProcessingId: Hashable {
	var id: Int
	var isA: Bool
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
		DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
			let newSolution = Int.random(in: 1000...1000000).description
			if id.isA {
				self.puzzles.puzzles[id.id].solutionA = newSolution
			} else {
				self.puzzles.puzzles[id.id].solutionB = newSolution
			}
			self.status[id] = .idle
		}
	}

	private var puzzles: Puzzles
	
}
