
import AOCLib
import Foundation

func arrayIndex(_ row: Int, _ col: Int) -> Int {
	Position2D(row, col).arrayIndex(numCols: 10)
}

class Solve20: PuzzleSolver {
	let exampleFile = "Example20"
	let inputFile = "Input20"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "20899048083289"
	}

	func solveBExamples() -> Bool {
		solveB(.example) == "273"
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		solveB(.challenge)
	}

	class Tiles {
		var tiles: [Tile] = []
	}

	struct Tile: Hashable {
		// 10x10 array of bits
		init(id: Int, bits: [Bool]) {
			self.id = id
			self.bits = bits

			func get(at: Position2D) -> Bool {
				bits[at.arrayIndex(numCols: 10)]
			}

			func makeEdge(_ bits: [Bool]) -> String {
				bits.map { $0 ? "1" : "0" }.joined()
			}

			var t: [Bool] = []
			var l: [Bool] = []
			var b: [Bool] = []
			var r: [Bool] = []
			for index in 0 ... 9 {
				t.append(bits[arrayIndex(index, 0)])
				l.append(bits[arrayIndex(0, index)])
				b.append(bits[arrayIndex(index, 9)])
				r.append(bits[arrayIndex(9, index)])
			}

			top = makeEdge(t)
			right = makeEdge(r)
			bottom = makeEdge(b)
			left = makeEdge(l)
		}

		var id: Int
		let bits: [Bool]

		// All that really matters are the edges
		let top: String
		let right: String
		let bottom: String
		let left: String

		func flipX() -> Tile {
			var newBits = [Bool](repeating: false, count: bits.count)
			for row in 0 ... 9 {
				for col in 0 ... 9 {
					if bits[Position2D(row, col).arrayIndex(numCols: 10)] {
						newBits[Position2D(9 - row, col).arrayIndex(numCols: 10)] = true
					}
				}
			}
			return Tile(id: id, bits: newBits)
		}

		func flipY() -> Tile {
			var newBits = [Bool](repeating: false, count: bits.count)
			for row in 0 ... 9 {
				for col in 0 ... 9 {
					if bits[Position2D(row, col).arrayIndex(numCols: 10)] {
						newBits[Position2D(row, 9 - col).arrayIndex(numCols: 10)] = true
					}
				}
			}
			return Tile(id: id, bits: newBits)
		}

		func rotate() -> Tile {
			Tile(id: id, bits: rotate(bits: bits))
		}

		private func rotate(bits: [Bool]) -> [Bool] {
			var newBits = [Bool](repeating: false, count: bits.count)
			let layers = 5
			for layer in 0 ..< layers {
				let first = layer
				let last = 10 - 1 - layer

				for i in first ..< last {
					let top = arrayIndex(first, i)
					let left = arrayIndex(last - (i - first), first)
					let bottom = arrayIndex(last, last - (i - first))
					let right = arrayIndex(i, last)

					newBits[top] = bits[left]
					newBits[left] = bits[bottom]
					newBits[bottom] = bits[right]
					newBits[right] = bits[top]
				}
			}
			return newBits
		}

		var edges: [String] {
			[top, right, bottom, left,
			 String(top.reversed()), String(right.reversed()), String(left.reversed()), String(bottom.reversed())]
		}

		func canMatch(other: Tile) -> Bool {
			if self == other {
				return false
			}

			let otherEdges = other.edges
			return edges.first { otherEdges.contains($0) } != nil
		}
	}

	private func solve(_ filename: String) -> String {
		let tiles = load(filename)

		// Let's just go for magic to start.
		// If a tile can match 2 other tiles, we'll call it a corner tile.
		var matches2: [Int] = []
		for tile in tiles.tiles {
			let ids = tiles.tiles.filter { tile.canMatch(other: $0) }.map(\.id)
			if ids.count == 2 {
				matches2.append(tile.id)
			}
		}

		// there should be 4
		if matches2.count == 4 {
			let answer = matches2.reduce(1) { sum, value in sum * value }
			return answer.description
		}

		return "So fail"
	}

	private func solveB(_ data: Stolen20InputData) -> String {
		let answer = Stolen20Part2.run(data)
		return answer.description
	}

	private func loadTile(data: [String]) -> Tile {
		let tileId = Int(data[0].dropFirst(5).dropLast())!

		var bits = Array(repeating: false, count: 100)
		for row in 0 ... 9 {
			let line = data[row + 1]
			for col in 0 ... 9 {
				let enabled = line.character(at: col) == "#"
				bits[row * 10 + col] = enabled
			}
		}
		let tile = Tile(id: tileId, bits: bits)
		return tile
	}

	private func load(_ filename: String) -> Tiles {
		let lines = FileHelper.load(filename)!

		let tiles = Tiles()
		// chunks of twelve
		for chunk in 0 ..< lines.count / 12 {
			let startIndex = chunk * 12
			let data = lines[startIndex ..< (startIndex + 12)]
			let tile = loadTile(data: Array(data))
			tiles.tiles.append(tile)
		}
		return tiles
	}
}
