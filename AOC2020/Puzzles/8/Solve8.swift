
import Foundation

class Solve8: PuzzleSolver {
	let exampleFile = "Example8"
	let inputFile = "Input8"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "5"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile) == "8"
	}

	func solveA() -> String {
		solve(inputFile)
	}

	func solveB() -> String {
		solveB(inputFile)
	}

	enum Operation {
		case acc(Int)
		case jmp(Int)
		case nop(Int)
	}

	enum Solve8Error: Error {
		case CycleDetected(atInstruction: Int, accumulator: Int)
	}

	class Program {
		init(operations: [Operation]) {
			self.operations = operations
		}

		private var operations: [Operation]
		private var accumulator: Int = 0
		private var instruction: Int = 0

		func run() throws -> Int {
			var visited = Set<Int>()
			while instruction < operations.count {
				if visited.contains(instruction) {
					throw Solve8Error.CycleDetected(atInstruction: instruction, accumulator: accumulator)
				}
				let op = operations[instruction]
				visited.insert(instruction)
				switch op {
				case let .acc(accVal):
					accumulator = accumulator + accVal
					instruction = instruction + 1

				case let .jmp(jmpVal):
					instruction = instruction + jmpVal

				case .nop:
					instruction = instruction + 1
				}
			}
			return accumulator
		}
	}

	private func solve(_ filename: String) -> String {
		let operations = loadOperations(filename)
		let program = Program(operations: operations)
		do {
			_ = try program.run()
		} catch Solve8Error.CycleDetected(atInstruction: _, accumulator: let accumulator) {
			return accumulator.description
		} catch {
			return "Oh boy"
		}
		return "Failure is an option"
	}

	private func solveB(_ filename: String) -> String {
		let operations = loadOperations(filename)

		let mutations = findMutations(operations: operations)

		let winner = mutations.first { mutated in
			let program = Program(operations: mutated)
			do {
				_ = try program.run()
				return true
			} catch {
				return false
			}
		}

		if let successStory = winner,
		   let output = try? Program(operations: successStory).run()
		{
			return output.description
		}

		return "Failure"
	}

	private func findMutations(operations: [Operation]) -> [[Operation]] {
		func mutate(operations: [Operation], index indexToChange: Int, to: Operation) -> [Operation] {
			var mutated = [Operation]()
			for index in 0 ..< operations.count {
				if index == indexToChange {
					mutated.append(to)
				} else {
					mutated.append(operations[index])
				}
			}
			return mutated
		}

		var mutations: [[Operation]] = []
		for index in 0 ..< operations.count {
			switch operations[index] {
			case let .jmp(v):
				mutations.append(mutate(operations: operations, index: index, to: .nop(v)))

			case let .nop(v):
				mutations.append(mutate(operations: operations, index: index, to: .jmp(v)))

			default: break
			}
		}
		return mutations
	}

	private func loadOperations(_ filename: String) -> [Operation] {
		let lines = FileHelper.load(filename)!
		var operations: [Operation] = []
		lines.forEach { line in
			let tokens = line.components(separatedBy: " ").filter { !$0.isEmpty }
			if tokens.count != 2 {
				return
			}
			let op = tokens[0]
			let val = Int(tokens[1])!
			switch op {
			case "acc":
				operations.append(.acc(val))
			case "jmp":
				operations.append(.jmp(val))
			case "nop":
				operations.append(.nop(val))
			default:
				return
			}
		}
		return operations
	}
}
