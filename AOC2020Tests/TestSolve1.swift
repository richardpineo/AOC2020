import XCTest

class TestSolve1: XCTestCase {

    func testExample() throws {
		let solver = Solve1()
		XCTAssertEqual(solver.example(), "514579")
    }

	func testA() throws {
		let solver = Solve1()
		let solution = solver.a()
		print(solution)
	}
}
