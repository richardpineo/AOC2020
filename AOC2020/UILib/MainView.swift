
import AOCLib
import SwiftUI

struct MainView<Repo: PuzzlesRepo>: View {
	var repo: Repo

	// We want the OS to figure out the widths, just not smaller than our minimum.
	private let gridItemLayout = [GridItem(.adaptive(minimum: 200))]

	var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					ControlCenter()
						.padding(.bottom, 10)

					LazyVGrid(columns: gridItemLayout) {
						ForEach(repo.puzzles.ordered) { puzzle in
							if repo.hasDetails(id: puzzle.id) {
								NavigationLink(
									destination: repo.details(id: puzzle.id)
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
				.navigationTitle(repo.title)
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
		MainView(repo: PuzzlePreview())
			.environmentObject(Puzzles())
	}
}
