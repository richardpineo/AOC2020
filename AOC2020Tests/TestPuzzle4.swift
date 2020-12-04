import XCTest

class TestPuzzle4: XCTestCase {
	func testExampleA() throws {
		try solveAExamples(Solve4())
	}

	func testExampleB() throws {
		try solveBExamples(Solve4())
	}

	func testA() throws {
		try solveA(Solve4(), "196")
	}

	func testB() throws {
		try solveB(Solve4(), "114")
	}
}
