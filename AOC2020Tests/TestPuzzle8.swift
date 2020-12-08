import XCTest

class TestPuzzle8: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve8()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "1818")
	}

	func testB() throws {
		try solveB(solver(), "fail")
	}
}
