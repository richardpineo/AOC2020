//
//  main.swift
//  Day 20
//
//  Copyright © 2020 peter bohac. All rights reserved.
//
// stolen from: https://github.com/gernb/AdventOfCode2020/blob/main/Day%2020/main.swift
//

import Foundation

struct Tile {
	let id: Int
	let image: [[Int]]

	let top: (Int, Int)
	let bottom: (Int, Int)
	let left: (Int, Int)
	let right: (Int, Int)

	var edges: [(Int, Int)] { [top, right, bottom, left] }

	init(_ string: String) {
		let lines = string.components(separatedBy: .newlines)
		id = Int(lines.first!.components(separatedBy: " ").last!.dropLast())!
		image = lines.dropFirst().map { $0.map { $0 == "#" ? 1 : 0 } }

		top = (
			Int(image.first!.map(String.init).joined(), radix: 2)!,
			Int(image.first!.map(String.init).reversed().joined(), radix: 2)!
		)
		bottom = (
			Int(image.last!.map(String.init).joined(), radix: 2)!,
			Int(image.last!.map(String.init).reversed().joined(), radix: 2)!
		)
		left = (
			Int(image.map { String($0.first!) }.joined(), radix: 2)!,
			Int(image.map { String($0.first!) }.reversed().joined(), radix: 2)!
		)
		right = (
			Int(image.map { String($0.last!) }.joined(), radix: 2)!,
			Int(image.map { String($0.last!) }.reversed().joined(), radix: 2)!
		)
	}
}

// MARK: - Part 1

enum Part1 {
	static func allEdges(except tile: Tile, tiles: [Tile]) -> Set<Int> {
		var edges = Set<Int>()
		tiles.forEach { t in
			if t.id == tile.id { return }
			for edge in t.edges {
				edges.insert(edge.0)
				edges.insert(edge.1)
			}
		}
		return edges
	}

	static func cornerTiles(in tiles: [Tile]) -> [Tile] {
		let tilesAndEdgeCounts: [(tile: Tile, matchingEdges: Int)] = tiles.map { tile in
			let otherEdges = allEdges(except: tile, tiles: tiles)
			let matches = tile.edges.reduce(0) { result, edge in
				if otherEdges.contains(edge.0) || otherEdges.contains(edge.1) {
					return result + 1
				} else {
					return result
				}
			}
			return (tile, matches)
		}
		return tilesAndEdgeCounts.filter { $0.matchingEdges == 2 }.map(\.0)
	}

	static func run(_ source: Stolen20InputData) {
		let tiles = source.data.map(Tile.init)
		let corners = cornerTiles(in: tiles)
		print("Part 1 (\(source)): \(corners.reduce(1) { $0 * $1.id })")
		print(corners.map(\.id))
	}
}

// MARK: - Part 2

extension Array where Element == [Int] {
	mutating func flip() {
		self = reversed()
	}

	mutating func rotate() {
		assert(count == first?.count) // must be square
		var newArray = [Element]()
		for i in 0 ..< count {
			newArray.append(map { $0[i] }.reversed())
		}
		self = newArray
	}

	func draw() {
		for y in 0 ..< count {
			for x in 0 ..< self[y].count {
				print(self[y][x] == 1 ? "#" : ".", terminator: "")
			}
			print("")
		}
	}
}

final class TileNode {
	let id: Int
	var image: [[Int]]
	let allEdges: Set<Int>
	var connectedTiles: [Edge: TileNode]

	var currentEdges: [Int] {
		[value(for: .top), value(for: .right), value(for: .bottom), value(for: .left)]
	}

	var trimmedImage: [[Int]] {
		image.dropFirst().dropLast().map { $0.dropFirst().dropLast() }
	}

	enum Edge {
		case top, bottom, left, right
		var opposite: Edge {
			switch self {
			case .top: return .bottom
			case .bottom: return .top
			case .left: return .right
			case .right: return .left
			}
		}
	}

	init(_ string: String) {
		let lines = string.components(separatedBy: .newlines)
		id = Int(lines.first!.components(separatedBy: " ").last!.dropLast())!
		image = lines.dropFirst().map { $0.map { $0 == "#" ? 1 : 0 } }
		allEdges = .init([
			Int(image.first!.map(String.init).joined(), radix: 2)!,
			Int(image.first!.map(String.init).reversed().joined(), radix: 2)!,
			Int(image.last!.map(String.init).joined(), radix: 2)!,
			Int(image.last!.map(String.init).reversed().joined(), radix: 2)!,
			Int(image.map { String($0.first!) }.joined(), radix: 2)!,
			Int(image.map { String($0.first!) }.reversed().joined(), radix: 2)!,
			Int(image.map { String($0.last!) }.joined(), radix: 2)!,
			Int(image.map { String($0.last!) }.reversed().joined(), radix: 2)!,
		])
		connectedTiles = [:]
	}

	init(_ tile: TileNode) {
		id = tile.id
		image = tile.image
		allEdges = tile.allEdges
		connectedTiles = tile.connectedTiles
	}

	func value(for edge: Edge) -> Int {
		switch edge {
		case .top: return Int(image.first!.map(String.init).joined(), radix: 2)!
		case .bottom: return Int(image.last!.map(String.init).joined(), radix: 2)!
		case .left: return Int(image.map { String($0.first!) }.joined(), radix: 2)!
		case .right: return Int(image.map { String($0.last!) }.joined(), radix: 2)!
		}
	}

	func flipped() -> TileNode {
		let newTile = TileNode(self)
		newTile.image.flip()
		return newTile
	}

	func rotated() -> TileNode {
		let newTile = TileNode(self)
		newTile.image.rotate()
		return newTile
	}

	func allPositions() -> [TileNode] {
		var result = [TileNode(self)]
		result.append(result.last!.rotated())
		result.append(result.last!.rotated())
		result.append(result.last!.rotated())
		result.append(result.last!.flipped())
		result.append(result.last!.rotated())
		result.append(result.last!.rotated())
		result.append(result.last!.rotated())
		return result
	}
}

extension TileNode: Equatable {
	static func == (lhs: TileNode, rhs: TileNode) -> Bool {
		lhs.id == rhs.id
	}
}

enum Stolen20Part2 {
	static var tiles = [Int: TileNode]()

	static func firstCornerId(_ source: Stolen20InputData) -> Int {
		Part1.cornerTiles(in: source.data.map(Tile.init)).map(\.id).first!
	}

	static func tilesMatching(tile: TileNode, edge: Int) -> [TileNode] {
		var result = [TileNode]()
		for other in tiles.values {
			if other == tile { continue }
			if other.allEdges.contains(edge) {
				result.append(other)
			}
		}
		return result
	}

	static func fitFirstTile(_ node: TileNode) {
		for tile in node.allPositions() {
			let rightMatch = tilesMatching(tile: tile, edge: tile.value(for: .right)).first
			let bottomMatch = tilesMatching(tile: tile, edge: tile.value(for: .bottom)).first
			if let _ = rightMatch, let _ = bottomMatch {
				node.image = tile.image
				return
			}
		}
	}

	static func fitRow(_ root: TileNode, isFirst: Bool = false) {
		var current = root
		while true {
			let rightEdge = current.value(for: .right)
			let matches = tilesMatching(tile: current, edge: rightEdge)
			if matches.count == 0 {
				return
			}
			assert(matches.count == 1)
			let tile = matches.first!.allPositions().first(where: { $0.value(for: .left) == rightEdge })!
			current.connectedTiles[.right] = tile
			tile.connectedTiles[.left] = current

			let topMatches = tilesMatching(tile: tile, edge: tile.value(for: .top))
			if isFirst {
				assert(topMatches.count == 0)
			} else {
				assert(topMatches.count == 1)
				tile.connectedTiles[.top] = topMatches.first!
				topMatches.first!.connectedTiles[.bottom] = tile
			}
			current = tile
		}
	}

	static func fitRest(_ root: TileNode) {
		var current = root
		while true {
			let bottomEdge = current.value(for: .bottom)
			let matches = tilesMatching(tile: current, edge: bottomEdge)
			if matches.count == 0 {
				return
			}
			assert(matches.count == 1)
			let tile = matches.first!.allPositions().first(where: { $0.value(for: .top) == bottomEdge })!
			current.connectedTiles[.bottom] = tile
			tile.connectedTiles[.top] = current
			fitRow(tile)
			current = tile
		}
	}

	static func stitchImage(startingFrom root: TileNode) -> [[Int]] {
		var image: [[Int]] = []
		var current: TileNode? = root
		while let row = current {
			var lines = row.trimmedImage
			var next = row.connectedTiles[.right]
			while let tile = next {
				tile.trimmedImage.enumerated().forEach { idx, line in
					lines[idx].append(contentsOf: line)
				}
				next = tile.connectedTiles[.right]
			}
			image.append(contentsOf: lines)
			current = row.connectedTiles[.bottom]
		}
		return image
	}

	static let seaMonster = [
		"                  # ",
		"#    ##    ##    ###",
		" #  #  #  #  #  #   ",
	].map { line in
		line.map { $0 == "#" ? 1 : 0 }
	}

	static func searchImage(_ image: inout [[Int]]) -> Int {
		var found = 0
		let monsterInts = seaMonster.map { Int($0.map(String.init).joined(), radix: 2)! }
		let monsterLen = seaMonster[0].count
		for y in 0 ..< image.count - (seaMonster.count - 1) {
			for x in 0 ..< image[y].count - (monsterLen - 1) {
				let imageInts = [
					image[y][x ..< x + monsterLen],
					image[y + 1][x ..< x + monsterLen],
					image[y + 2][x ..< x + monsterLen],
				].map { line in
					Int(line.map(String.init).joined(), radix: 2)!
				}
				if zip(imageInts, monsterInts).allSatisfy({ imageInt, monsterInt in
					imageInt & monsterInt == monsterInt
				}) {
					found += 1
				}
			}
		}
		return found
	}

	static func run(_ source: Stolen20InputData) -> Int {
		tiles = source.data.map(TileNode.init)
			.reduce(into: [Int: TileNode]()) { $0[$1.id] = $1 }
		let firstCorner = tiles[firstCornerId(source)]!
		let root = tiles[firstCorner.id]!
		fitFirstTile(root)
		fitRow(root, isFirst: true)
		fitRest(root)
		var image = stitchImage(startingFrom: root)
		var allPositions = Array(repeating: image, count: 8)
		allPositions[1].rotate()
		allPositions[2] = allPositions[1]; allPositions[2].rotate()
		allPositions[3] = allPositions[2]; allPositions[3].rotate()
		allPositions[4] = allPositions[3]; allPositions[4].flip()
		allPositions[5] = allPositions[4]; allPositions[5].rotate()
		allPositions[6] = allPositions[5]; allPositions[6].rotate()
		allPositions[7] = allPositions[6]; allPositions[7].rotate()
		var monsterCount = 0
		for idx in allPositions.indices {
			let count = searchImage(&allPositions[idx])
			if count > 0 {
				image = allPositions[idx]
				monsterCount = count
				break
			}
		}
		let monsterPixelCount = seaMonster.map { $0.reduce(0, +) }.reduce(0, +)
		let imagePixelCount = image.map { $0.reduce(0, +) }.reduce(0, +)
		let roughness = imagePixelCount - monsterPixelCount * monsterCount
		return roughness
	}
}

enum Stolen20InputData: String, CaseIterable {
	case example, challenge

	var data: [String] {
		switch self {
		case .example: return """
			Tile 2311:
			..##.#..#.
			##..#.....
			#...##..#.
			####.#...#
			##.##.###.
			##...#.###
			.#.#.#..##
			..#....#..
			###...#.#.
			..###..###

			Tile 1951:
			#.##...##.
			#.####...#
			.....#..##
			#...######
			.##.#....#
			.###.#####
			###.##.##.
			.###....#.
			..#.#..#.#
			#...##.#..

			Tile 1171:
			####...##.
			#..##.#..#
			##.#..#.#.
			.###.####.
			..###.####
			.##....##.
			.#...####.
			#.##.####.
			####..#...
			.....##...

			Tile 1427:
			###.##.#..
			.#..#.##..
			.#.##.#..#
			#.#.#.##.#
			....#...##
			...##..##.
			...#.#####
			.#.####.#.
			..#..###.#
			..##.#..#.

			Tile 1489:
			##.#.#....
			..##...#..
			.##..##...
			..#...#...
			#####...#.
			#..#.#.#.#
			...#.#.#..
			##.#...##.
			..##.##.##
			###.##.#..

			Tile 2473:
			#....####.
			#..#.##...
			#.##..#...
			######.#.#
			.#...#.#.#
			.#########
			.###.#..#.
			########.#
			##...##.#.
			..###.#.#.

			Tile 2971:
			..#.#....#
			#...###...
			#.#.###...
			##.##..#..
			.#####..##
			.#..####.#
			#..#.#..#.
			..####.###
			..#.#.###.
			...#.#.#.#

			Tile 2729:
			...#.#.#.#
			####.#....
			..#.#.....
			....#..#.#
			.##..##.#.
			.#.####...
			####.#.#..
			##.####...
			##..#.##..
			#.##...##.

			Tile 3079:
			#.#.#####.
			.#..######
			..#.......
			######....
			####.#..#.
			.#...#.##.
			#.#####.##
			..#.###...
			..#.......
			..#.###...
			""".components(separatedBy: "\n\n")

		case .challenge: return """
			Tile 2729:
			###.######
			.......#.#
			#..#......
			....#.#...
			...#.....#
			.....#.###
			...#.....#
			........#.
			..........
			#.......##

			Tile 1783:
			..#.#.#.##
			#..#......
			...##....#
			..........
			#.#...###.
			.#........
			.....#....
			.#.#.#....
			##...##...
			..###..#.#

			Tile 3889:
			.#..#..###
			###....###
			#..#..#..#
			#...#....#
			#...#.#..#
			.......#.#
			......#..#
			#.#...#..#
			#.#......#
			#.#.#.....

			Tile 3851:
			#.##......
			...#.#.###
			#.......#.
			#..#.....#
			..........
			...##.....
			#...#....#
			...#....##
			.#....#.#.
			#..##.####

			Tile 1747:
			#.#.##.##.
			#......#.#
			.........#
			..........
			..........
			#..#..#..#
			.##.#..#..
			#...#.#...
			.#.#......
			#..###.#.#

			Tile 1627:
			.#.###..#.
			...#.....#
			..#......#
			#.......##
			#.#....#.#
			#.#......#
			#.#.......
			#...##..#.
			...#.#...#
			...#.#..##

			Tile 1433:
			##..####.#
			...#...#.#
			#........#
			.##..#...#
			......#.#.
			#..##..###
			#....#.##.
			.#.....#..
			#........#
			#....#.##.

			Tile 1213:
			.#.##..#.#
			#........#
			.#......#.
			..#.......
			...#...#..
			.....#....
			.....#....
			......#...
			.#.#......
			#.##....##

			Tile 1741:
			#..#...###
			........#.
			#...###..#
			##........
			.##.......
			##...#...#
			..........
			#..#..#.##
			###.#..##.
			####.###.#

			Tile 2083:
			#.####.###
			...#......
			#...#.....
			##........
			#...#.....
			.#..#..##.
			#..#.##..#
			.#..###..#
			#.#......#
			.##...###.

			Tile 2063:
			#...#.#..#
			#...#....#
			#.#......#
			##......#.
			.#.......#
			#.........
			#..#...#.#
			........#.
			.#.#......
			..#.#.#..#

			Tile 1109:
			.##.#.####
			......#...
			#........#
			#....#..#.
			##...#...#
			#..#.....#
			.......#..
			.#..#...#.
			#........#
			#..#.##.#.

			Tile 1049:
			####..#...
			##.....#.#
			#.##...#.#
			...#......
			.#......#.
			#........#
			#...##.#..
			##.......#
			.##.....#.
			#####..##.

			Tile 1979:
			#.###.###.
			...#.#...#
			..#......#
			#.#.#...#.
			##........
			........#.
			#...##....
			#.......##
			.#....#...
			#..#.###.#

			Tile 1193:
			#.#...#..#
			##.##...#.
			...#.#....
			#.##.#....
			......#.#.
			#.........
			#.#......#
			..#.......
			#.........
			...##..###

			Tile 3659:
			...#...##.
			###.#.....
			#..#.....#
			..##.##...
			#.#....##.
			#.#......#
			#.......##
			.#.....#.#
			.####....#
			.#######.#

			Tile 1811:
			.#..####..
			#...#.....
			.........#
			...#....#.
			.......#..
			.........#
			#........#
			........##
			#.#..#....
			###.######

			Tile 3541:
			####.##..#
			##..###..#
			##.#.#....
			..........
			...#....##
			##....#..#
			###.....#.
			#.......##
			..#.......
			##..###.##

			Tile 2113:
			##..#..#.#
			##..##.#.#
			#.......##
			.#...##...
			..#.#.....
			#.......##
			...#..#.##
			#.....#...
			#..##.....
			##.##...#.

			Tile 2081:
			.##.###..#
			#.#..#...#
			#......##.
			....#....#
			...#.....#
			#.....####
			#........#
			.##......#
			#...#.....
			.####.#...

			Tile 1021:
			##.###.#.#
			.#.#..#...
			##.#.#####
			#...#....#
			.....#.#..
			#.........
			....#.....
			...#...#.#
			..##.#....
			.#.#.###.#

			Tile 1487:
			..#.#.####
			.##..##...
			..#.###..#
			.##....#..
			.#.#..#.##
			..#..#..##
			##....##.#
			........##
			...#.##...
			#..#.#....

			Tile 3767:
			.#..##.###
			#.#..#...#
			#....#..##
			#...#.....
			.#.#..#...
			##..#....#
			#.#.##.#.#
			#....#..#.
			#....##..#
			##..###..#

			Tile 3109:
			#..#.#####
			.#..##...#
			..#.#....#
			#..#.##..#
			.......#..
			#......#.#
			..##.#...#
			.#..#.....
			#.........
			##......#.

			Tile 1009:
			#..##.###.
			..........
			##.......#
			#.#..##..#
			.....#...#
			.........#
			...#.....#
			####.#....
			##...#...#
			....#..##.

			Tile 2693:
			#.#..#..#.
			..#.#..#..
			...##.#...
			#.....#.##
			.#.......#
			.#..###...
			....##...#
			#..#.#..#.
			......#..#
			.##...#.#.

			Tile 3533:
			.#.#.#####
			##...#....
			#.....#...
			.........#
			#........#
			#......#..
			...#.....#
			#..#.#....
			..##.....#
			.#.#.#.##.

			Tile 1171:
			....#....#
			...##...##
			#..#..##.#
			#........#
			........#.
			#..#....##
			...#.....#
			.........#
			#....#...#
			##.#####..

			Tile 1279:
			..#.##.###
			#.....#..#
			..##..#..#
			......#...
			#..#...#..
			...##..##.
			.#.....#.#
			#.....###.
			.....#....
			..#..##.#.

			Tile 1583:
			###..###..
			#......#..
			.#..#..##.
			...#......
			...#....##
			#...#.#...
			...#.....#
			...#.....#
			#..##.#...
			#.#.#...##

			Tile 1129:
			####..#...
			.......###
			#..##..#..
			##.##...#.
			......##..
			....#..#..
			##.....#..
			.....#...#
			##......##
			..###...#.

			Tile 2591:
			#..##.#.#.
			#......#.#
			#........#
			#.#.......
			#..#.#....
			....#..###
			...#......
			..#.....#.
			#...##.#..
			#.##..###.

			Tile 1597:
			##.#.####.
			.#..#.#..#
			#.........
			##....#..#
			#........#
			..........
			#...#.....
			.#.......#
			.......#.#
			#...####..

			Tile 1423:
			#....#####
			..#......#
			..##.#..##
			.#..##.#.#
			#.........
			.#......#.
			#.....#...
			##.#.#...#
			#....#....
			.#...#.###

			Tile 1669:
			#.##.#...#
			..#.##.#..
			#.......#.
			.....#....
			.#..#.#...
			.....#....
			.......#..
			..........
			##.##.....
			#.#.#.##..

			Tile 1283:
			##..###.#.
			.....#...#
			#..#.....#
			#...#....#
			#.##.....#
			#...#.#..#
			#........#
			.#...##.##
			#...#.#..#
			#..#.#.###

			Tile 2371:
			.##.###.##
			#......##.
			.#.......#
			#....#....
			#........#
			#....#....
			........##
			..#.....#.
			.......#..
			#..###...#

			Tile 3823:
			..#.######
			..#......#
			.....#...#
			....#...##
			#.####...#
			......#...
			##....#..#
			.#.......#
			#.#..#.#..
			####.##.#.

			Tile 2141:
			..#...####
			...#...#.#
			#.........
			..###.#.#.
			...##.#..#
			#.#..##...
			..#.......
			...#......
			#..#.#.##.
			##.#.#.#.#

			Tile 1861:
			#....##...
			.#..#.....
			##.#......
			.##..#.###
			#.#.#.....
			#...##..##
			.#..##...#
			....##.#.#
			#......##.
			#.###.#.##

			Tile 1063:
			..##.#..#.
			....##....
			#...##.#.#
			#...#.#..#
			##....##.#
			#.....##..
			.#.#.###.#
			..#...#...
			#.........
			#.#.####..

			Tile 1847:
			.#...##.##
			.#.......#
			..........
			.........#
			.#........
			....#..###
			#.##....#.
			..#...#...
			#.....#...
			#.#..#....

			Tile 1733:
			#..#.#.#.#
			..#.....#.
			#........#
			#.#..#...#
			.####....#
			.#........
			.##......#
			#.......##
			........##
			#...##..##

			Tile 2441:
			....######
			#......###
			.#......#.
			#..#....#.
			.#..#.#..#
			....#.....
			.....##...
			##.......#
			....##....
			#......###

			Tile 3631:
			##.#.#.#.#
			#.##.##.#.
			#..#..#...
			..##.#...#
			#.#.###...
			#..#...#..
			#....#...#
			...##.##.#
			...#..#..#
			##..#.##.#

			Tile 2543:
			#..#####..
			.##....##.
			##...##...
			......#...
			.###.....#
			...#......
			..##.#..##
			.##.......
			#..#......
			#.####.#..

			Tile 1297:
			..#.#..#..
			........#.
			#.#.......
			#..#.#....
			.#..#####.
			#.##....##
			#......##.
			#..#...##.
			#.#..#.##.
			###..#..##

			Tile 2099:
			#..#..##.#
			..#.......
			#.#..#....
			#..#..#...
			#.#..#..##
			...##...##
			#.........
			.##.#..#.#
			#...##.#.#
			###...#..#

			Tile 2203:
			.#.#..##..
			...#.#....
			..#....#.#
			.#..#....#
			.#.##.##..
			#.##...##.
			........##
			...#.#....
			.......###
			...##.##.#

			Tile 3517:
			#..#.#..#.
			..........
			...#.....#
			..........
			......####
			.#........
			.#........
			......##.#
			#..##...#.
			.##.###.#.

			Tile 2143:
			....###.#.
			#......#.#
			#....#..#.
			##....##.#
			##....##..
			#.........
			.#....##.#
			#.#.##..##
			..#.....##
			.###.##.#.

			Tile 2791:
			###..#..##
			###.......
			....#.....
			#.........
			#.###.##..
			....####..
			...#.....#
			....#....#
			.....##.##
			.##.###..#

			Tile 2131:
			#.#.###.#.
			...#.....#
			#.#..##...
			#.#...#...
			........#.
			..........
			##.......#
			..###...#.
			..##.....#
			...#...##.

			Tile 3797:
			####...##.
			.##.......
			.......#..
			......##.#
			...#..#..#
			#.........
			##....##.#
			.....#.#.#
			#.........
			####..###.

			Tile 1327:
			.#...#..#.
			#...#.....
			.......#.#
			#.###..#..
			.....#....
			.#...#....
			.........#
			#......#.#
			.....#....
			####..##..

			Tile 3323:
			#.##.#...#
			...####.##
			#...#.#..#
			#..#.#...#
			......##..
			#..#....#.
			#....#...#
			....#..#..
			#..##....#
			.######.#.

			Tile 2437:
			#.####...#
			........#.
			...#....##
			##...##...
			..#####..#
			.....#....
			...#.#..##
			....#...##
			...#......
			.##.......

			Tile 1993:
			.#.#######
			###....#..
			...#......
			.#..#.#...
			#..#.....#
			...##..##.
			###...#...
			.....#.#.#
			.......##.
			.#....#...

			Tile 2719:
			##.##..#.#
			...#......
			..#.#.....
			.#.......#
			#.....#...
			#...#.##..
			#.........
			##........
			#.#......#
			#..##.##..

			Tile 2531:
			..#.....##
			##.#......
			...#...#.#
			#.#.......
			#...#.#..#
			...#.....#
			#.#......#
			#.##.#....
			.#.#.....#
			#..#####..

			Tile 3037:
			#.#..#....
			#....#...#
			#.##...###
			#.#..#.#.#
			#....#....
			.###......
			.........#
			#.##......
			......#...
			#..##.##.#

			Tile 3469:
			#.....##..
			.##....#.#
			....#...##
			.....#.##.
			..#...##..
			#.#...##.#
			#....#....
			###.##.#.#
			#......##.
			####...##.

			Tile 2003:
			##.#...###
			....#.##.#
			#..#.#..##
			.....#..#.
			..#.....##
			#.........
			#..##..#..
			#.##..#.##
			.........#
			##.#..#...

			Tile 3391:
			#...##.#..
			.#....#...
			...##..#..
			#.#.......
			......#...
			.......#.#
			......#..#
			....###..#
			#.....#...
			.##.#.#...

			Tile 1277:
			...###...#
			##.##...#.
			.......#..
			.........#
			#......#..
			##........
			#..##.....
			#........#
			.#..#...#.
			#..#..##..

			Tile 3793:
			####.#.##.
			....#...#.
			##........
			..........
			##..#.....
			#..#......
			#....#....
			#...#....#
			..........
			########..

			Tile 3739:
			.#..##.##.
			.#......#.
			.#...##..#
			....#.###.
			.........#
			.#..#..#..
			#..#.##...
			#...#.....
			....#.....
			##.######.

			Tile 3373:
			#.##.#..##
			#.##...##.
			#......##.
			.#.....#.#
			..##.#.#.#
			##.#.....#
			#.#...#..#
			..........
			#........#
			#.#..##.#.

			Tile 3697:
			..#.....##
			#......#.#
			..#.#...##
			###..#.##.
			##...#..#.
			.....####.
			#..#.##..#
			....#.#...
			.....#...#
			....#...#.

			Tile 1489:
			..###.##..
			#...#.....
			....#...#.
			...#.#..##
			#.........
			......##..
			.#....#...
			#....##.#.
			#...##.#.#
			#..#.#...#

			Tile 3877:
			#......###
			#......#..
			...#.#....
			###...#..#
			.#........
			#.....##..
			#.......#.
			#.#..##...
			#.........
			#######..#

			Tile 1373:
			.#.....#..
			.....#....
			#.........
			....#....#
			..#.###..#
			...#..#...
			##...##...
			...#.....#
			#..###.##.
			.##.#####.

			Tile 2609:
			..#...####
			#.##....#.
			..#.......
			#......#..
			.......#..
			...#....##
			#.....#..#
			#...#....#
			....##...#
			.#.##.##..

			Tile 1709:
			.##..#.#.#
			...#......
			#.#.#.....
			....#...#.
			#.....#...
			.....#.#.#
			#...#.....
			.#...##..#
			#........#
			##.#....#.

			Tile 1447:
			.#.##.#..#
			.....#...#
			#..#....##
			#........#
			...#......
			###......#
			...#......
			#.......##
			#.........
			#.#.#####.

			Tile 2671:
			#.##.#####
			#..#..##..
			#.##.....#
			.....#....
			##...##..#
			#.###....#
			#.#....#.#
			.#.......#
			#.#....###
			....#.#..#

			Tile 2887:
			.###.#...#
			#...#..#.#
			.....#...#
			#.#...##..
			..#....###
			.#..#..#.#
			.#..#.##..
			#.#..##...
			#.##......
			#.##..#...

			Tile 2111:
			..#..#..##
			..........
			......#..#
			.......#.#
			..###.####
			#...##...#
			..#.#....#
			.......##.
			..#....#.#
			..##.####.

			Tile 3041:
			##....#..#
			#..#.##..#
			...#..###.
			#.....#.#.
			....##...#
			..#....#..
			#....#..#.
			....#.....
			...#......
			.#.##....#

			Tile 2927:
			.##...##..
			.........#
			.#.....#..
			#..#.....#
			..#.#....#
			##..#.#..#
			#.##...#..
			#.#.......
			#.#.....#.
			#.#...##..

			Tile 2557:
			###...#.##
			#......#..
			##.#.#...#
			...#.###.#
			#.#..#....
			.##.###..#
			#......#..
			#....#.#..
			###.#....#
			.#..#.#...

			Tile 1663:
			##...#.###
			#.#.....##
			##.....#..
			..#......#
			#.........
			....#....#
			...#..#..#
			#...#.....
			.#......##
			##.#......

			Tile 1949:
			##...###..
			..........
			....#...##
			..........
			.#.....##.
			#.........
			.#....##..
			..#.##.###
			..#.#....#
			.#..####.#

			Tile 2953:
			.....#...#
			##...#....
			..#.#..##.
			#.......#.
			.....#.#..
			#.#.#....#
			#..###...#
			#......#.#
			...#......
			.#..#..#.#

			Tile 2897:
			..###..###
			#.........
			#...##....
			......#..#
			......##.#
			..#..##..#
			#..#.#....
			##........
			#.#......#
			.##....#..

			Tile 1451:
			.#........
			#.#.......
			##....#.##
			#.#.......
			....##..#.
			##.....###
			....#...##
			#..#.#.##.
			#...##....
			##.#.#..#.

			Tile 2351:
			....#.##..
			##........
			.........#
			#.....#..#
			##........
			.##...#..#
			#...#...##
			....#.....
			#.#.......
			...#...###

			Tile 1399:
			#######.#.
			###....#.#
			##.#..#...
			#.........
			#.#.#.....
			..######..
			##...#.#..
			##...#.#..
			.#....#...
			#.###.....

			Tile 3079:
			..#.##.###
			....#....#
			#........#
			##.......#
			......#..#
			..#....#.#
			.......##.
			#......#..
			...#......
			.##..#.#.#

			Tile 2027:
			.....#.##.
			...#.#....
			.......#.#
			#.#....###
			#........#
			#....#..##
			.##..#..##
			#####.##.#
			...##....#
			#.........

			Tile 2239:
			...#....##
			......#..#
			..#......#
			.......#.#
			#.##.#####
			...##...#.
			..#.....##
			...##.....
			##........
			.#...#.###

			Tile 3019:
			.#.#...#..
			..#.#.....
			.....#..##
			####.#...#
			.#.##....#
			#...#.##.#
			##.#.#....
			#...#.....
			#..#.#..##
			####.#..#.

			Tile 2579:
			.#....##..
			.#.##..#.#
			#.....#..#
			..#......#
			#.........
			#...#.....
			#..#......
			#...#.....
			...#..#.#.
			..#....##.

			Tile 2699:
			..#.#.....
			#..##....#
			#..#.#...#
			###...####
			#.....#..#
			#....##.#.
			#...##....
			........#.
			.##..##...
			##....#..#

			Tile 1667:
			..#..###.#
			#.#......#
			..##.##..#
			..#....#.#
			.#...#.###
			...#..###.
			...#..#.##
			##.#.##..#
			..####.#.#
			.#..#.....

			Tile 3061:
			#.##.#.#.#
			.##.##...#
			..........
			.......#..
			.....###..
			..##..#..#
			#..###...#
			#..##.....
			#..#....#.
			......###.

			Tile 1531:
			..###.#...
			#.....#..#
			##.#..#.#.
			#.#.##...#
			..#......#
			..#.#....#
			##.##.#...
			..##.....#
			##...#..##
			..####.###

			Tile 3929:
			#..#..##..
			##....#...
			.#........
			.....##...
			...#.....#
			..#..##..#
			.........#
			.....##..#
			.#....#...
			...##...##

			Tile 2711:
			.#.####..#
			#......#.#
			#.#.......
			......###.
			#.........
			#.........
			#......#.#
			.......#.#
			#.....#..#
			.#.#.###..

			Tile 3907:
			#.#.#...#.
			....##..#.
			.....##.#.
			##......##
			....#.#..#
			#..#.....#
			#...#..#..
			..##....##
			.#........
			.#.#..####

			Tile 3299:
			##...##.##
			.#........
			#...#....#
			.#...#....
			.#.#......
			#.#...#..#
			.#..#....#
			.#..#..#.#
			.#..#....#
			###.#..#.#

			Tile 2677:
			#.#.##.##.
			#.#..#.#.#
			....#....#
			#.........
			##.......#
			##.......#
			.....#.##.
			#....#.#..
			.........#
			#...###..#

			Tile 2207:
			.##.#..###
			#.#.##....
			..........
			#.#.#...##
			........##
			#.#..#....
			...##..#.#
			.....#.#.#
			.........#
			.#..##....

			Tile 2393:
			#.#..###.#
			##.##.....
			#.........
			........##
			#.#......#
			#..#...#.#
			.........#
			##..#....#
			......#..#
			#...#.##..

			Tile 1453:
			#..#.##...
			##....#..#
			#.....#.##
			#.##....##
			..##.#..##
			...#...#.#
			....##....
			#......##.
			#......##.
			###..####.

			Tile 1871:
			######.#..
			#.......##
			......#..#
			##.......#
			##......#.
			..###..#..
			...#..##.#
			.#.##...#.
			........#.
			..####...#

			Tile 2777:
			#.#..#.#.#
			......##.#
			#.....#.#.
			#.#.....##
			#....###.#
			...##...##
			#.......#.
			.......#.#
			.#....#..#
			..#####...

			Tile 1223:
			...##.#.#.
			#...#....#
			##........
			#.....#..#
			.....###.#
			....#...##
			.....#...#
			.........#
			#.........
			#..###.###

			Tile 2633:
			..##.##...
			###.##.###
			..#.#....#
			....##....
			#..#.#....
			.#...#...#
			#.##.....#
			#.#...##.#
			##...#.#.#
			..######.#

			Tile 3307:
			##...###.#
			##.......#
			#.#...#...
			...#.....#
			#.....#.##
			#.#.......
			##.#....##
			##......##
			.##.#.#..#
			#...##..##

			Tile 1123:
			.#..#.....
			#.#...#...
			.#..##.#.#
			...###.#.#
			###...#...
			.##....#..
			#.#......#
			..#..###.#
			##.....#.#
			###.#..##.

			Tile 2797:
			.#.######.
			#.#.#....#
			#.........
			##....#..#
			#...#....#
			###..#....
			.##..#####
			..#.##....
			...#......
			..###.##..

			Tile 1613:
			########..
			##.#.....#
			....##..##
			##.#....#.
			#.##...###
			#......#..
			..........
			.......###
			....#..###
			#.#.##...#

			Tile 1511:
			###...##.#
			#....#....
			.........#
			..#.....##
			###.....#.
			#.....#.#.
			..###..#.#
			#........#
			#..#...#.#
			#.#..#.##.

			Tile 1999:
			#..#.#..#.
			.........#
			.......#..
			..#.#.#..#
			#....#..##
			.#........
			##.#.....#
			##.......#
			#....#..##
			###..#.###

			Tile 2819:
			..#.##...#
			#..##...##
			..##......
			##....#...
			#...###..#
			#.###....#
			.#.#.#.#.#
			#..#.....#
			..#.......
			..##...#.#

			Tile 3847:
			##.######.
			..#.......
			.........#
			.........#
			#..#......
			####.....#
			..#..#..##
			#.....###.
			##.....#.#
			####....#.

			Tile 1723:
			...###....
			#.........
			#.....#...
			.....#...#
			#....#.#..
			#..#.....#
			...#......
			.#...#..##
			#..#.#.#.#
			##.###.###

			Tile 1039:
			#...#.##..
			......#..#
			#.......##
			##....##..
			#...#....#
			#....#...#
			##.#.#.#..
			#.#.......
			#..#.....#
			.#...###..

			Tile 3433:
			.#.###.#..
			#...#....#
			#.....#..#
			#.....#..#
			#........#
			.......###
			..###.###.
			.....#...#
			#...#.....
			....##..#.

			Tile 1069:
			.#....#...
			###..#....
			#.........
			#....#.###
			....#.#...
			..#.....##
			#.##.#....
			.#.##.#...
			..........
			.#.#....#.

			Tile 3727:
			#.#.#####.
			...#..#..#
			##......##
			#.##...#..
			#...#.###.
			.....#.##.
			##..#.##..
			#...#.....
			....#.....
			..#######.

			Tile 1301:
			#####..#..
			.....##...
			#.##...#..
			.##......#
			#.....#...
			#....#....
			.....#.#.#
			#.....#..#
			#..#.....#
			#.##.#..#.

			Tile 3583:
			#.###.....
			#......#.#
			#..#.....#
			......##.#
			#.....##.#
			##....####
			###...##..
			##.##....#
			......##.#
			..##...##.

			Tile 3191:
			.##.#.#...
			....#.....
			#.#.....##
			##.#.#....
			...#.....#
			#........#
			..........
			....#.#..#
			........##
			.###.####.

			Tile 1987:
			##.....###
			..#.......
			##.##.#..#
			..........
			......#..#
			#...#.#..#
			...#......
			###.#..#..
			#.##....#.
			.##...##.#

			Tile 1493:
			..##..####
			#..#.#...#
			...#......
			...#....##
			#.........
			........##
			...#.....#
			#....##..#
			.#.......#
			.#.#..#..#

			Tile 1699:
			.##...#.#.
			.#.......#
			.........#
			..#...#..#
			##...#..##
			#.#..#....
			#..#..#..#
			#....#...#
			....#.....
			#...##..#.

			Tile 2459:
			.###..##..
			#........#
			..#.##....
			#....#....
			#.#..#..##
			...####..#
			.....##...
			..#......#
			...#...#.#
			#..#..####

			Tile 2801:
			.......#..
			..#.#....#
			#.....#...
			#..#.....#
			.##...#...
			#.....#..#
			......#.#.
			......#...
			#....#....
			.#.##.###.

			Tile 1759:
			##.###..##
			#.##..#...
			#........#
			........##
			.....#.#.#
			..#......#
			#.##...#.#
			##......##
			##.#......
			...###.#..

			Tile 3821:
			..#####.#.
			#....#...#
			.....#...#
			..........
			..##.###.#
			#....#....
			###.#.####
			#......#..
			#.##.....#
			.....###..

			Tile 2423:
			#.####.#..
			.#........
			.##......#
			...#......
			#..##.....
			#..##...##
			#.........
			#.#.##....
			...#....#.
			######.#.#

			Tile 1619:
			##.##...##
			..##.....#
			#....#....
			#.#......#
			#......#..
			.#.#.....#
			#..#.....#
			##...##..#
			#.........
			...#..##..

			Tile 2539:
			#.#.#.##.#
			.......###
			........#.
			..#...#...
			#.........
			#.##....##
			.####.##.#
			.........#
			##.##..#..
			...##.##.#

			Tile 2837:
			.###.#.#.#
			#.####...#
			#......##.
			#...#.#...
			..###....#
			..........
			.....#...#
			#.....##..
			#....##...
			#....##...

			Tile 1181:
			#.###....#
			.#...#....
			....#..#..
			....#.....
			#.#.##..#.
			##...###..
			#....#...#
			.........#
			.##...#..#
			..##.#..##

			Tile 2731:
			.#....##..
			......#.#.
			......#...
			.....#.#..
			#.#..##.#.
			.....###..
			#...##.#..
			#...##..#.
			#.##.#...#
			..#....###

			Tile 2477:
			####...#.#
			...#......
			........#.
			.......#.#
			..........
			#.#......#
			##...##...
			.....#....
			##.#.....#
			#..#.##..#

			Tile 2851:
			.#....####
			....###...
			#.....#..#
			#........#
			..#.....#.
			.#.......#
			#.........
			...###...#
			#.......##
			##.##.####

			Tile 3779:
			...###.##.
			#.#..#..#.
			##.#..#...
			..#....#..
			.##..#...#
			.#.......#
			..##..#...
			..#......#
			#........#
			..##.....#

			Tile 1901:
			.##..#...#
			.........#
			..........
			#..#####.#
			#....#...#
			###...#...
			...#..#..#
			.#..#..#..
			....#.....
			.##.##....

			Tile 3463:
			....######
			..#....###
			##....#..#
			#....##.##
			#..#......
			.........#
			..........
			#......#..
			..........
			##....##.#

			Tile 1409:
			.#.###..#.
			#.#..#....
			.#.....#.#
			#..#......
			#.........
			#..#......
			...###....
			.....#....
			...#......
			##.###.###
			""".components(separatedBy: "\n\n")
		}
	}
}
