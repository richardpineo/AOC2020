
import SwiftUI

struct ShipState {
	var ship: Solve12.Ship
	var waypoint: Position2D?
}

var shipStates: [ShipState] = []
var shipStatesCalculating: [ShipState] = []
var shipDim: CGFloat = 0
var step: Int = 0

struct DetailsView12: View, Solve12Delegate {
	@State var isA: Bool = true
	@State var shipAngle: Angle = .zero
	@State var shipOffset: CGSize = .zero

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
				.background(RoundedRectangle(cornerRadius: 10)
								.foregroundColor(.blue))

				HStack {
					Text("Part A")
					Toggle(isOn: $isA) {
						Text("Part A")
					}
					.labelsHidden()
				}
				.padding()

				if !shipStates.isEmpty {
					Text("\(step % shipStates.count)/\(shipStates.count)")
				}
				
				Text("this one is the lame")
					.font(.system(size: 13, weight: .bold))

				Spacer()
			}
			.padding()

			ZStack {
				RoundedRectangle(cornerRadius: 15)
					.fill(Color(.systemBlue))
				
				Rectangle()
					.stroke(lineWidth: 1)
					.foregroundColor(.secondary)
					.frame(width:1)
				
				Rectangle()
					.stroke(lineWidth: 1)
					.foregroundColor(.secondary)
					.frame(height:1)

				Image(systemName: "airplane")
					.rotationEffect(shipAngle)
					.offset(shipOffset)
					.animation(.default)
			}
			.frame(width: oceanDim, height: oceanDim)
			.padding()
			
			Spacer()
		}
		.onReceive(self.timer) { _ in
			step = step + 1
			if !shipStates.isEmpty {
				updateShip()
			}
		}
	}
	
	let oceanDim = CGFloat(700)

	private func updateShip() {
		if shipStates.count == 0 || shipDim == 0 {
			return
		}
		let index = step % shipStates.count
		let ship = shipStates[index].ship

		let factor = CGFloat(oceanDim / shipDim)
		
		shipOffset = CGSize(
			width: CGFloat(ship.position.x) * factor,
			height: CGFloat(ship.position.y) * factor)

		shipAngle = .init(degrees: Double(ship.heading.clockwiseFromEast))
	}

	private static let updateHz = 0.25
	private let timer = Timer.publish(every: updateHz, on: .main, in: .common).autoconnect()

	func process() {
		shipStates = []
		shipStatesCalculating = []

		DispatchQueue.global(qos: .background).async {
			let solve = Solve12()
			solve.delegate = self
			if isA {
				_ = solve.solveA()
			} else {
				_ = solve.solveB()
			}
		}
	}

	func shipMoved(ship: Solve12.Ship?, waypoint: Position2D?) {
		DispatchQueue.main.async {
			if let s = ship {
				shipStatesCalculating.append(ShipState(ship: s, waypoint: waypoint))
			} else {
				// we want a square. Find the biggest value in any dim.
				var maxAxis = 0
				for ss in shipStatesCalculating {
					maxAxis = max(abs(ss.ship.position.x), abs(ss.ship.position.y), maxAxis)
				}
				shipDim = CGFloat(maxAxis)
				shipStates = shipStatesCalculating
				step = 0
			}
		}
	}
}

struct DetailsView12_Previews: PreviewProvider {
	static var previews: some View {
		DetailsView12()
	}
}
