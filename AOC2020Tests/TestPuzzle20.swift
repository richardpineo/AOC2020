import XCTest

class TestPuzzle20: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve20()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "5966506063747")
	}

	func testB() throws {
		try solveB(solver(), "1714")
	}
}
