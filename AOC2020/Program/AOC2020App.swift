
import SwiftUI

@main
struct AOC2020App: App {
	let puzzles = Puzzles2020()
	var body: some Scene {
		WindowGroup {
			MainView(repo: puzzles)
				.environmentObject(PuzzleProcessing.application(puzzles: puzzles.puzzles))
		}
	}
}
