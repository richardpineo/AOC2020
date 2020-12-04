import Foundation

class Solve4Status: ObservableObject {
	@Published var numbers: [Int] = []
	@Published var answerIndices: [Int] = []

	func isAnswer(byIndex: Int) -> Bool {
		answerIndices.contains(byIndex)
	}
}
