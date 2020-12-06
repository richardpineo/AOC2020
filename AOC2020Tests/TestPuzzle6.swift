import XCTest

class TestPuzzle6: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve6()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "6387")
	}

	func testB() throws {
		try solveB(solver(), "3039")
	}
}
