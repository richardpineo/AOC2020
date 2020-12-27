import XCTest

class TestPuzzle19: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve19()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "269")
	}

	func testB() throws {
		try solveB(solver(), "403")
	}
}
