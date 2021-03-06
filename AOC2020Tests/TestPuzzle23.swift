import XCTest

class TestPuzzle23: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve23()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "49576328")
	}

	func testB() throws {
		try solveB(solver(), "511780369955")
	}
}
