import XCTest

class TestPuzzle2: XCTestCase {
	func testExampleA() throws {
		try solveAExamples(Solve2())
	}

	func testExampleB() throws {
		try solveBExamples(Solve2())
	}

	func testA() throws {
		try solveA(Solve2(), "643")
	}

	func testB() throws {
		try solveB(Solve2(), "388")
	}
}
