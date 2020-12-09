import XCTest

class TestPuzzle9: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve9()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "88311122")
	}

	func testB() throws {
		try solveB(solver(), "13549369")
	}
}
