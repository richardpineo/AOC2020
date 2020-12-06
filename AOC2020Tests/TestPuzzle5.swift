import XCTest

class TestPuzzle5: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve5()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "906")
	}

	func testB() throws {
		try solveB(solver(), "519")
	}
}
