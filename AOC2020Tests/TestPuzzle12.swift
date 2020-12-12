import XCTest

class TestPuzzle12: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve12()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "820")
	}

	func testB() throws {
		try solveB(solver(), "66614")
	}
}
