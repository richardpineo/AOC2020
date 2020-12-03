
import SwiftUI

struct DetailsView1: View {
	private var gridItemLayout = [GridItem(.adaptive(minimum: 70))]

	@ObservedObject var status = Solve1Status()

	var body: some View {
		VStack {
			if status.numbers.isEmpty {
				Text("Thinking...")
					.font(.title3)
					.padding()
			} else {
				ScrollView {
					LazyVGrid(columns: gridItemLayout) {
						ForEach(0 ..< status.numbers.count, id: \.self) { i in
							Text(status.numbers[i].description)
								.font(.system(size: 15, design: .monospaced))
								.frame(width: 50, height: 10)
								.padding(10)
								.background(status.isAnswer(byIndex: i) ? Color.green : Color.clear)
								.border(Color.blue)
						}
					}
				}
			}
		}
		.padding()
		.navigationTitle("Day 1: Report Repair")
		.onAppear {
			status.numbers = []
			status.answerIndices = []
			DispatchQueue.main.async {
				let solve = Solve1()
				_ = solve.solveB(status: status)
			}
		}
	}
}

struct Details1View_Previews: PreviewProvider {
	static var previews: some View {
		DetailsView1()
	}
}
