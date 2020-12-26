import XCTest

class TestPuzzle25: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve25()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "16311885")
	}

	func testB() throws {
		try solveB(solver(), "")
	}
}
