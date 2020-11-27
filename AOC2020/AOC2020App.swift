
import SwiftUI

@main
struct AOC2020App: App {
	var body: some Scene {
		WindowGroup {
			MainView()
				.environmentObject(Puzzles())
		}
	}
}
