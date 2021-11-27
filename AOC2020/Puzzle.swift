
import Foundation
import SwiftUI

enum SolutionState {
	case unsolved
	case solved
	case solvedA
}

class Puzzle: Identifiable, ObservableObject {
	typealias MakeSolver = () -> PuzzleSolver

	init(year: Int, id: Int, name: String, maker: @escaping MakeSolver) {
		self.year = year
		self.id = id
		self.name = name
		makeSolver = maker

		solutionA = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(year: year, id: id, isA: true)) ?? ""
		solutionB = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(year: year, id: id, isA: false)) ?? ""
	}

	var year: Int
	var id: Int
	var name: String

	private var makeSolver: MakeSolver

	var solver: PuzzleSolver {
		makeSolver()
	}

	var state: SolutionState {
		if solutionA.isEmpty {
			return .unsolved
		}
		return solutionB.isEmpty ? .solvedA : .solved
	}

	@Published var solutionA: String {
		didSet {
			UserDefaults.standard.set(solutionA, forKey: Puzzle.userDefaultKey(year: year, id: id, isA: true))
		}
	}

	@Published var solutionB: String {
		didSet {
			UserDefaults.standard.set(solutionB, forKey: Puzzle.userDefaultKey(year: year, id: id, isA: false))
		}
	}

	private static func userDefaultKey(year: Int, id: Int, isA: Bool) -> String {
		"puzzle_\(year)_\(id)_\(isA ? "A" : "B")"
	}
}
