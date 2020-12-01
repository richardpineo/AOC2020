import XCTest

class TestSolve1: XCTestCase {
	func testExampleA() throws {
		let solver = Solve1()
		XCTAssertEqual(solver.exampleA(), "514579")
	}

	func testExampleB() throws {
		let solver = Solve1()
		XCTAssertEqual(solver.exampleB(), "241861950")
	}

	func testA() throws {
		let solver = Solve1()
		let solution = solver.a()
		print(solution)
	}

	func testB() throws {
		let solver = Solve1()
		let solution = solver.b()
		print(solution)
	}
}
