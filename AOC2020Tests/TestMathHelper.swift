import XCTest

class TestMathHelper: XCTestCase {
	func testLcm() throws {
		XCTAssertEqual(24, MathHelper.lcm(of: [1, 2, 8, 3]))
		XCTAssertEqual(252, MathHelper.lcm(of: [2, 7, 3, 9, 4]))
	}
}
