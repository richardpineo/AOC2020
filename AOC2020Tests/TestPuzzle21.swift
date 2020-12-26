import XCTest

class TestPuzzle21: XCTestCase {
	private func solver() -> PuzzleSolver {
		Solve21()
	}

	func testExampleA() throws {
		try solveAExamples(solver())
	}

	func testExampleB() throws {
		try solveBExamples(solver())
	}

	func testA() throws {
		try solveA(solver(), "2078")
	}

	func testB() throws {
		try solveB(solver(), "lmcqt,kcddk,npxrdnd,cfb,ldkt,fqpt,jtfmtpd,tsch")
	}
}
