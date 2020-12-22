import XCTest

class TestPuzzle22: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve22()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "35013")
	}

	func testB() throws {
		try solveB(solver(), "32806")
	}
}
