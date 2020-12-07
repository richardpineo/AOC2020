import XCTest

class TestPuzzle7: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve7()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "278")
	}

	func testB() throws {
		try solveB(solver(), "45157")
	}
}
