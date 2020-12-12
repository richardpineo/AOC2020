import XCTest

class TestPuzzle11: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve11()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "2299")
	}

	func testB() throws {
		try solveB(solver(), "2047")
	}
}
