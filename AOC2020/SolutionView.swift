

import SwiftUI

struct SolutionView: View {
	var solution: String?

	var body: some View {
		VStack {
			if let sol = solution {
				Text(sol)
			} else {
				Text("UNSOLVED")
			}
		}
		.padding()
		.frame(maxWidth: .infinity)
		.background(Color(.gray).opacity(0.5))
		.cornerRadius(10)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 2)
		)
	}
}

struct Solutionview_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			SolutionView(solution: nil)
			SolutionView(solution: "12345678")
			SolutionView(solution: "ABC")
		}
		.previewLayout(.fixed(width: 200, height: 100))
	}
}
