import XCTest

class TestSolve1: XCTestCase {

    func testSolve1() throws {
		let solver = Solve1()
		XCTAssertEqual(solver.example(), "514579")
    }
}
