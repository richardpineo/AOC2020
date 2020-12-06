import XCTest

class TestPuzzle6: XCTestCase {
	private func solver() -> PuzzleSolver {
		return Solve6()
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
