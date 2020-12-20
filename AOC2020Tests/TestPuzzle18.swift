import XCTest

class TestPuzzle18: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve18()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "25190263477788")
	}

	func testB() throws {
		try solveB(solver(), "")
	}
}
