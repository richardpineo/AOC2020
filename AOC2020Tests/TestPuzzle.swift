import XCTest

extension XCTestCase {
	func solveAExamples(_ solver: PuzzleSolver) throws {
		XCTAssertTrue(solver.solveAExamples())
	}

	func solveBExamples(_ solver: PuzzleSolver) throws {
		XCTAssertTrue(solver.solveBExamples())
	}

	func solveA(_ solver: PuzzleSolver, _ expected: String? = nil) throws {
		let solution = solver.solveA()
		XCTAssertEqual(solution, expected)
	}

	func solveB(_ solver: PuzzleSolver, _ expected: String? = nil) throws {
		let solution = solver.solveB()
		XCTAssertEqual(solution, expected)
	}
}
