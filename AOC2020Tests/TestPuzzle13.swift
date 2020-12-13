import XCTest

class TestPuzzle13: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve13()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "2045")
	}

	func testB() throws {
		try solveB(solver(), "402251700208309")
	}
}
