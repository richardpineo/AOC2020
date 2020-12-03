import XCTest

class TestPuzzle1: XCTestCase {
	func testExampleA() throws {
		try solveAExamples(Solve1())
	}

	func testExampleB() throws {
		try solveBExamples(Solve1())
	}

	func testA() throws {
		try solveA(Solve1(), "494475")
	}

	func testB() throws {
		try solveB(Solve1(), "267520550")
	}
}
