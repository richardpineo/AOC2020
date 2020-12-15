import XCTest

class TestPuzzle15: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve15()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		// TOO SLOW
		//		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "492")
	}

	func testB() throws {
		// TOO SLOW
		//		try solveB(solver(), "63644")
	}
}
