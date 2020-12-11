import XCTest

class TestPuzzle24: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve24()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "")
	}

	func testB() throws {
		try solveB(solver(), "")
	}
}
