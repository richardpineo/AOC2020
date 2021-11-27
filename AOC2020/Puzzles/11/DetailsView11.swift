
import AOCLib
import SwiftUI

struct DetailsView11: View, Solve11Delegate {
	@State var seats: [Solve11.Seats] = []
	@State var isA: Bool = true
	@State var isExample: Bool = true
	@State var images: Bool = true
	@State var isWorking: Bool = false
	@State var iteration: Double = 0

	var body: some View {
		VStack {
			HStack {
				Button(action: {
					self.process()
				}) {
					Image(systemName: "play")
					Text("Go")
				}
				.padding()
				.foregroundColor(.white)
				.background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))

				HStack {
					Text("Part A")
					Toggle(isOn: $isA) {
						Text("Part A")
					}
					.labelsHidden()
				}
				.padding()

				HStack {
					Text("Example")
					Toggle(isOn: $isExample) {
						Text("Example")
					}
					.labelsHidden()
				}
				.padding()

				HStack {
					Text("Images")
					Toggle(isOn: $images) {
						Text("Images")
					}
					.labelsHidden()
				}
				.padding()

				Text("\(seats.count) iterations")
					.padding()

				if isWorking {
					ProcessingIndicatorView()
				} else {
					if self.seats.count > 0 {
						Slider(value: $iteration, in: 0 ... Double(self.seats.count - 1), step: 1.0)
						Text("\(Int(iteration))")
							.padding()
					}
				}

				Spacer()
			}

			if let seat = selection {
				ScrollView([.horizontal, .vertical]) {
					LazyVGrid(columns: gridLayout) {
						ForEach(0 ..< seat.maxIndex) { index in
							if images {
								let (imageName, color) = image(seat, index)
								Image(systemName: imageName)
									.foregroundColor(color)
							} else {
								Text(text(seat, index))
							}
						}
					}
				}
			}

			Spacer()
		}
		.padding()
		.navigationTitle("Day 11: Seating System")
	}

	var gridLayout: [GridItem] {
		guard let sel = selection else {
			return []
		}
		return [GridItem](repeating: GridItem(.fixed(10)), count: sel.maxSeat.x)
	}

	func image(_ seats: Solve11.Seats, _ index: Int) -> (String, Color) {
		switch seats.query(at: index) {
		case .occupied:
			return ("person.fill", .primary)
		case .open:
			return ("person", .secondary)
		case .none:
			return ("square", .secondary)
		}
	}

	func text(_ seats: Solve11.Seats, _ index: Int) -> String {
		switch seats.query(at: index) {
		case .occupied:
			return "#"
		case .open:
			return "L"
		case .none:
			return "."
		}
	}

	var selection: Solve11.Seats? {
		let index = Int(iteration)
		if index < seats.count {
			return seats[index]
		}
		return nil
	}

	func process() {
		seats = []
		isWorking = true
		iteration = 0.0

		DispatchQueue.global(qos: .background).async {
			let solve = Solve11()
			solve.delegate = self
			switch (isA, isExample) {
			case (true, true):
				_ = solve.solveAExamples()
			case (true, false):
				_ = solve.solveA()
			case (false, true):
				_ = solve.solveBExamples()
			case (false, false):
				_ = solve.solveB()
			}
		}
	}

	func newState(seats: Solve11.Seats?) {
		DispatchQueue.main.async {
			if let s = seats {
				self.seats.append(s)
			} else {
				isWorking = false
			}
		}
	}
}

struct DetailsView11_Previews: PreviewProvider {
	static var previews: some View {
		DetailsView11()
	}
}
