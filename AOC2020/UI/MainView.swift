
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
							if puzzle.hasDetailView {
								NavigationLink(
									destination: puzzle.detailView()
								) {
									PuzzleCard(puzzle: puzzle)
								}
								.buttonStyle(PlainButtonStyle())
							} else {
								ZStack {
									VStack {
										HStack {
											Spacer()
											Image(systemName: "eye.slash")
												.padding()
										}
										Spacer()
									}

									PuzzleCard(puzzle: puzzle)
								}
							}
						}
					}
					.padding()

					Spacer()
				}
				.navigationTitle("Advent of Code 2020")
			}
			.background(Color(.systemGreen).opacity(0.1))
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