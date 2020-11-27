
import SwiftUI

struct MainView: View {
	@EnvironmentObject var puzzles: Puzzles

	// We want the OS to figure out the widths, just not smaller than our minimum.
	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
	]

	var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					LazyVGrid(columns: columns) {
						ForEach(puzzles.puzzles) { puzzle in
							NavigationLink(
								destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/
							) {
								PuzzleCard(puzzle: puzzle)
							}
							.buttonStyle(PlainButtonStyle())
						}
					}
					.padding()

					Spacer()
				}
				.navigationTitle("Advent of Code 2020")
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
			.environmentObject(Puzzles())
	}
}
