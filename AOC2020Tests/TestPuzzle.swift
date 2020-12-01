import XCTest

extension XCTestCase {
	func solveAExamples(_ solver: PuzzleSolver) throws {
		XCTAssertTrue(solver.solveAExamples())
	}

	func solveBExamples(_ solver: PuzzleSolver) throws {
		XCTAssertTrue(solver.solveBExamples())

	}

	func solveA(_ solver: PuzzleSolver) throws {
		let solution = solver.solveA()
		print(solution)
	}

	func solveB(_ solver: PuzzleSolver) throws {
		let solution = solver.solveB()
		print(solution)
	}
}
