
import SwiftUI

@main
struct AOC2020App: App {
	let puzzles = Puzzles.application()
	var body: some Scene {
		WindowGroup {
			MainView()
				.environmentObject(puzzles)
				.environmentObject(PuzzleProcessing.application(puzzles: puzzles))
		}
	}
}
