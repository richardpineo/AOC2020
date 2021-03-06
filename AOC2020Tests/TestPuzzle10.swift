import XCTest

class TestPuzzle10: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve10()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "1920")
	}

	func testB() throws {
		try solveB(solver(), "1511207993344")
	}
}
