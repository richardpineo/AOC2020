
import AOCLib
import Foundation
import XCTest

class Test2020: XCTestCase {
	func testOne() throws {
		testOne(Solve1())
	}

	func testAll() throws {
		let puzzles2020 = Puzzles2020()

		puzzles2020.puzzles.puzzles.forEach { puzzle in
			print("Testing \(puzzle.id): \(puzzle.name)")
			let solver = puzzle.solver
			testOne(solver)
		}
	}

	func testOne(_ solver: PuzzleSolver) {
		XCTAssertTrue(solver.solveAExamples())
		XCTAssertTrue(solver.solveBExamples())

		XCTAssertEqual(solver.solveA(), solver.answerA)
		XCTAssertEqual(solver.solveB(), solver.answerB)
	}
}
