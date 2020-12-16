import XCTest

class TestPuzzle16: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve16()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "26026")
	}

	func testB() throws {
		try solveB(solver(), "1305243193339")
	}
}
