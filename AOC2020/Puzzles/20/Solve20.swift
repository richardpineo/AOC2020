
import Foundation

class Solve20: PuzzleSolver {
	let exampleFile = "Example20"
	let inputFile = "Input20"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "20899048083289"
	}

	func solveBExamples() -> Bool {
		false
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		""
	}
	
	class Tiles {
		var tiles: [Tile] = []
	}
	
	struct Tile: Hashable {
		// 10x10 array of bits
		init(id: Int, bits: [Bool]) {
			
			self.id = id
			
			func get(at: Position2D) -> Bool {
				return bits[at.arrayIndex(numCols: 10)]
			}
			
			func makeEdge(_ bits: [Bool]) -> String {
			   return bits.map { $0 ? "1" : "0" }.joined()
		   }
			
			var t: [Bool] = []
			var l: [Bool] = []
			var b: [Bool] = []
			var r: [Bool] = []
			for index in 0...9 {
				t.append(get(at: .init(index, 0)))
				l.append(get(at: .init(0, index)))
				b.append(get(at: .init(index, 9)))
				r.append(get(at: .init(9, index)))
			}
			
			top = makeEdge(t)
			right = makeEdge(r)
			bottom = makeEdge(b)
			left = makeEdge(l)
		}
		
		var id: Int

		// All that really matters are the edges
		let top: String
		let right: String
		let bottom: String
		let left: String
		
		var edges: [String] {
			[top, right, bottom, left,
			 String(top.reversed()), String(right.reversed()), String(left.reversed()), String(bottom.reversed())]
		}
		
		func canMatch(other: Tile) -> Bool {
			if self == other {
				return false
			}
			
			let otherEdgs = other.edges
			return nil != edges.first { otherEdgs.contains($0)}
		}
	}

	private func solve(_ filename: String) -> String {
		let tiles = load(filename)
		
		// Let's just go for magic to start.
		// If a tile can match 2 other tiles, we'll call it a corner tile.
		var matches2: [Int] = []
		for tile in tiles.tiles {
			let ids = tiles.tiles.filter { tile.canMatch(other: $0) }.map { $0.id }
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
	
	private func loadTile(data: [String]) -> Tile {
		let tileId = Int(data[0].dropFirst(5).dropLast())!
		
		var bits = Array(repeating: false, count: 100)
		for row in 0...9 {
			let line = data[row + 1]
			for col in 0...9 {
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
		for chunk in 0..<lines.count/12 {
			let startIndex = chunk * 12
			let data = lines[startIndex..<(startIndex + 12)]
			let tile = loadTile(data: Array(data))
			tiles.tiles.append(tile)
		}
		return tiles
	}
}
