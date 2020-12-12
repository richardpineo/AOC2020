
import SwiftUI

struct MainView: View {
	@EnvironmentObject var puzzles: Puzzles

	// We want the OS to figure out the widths, just not smaller than our minimum.
	private var gridItemLayout = [GridItem(.adaptive(minimum: 200))]

	var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					ControlCenter()
						.padding(.bottom, 10)

					LazyVGrid(columns: gridItemLayout) {
						ForEach(puzzles.ordered) { puzzle in
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
												.foregroundColor(Color(.systemPink))
												.padding()
										}
										Spacer()
									}

									PuzzleCard(puzzle: puzzle)
								}
							}
						}
					}

					Spacer()
				}
				.navigationTitle("Advent of Code 2020")
				.navigationBarTitleDisplayMode(.inline)
				.padding()
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
