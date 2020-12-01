
import SwiftUI

struct DetailsView1: View {
	let columns = Array.init(repeating: GridItem(.flexible()), count: 8)
	
	@ObservedObject var status = Solve1Status()
	
    var body: some View {
		VStack {
			ScrollView {
				VStack {
					LazyVGrid(columns: columns) {
						ForEach(0..<status.numbers.count, id: \.self) { i in
							Text(status.numbers[i].description)
								.font(.system(size: 15, design: .monospaced))
								.frame(width: 100)
								.padding()
								.background(status.isAnswer(byIndex: i) ? Color.green : Color.clear)
						}
					}
				}
			}
		}
		.navigationTitle("Day 1: Report Repair")
		.onAppear {
			let solve = Solve1()
			// Do it sync
			_ = solve.solveB(status: status)
		}
    }
	
	
}

struct Details1View_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView1()
    }
}
