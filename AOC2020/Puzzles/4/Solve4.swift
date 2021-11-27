
import AOCLib
import Foundation

protocol Solve4Delegate {
	func processed(passport: Solve4.Passport, passed: Bool)
	func complete()
}

class Solve4: PuzzleSolver {
	var delegate: Solve4Delegate?

	func solveAExamples() -> Bool {
		solve("Example4", strict: false) == "2"
	}

	func solveBExamples() -> Bool {
		let validPass = solve("Example4b-valid", strict: true)
		let invalidPass = solve("Example4b-invalid", strict: true)

		return invalidPass == "0" && validPass == "4"
	}

	var answerA = "196"
	var answerB = "114"

	func solveA() -> String {
		solve("Input4", strict: false)
	}

	func solveB() -> String {
		solve("Input4", strict: true)
	}

	struct Passport {
		var datas: [String: String] = [:]

		var isValid: Bool {
			let required = [
				"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid",
			]

			_ = [
				"cid",
			]

			return required.allSatisfy { datas[$0] != nil }
		}

		var isStrictlyValid: Bool {
			if !isValid {
				return false
			}

			/*
			 byr (Birth Year) - four digits; at least 1920 and at most 2002.
			 iyr (Issue Year) - four digits; at least 2010 and at most 2020.
			 eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
			 hgt (Height) - a number followed by either cm or in:
			 If cm, the number must be at least 150 and at most 193.
			 If in, the number must be at least 59 and at most 76.
			 hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
			 ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
			 pid (Passport ID) - a nine-digit number, including leading zeroes.
			 */

			return
				checkBounds(key: "byr", min: 1920, max: 2002) &&
				checkBounds(key: "iyr", min: 2010, max: 2020) &&
				checkBounds(key: "eyr", min: 2020, max: 2030) &&
				checkHgt &&
				checkHcl &&
				checkEcl &&
				checkPid
		}

		private var checkEcl: Bool {
			guard let hcl = datas["ecl"] else {
				return false
			}
			let valid = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
			return valid.first { $0 == hcl } != nil
		}

		private var checkPid: Bool {
			guard let pid = datas["pid"] else {
				return false
			}
			return pid.count == 9 && pid.allSatisfy { "0" ... "9" ~= $0 }
		}

		private var checkHcl: Bool {
			guard let hcl = datas["hcl"],
			      hcl.count == 7,
			      hcl.character(at: 0) == "#"
			else {
				return false
			}

			let start = hcl.index(hcl.startIndex, offsetBy: 1)
			let end = hcl.index(hcl.endIndex, offsetBy: 0)
			let hclValue = hcl[start ..< end]
			return hclValue.count == 6 && hclValue.allSatisfy { "0" ... "9" ~= $0 || "a" ... "f" ~= $0 }
		}

		private var checkHgt: Bool {
			guard let hgt = datas["hgt"],
			      let numericPrefix = Int(hgt.prefix(while: { "0" ... "9" ~= $0 }))
			else {
				return false
			}

			switch hgt.suffix(2) {
			case "cm":
				return checkBounds(data: numericPrefix, min: 150, max: 193)
			case "in":
				return checkBounds(data: numericPrefix, min: 59, max: 76)
			default:
				return false
			}
		}

		private func checkBounds(key: String, min: Int, max: Int) -> Bool {
			guard let val = datas[key],
			      let data = Int(val)
			else {
				return false
			}
			return checkBounds(data: data, min: min, max: max)
		}

		private func checkBounds(data: Int, min: Int, max: Int) -> Bool {
			data >= min && data <= max
		}
	}

	private func solve(_ filename: String, strict: Bool) -> String {
		let lines = FileHelper.load(filename)!

		var passports: [Passport] = []

		var current = Passport()
		for index in 0 ..< lines.count {
			let line = lines[index]

			if line.isEmpty {
				passports.append(current)
				current = Passport()
			} else {
				let dataLine = line.components(separatedBy: " ")
				dataLine.forEach {
					let kvp = $0.components(separatedBy: ":")
					if kvp.count == 2 {
						current.datas[kvp[0]] = kvp[1]
					}
				}
			}
		}

		let valid = passports.filter {
			let isValid = strict ? $0.isStrictlyValid : $0.isValid
			delegate?.processed(passport: $0, passed: isValid)
			return isValid
		}
		delegate?.complete()
		return valid.count.description
	}
}
