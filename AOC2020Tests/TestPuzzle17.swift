import XCTest

class TestPuzzle17: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve17()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "333")
	}

	func testB() throws {
		try solveB(solver(), "2676")
	}
}
