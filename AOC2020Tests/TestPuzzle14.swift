import XCTest

class TestPuzzle14: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve14()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "17481577045893")
	}

	func testB() throws {
		try solveB(solver(), "4160009892257")
	}
}
