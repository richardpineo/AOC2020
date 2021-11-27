
import AOCLib
import SwiftUI

struct DetailsView4: View, Solve4Delegate {
	func processed(passport: Solve4.Passport, passed: Bool) {
		DispatchQueue.main.async {
			let line = passport.datas.reduce("") { all, one in
				all.appending(" \(one.key):\(one.value)")
			}
			numValid += passed ? 1 : 0
			listValues.insert(Passport(id: line, valid: passed, numValid: numValid), at: 0)
		}
		usleep(5000)
	}

	func complete() {
		processing = false
	}

	struct Passport: Identifiable {
		var id: String
		var valid: Bool
		var numValid: Int
	}

	@State var listValues: [Passport] = []
	@State var numValid = 0
	@State var processing = true

	var body: some View {
		VStack(spacing: 15) {
			if processing {
				ProcessingIndicatorView()
			} else {
				Text("PROCESSING COMPLETE | \(numValid) VALID PASSPORTS")
					.font(.system(size: 22, weight: .semibold, design: .monospaced))
					.foregroundColor(.green)
			}

			List(listValues) { passport in
				HStack {
					Text(passport.id)
						.foregroundColor(passport.valid ? .primary : .secondary)
						.font(.system(size: passport.valid ? 13 : 11, design: .monospaced))

					Spacer()

					if passport.valid {
						Text(String(passport.numValid))
							.font(.system(size: 15, design: .rounded))
							.foregroundColor(.green)
					}
				}
			}
		}
		.padding()
		.navigationTitle("Day 4: Passport Processing")
		.onAppear {
			listValues = []
			numValid = 0
			DispatchQueue.global(qos: .background).async {
				let solve = Solve4()
				solve.delegate = self
				_ = solve.solveB()
			}
		}
	}
}

struct DetailsView4_Previews: PreviewProvider {
	static var previews: some View {
		DetailsView4()
	}
}
