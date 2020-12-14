
import Foundation

class Solve14: PuzzleSolver {
	let exampleFile = "Example14"
	let exampleFile2 = "Example14-2"
	let inputFile = "Input14"

	func solveAExamples() -> Bool {
		solveA(exampleFile) == "165"
	}

	func solveBExamples() -> Bool {
		solveB(exampleFile2) == "208"
	}

	func solveA() -> String {
		solveA(inputFile)
	}

	func solveB() -> String {
		solveB(inputFile)
	}

	struct Command {
		var address: UInt64
		var assignment: UInt64

		var binaryAssignment: String {
			let ass = String(assignment, radix: 2)
			return ass.pad(toSize: 36)
		}
	}

	struct Program {
		var mask: String = ""
		var commands: [Command] = []
	}

	class Memory {
		var values: [UInt64: UInt64] = [:]

		var valueSum: UInt64 {
			var answer: UInt64 = 0
			values.forEach {
				answer += $0.value
			}
			return answer
		}
	}

	private func applyMask(mask: String, val: String) -> UInt64 {
		var newVal = val
		for index in 0 ..< mask.count {
			switch mask.character(at: index) {
			case "0":
				newVal = newVal.assignCharacter(at: index, with: "0")
			case "1":
				newVal = newVal.assignCharacter(at: index, with: "1")
			default:
				break
			}
		}
		return newVal.binaryToNumber()
	}

	private func solve(_ filename: String, processCommand: (_ memory: Memory, _ program: Program, _ command: Command) -> Void) -> String {
		let programs = loadPrograms(filename)
		let memory = Memory()
		programs.forEach { program in
			program.commands.forEach { command in
				processCommand(memory, program, command)
			}
		}
		let answer = memory.valueSum
		return answer.description
	}

	private func solveA(_ filename: String) -> String {
		func processCommand(memory: Memory, program: Program, command: Command) {
			// Apply mask to assignment
			let maskedAssignment = applyMask(mask: program.mask, val: command.binaryAssignment)

			// Assign to the memory space
			memory.values[command.address] = maskedAssignment
		}

		return solve(filename, processCommand: processCommand)
	}

	private func solveB(_ filename: String) -> String {
		func processCommand(memory: Memory, program: Program, command: Command) {
			// Apply mask to assignment
			let maskedAssignment = applyMask(mask: program.mask, val: command.binaryAssignment)

			// Assign to the memory space
			memory.values[command.address] = maskedAssignment
		}

		return solve(filename, processCommand: processCommand)
	}

	private func loadPrograms(_ filename: String) -> [Program] {
		let lines = FileHelper.load(filename)!.filter { !$0.isEmpty }

		let maskSigil = "mask = "

		var currentProgram: Program?
		var programs: [Program] = []

		for index in 0 ..< lines.count {
			let line = lines[index]
			if line.starts(with: maskSigil) {
				if let current = currentProgram {
					programs.append(current)
				}

				let bitmask = line.subString(start: maskSigil.count, count: 36)
				currentProgram = Program(mask: bitmask)
			} else {
				// mem[8] = 11
				let beginningEaten = String(line.dropFirst(4))
				let tokenized = beginningEaten.components(separatedBy: [" ", "]", "="])
				if tokenized.count == 5 {
					// get the two values.
					let v1 = tokenized[0]
					let v2 = tokenized[4]
					let command = Command(address: UInt64(v1)!, assignment: UInt64(v2)!)
					currentProgram?.commands.append(command)
				}
			}
		}
		if let program = currentProgram {
			programs.append(program)
		}

		return programs
	}
}
