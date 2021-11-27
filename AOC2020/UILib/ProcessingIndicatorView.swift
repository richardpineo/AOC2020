
import SwiftUI

struct ProcessingIndicatorView: View {
	@State private var isProcessing = false

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 3)
				.stroke(Color(.systemGray5), lineWidth: 3)
				.frame(width: 250, height: 3)

			RoundedRectangle(cornerRadius: 3)
				.stroke(Color.green, lineWidth: 3)
				.frame(width: 30, height: 3)
				.offset(x: isProcessing ? 110 : -110, y: 0)
				.animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
		}
		.onAppear {
			self.isProcessing = true
		}
	}
}

struct ProcessingIndicatorView_Previews: PreviewProvider {
	static var previews: some View {
		ProcessingIndicatorView()
	}
}
