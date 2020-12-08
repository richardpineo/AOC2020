
import Foundation

class Solve8: PuzzleSolver {
	let exampleFile = "Example8"
	let inputFile = "Input8"

	func solveAExamples() -> Bool {
		solve(exampleFile) == "5"
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

	enum Operation {
		case acc(Int)
		case jmp(Int)
		case nop
	}
	
	enum Solve8Error: Error {
		case CycleDetected(
		 atInstruction: Int,
		 accumulator: Int)
	}

	class Program {
		init(operations: [Operation]) {
			self.operations = operations
		}
		
		private var operations: [Operation]
		private var accumulator: Int = 0
		private var instruction: Int = 0
		
		func run() throws {
			var visited = Set<Int>()
			while(true) {
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
		}
	}

	private func solve(_ filename: String) -> String {
		let operations = loadOperations(filename)
		let program = Program(operations: operations)
		do {
			try program.run()
		}
		catch Solve8Error.CycleDetected(atInstruction: let _, accumulator: let accumulator) {
			return accumulator.description
		}
		catch {
			return "Oh boy"
		}
		return "Failure is an option"
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
				operations.append(.nop)
			default:
				return
			}
		}
		return operations
	}
}
