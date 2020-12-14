
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
		var value: UInt64
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

	private func solve(_ filename: String, process: (_ memory: Memory, _ program: Program, _ command: Command) -> Void) -> String {
		let programs = loadPrograms(filename)
		let memory = Memory()
		programs.forEach { program in
			program.commands.forEach { command in
				process(memory, program, command)
			}
		}
		let answer = memory.valueSum
		return answer.description
	}

	private func applyValueMask(mask: String, val: String) -> UInt64 {
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

	private func solveA(_ filename: String) -> String {
		func processCommand(memory: Memory, program: Program, command: Command) {
			// Apply mask to assignment
			let maskedAssignment = applyValueMask(mask: program.mask, val: String(fromBinary: command.value))

			// Assign to the memory space
			memory.values[command.address] = maskedAssignment
		}

		return solve(filename, process: processCommand)
	}

	private func permuteAddress(_ address: String, output: inout [String]) {
		if let index = address.firstIndex(of: "X") {
			let i = index.utf16Offset(in: address)
			permuteAddress(address.assignCharacter(at: i, with: "0"), output: &output)
			permuteAddress(address.assignCharacter(at: i, with: "1"), output: &output)
		} else {
			output.append(address)
		}
	}

	private func applyAddressMask(mask: String, address: String) -> [UInt64] {
		var masked = address
		for index in 0 ..< mask.count {
			switch mask.character(at: index) {
			case "X":
				masked = masked.assignCharacter(at: index, with: "X")
			case "1":
				masked = masked.assignCharacter(at: index, with: "1")
			default:
				break
			}
		}

		// Walk through again and find all the addresses.
		var output: [String] = []
		permuteAddress(masked, output: &output)
		return output.map { $0.binaryToNumber() }
	}

	private func solveB(_ filename: String) -> String {
		func processCommand(memory: Memory, program: Program, command: Command) {
			// Apply mask to address
			let addresses = applyAddressMask(mask: program.mask, address: String(fromBinary: command.address))

			// Assign to all the memory spaces
			addresses.forEach {
				memory.values[$0] = command.value
			}
		}

		return solve(filename, process: processCommand)
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
					let command = Command(address: UInt64(v1)!, value: UInt64(v2)!)
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
