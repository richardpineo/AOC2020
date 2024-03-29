// I really didn't like this puzzle and didn't want to do it so I stole this from:
// https://github.com/gernb/AdventOfCode2020/blob/main/Day%2019/main.swift

import Foundation

private enum InputData: String, CaseIterable {
	case example, example2, challenge

	var data: [[String]] {
		switch self {
		case .example: return """
			0: 4 1 5
			1: 2 3 | 3 2
			2: 4 4 | 5 5
			3: 4 5 | 5 4
			4: "a"
			5: "b"

			ababbb
			bababa
			abbbab
			aaabbb
			aaaabbb
			""".components(separatedBy: "\n\n").map { $0.components(separatedBy: .newlines) }

		case .example2: return """
			42: 9 14 | 10 1
			9: 14 27 | 1 26
			10: 23 14 | 28 1
			1: "a"
			11: 42 31
			5: 1 14 | 15 1
			19: 14 1 | 14 14
			12: 24 14 | 19 1
			16: 15 1 | 14 14
			31: 14 17 | 1 13
			6: 14 14 | 1 14
			2: 1 24 | 14 4
			0: 8 11
			13: 14 3 | 1 12
			15: 1 | 14
			17: 14 2 | 1 7
			23: 25 1 | 22 14
			28: 16 1
			4: 1 1
			20: 14 14 | 1 15
			3: 5 14 | 16 1
			27: 1 6 | 14 18
			14: "b"
			21: 14 1 | 1 14
			25: 1 1 | 1 14
			22: 14 14
			8: 42
			26: 14 22 | 1 20
			18: 15 15
			7: 14 5 | 1 21
			24: 14 1

			abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
			bbabbbbaabaabba
			babbbbaabbbbbabbbbbbaabaaabaaa
			aaabbbbbbaaaabaababaabababbabaaabbababababaaa
			bbbbbbbaaaabbbbaaabbabaaa
			bbbababbbbaaaaaaaabbababaaababaabab
			ababaaaaaabaaab
			ababaaaaabbbaba
			baabbaaaabbaaaababbaababb
			abbbbabbbbaaaababbbbbbaaaababb
			aaaaabbaabaaaaababaa
			aaaabbaaaabbaaa
			aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
			babaaabbbaaabaababbaabababaaab
			aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
			""".components(separatedBy: "\n\n").map { $0.components(separatedBy: .newlines) }

		case .challenge: return """
			136: 83 66 | 102 116
			120: 83 66 | 58 116
			26: 56 116 | 105 66
			42: 37 66 | 100 116
			103: 116 33 | 66 47
			35: 116 21 | 66 105
			82: 113 116 | 93 66
			96: 66 60 | 116 61
			25: 116 68 | 66 34
			4: 116 66
			90: 66 14 | 116 91
			63: 119 66 | 27 116
			71: 5 116 | 103 66
			61: 54 66 | 50 116
			2: 119 116 | 4 66
			12: 92 116 | 102 66
			86: 116 92 | 66 83
			100: 66 18 | 116 10
			91: 66 46 | 116 45
			117: 66 92 | 116 131
			22: 66 15 | 116 96
			130: 58 116 | 21 66
			58: 116 66 | 66 66
			97: 116 119 | 66 27
			45: 136 66 | 30 116
			76: 80 66 | 109 116
			10: 66 71 | 116 82
			124: 66 116 | 116 66
			116: "a"
			47: 4 116
			110: 116 23 | 66 86
			43: 66 17 | 116 21
			126: 111 116 | 108 66
			134: 66 58 | 116 17
			132: 116 105 | 66 119
			49: 116 116 | 116 66
			107: 131 62
			108: 116 41 | 66 41
			34: 66 128 | 116 107
			53: 116 121 | 66 72
			33: 66 41 | 116 102
			31: 22 66 | 44 116
			9: 130 116 | 19 66
			113: 66 73 | 116 51
			50: 116 132 | 66 28
			122: 105 66 | 119 116
			66: "b"
			87: 66 3 | 116 2
			106: 24 116 | 26 66
			65: 66 49 | 116 58
			32: 116 125 | 66 16
			84: 39 66 | 70 116
			3: 41 66 | 56 116
			8: 42
			62: 116 | 66
			55: 4 66 | 83 116
			1: 56 66 | 17 116
			60: 38 116 | 79 66
			133: 4 66 | 4 116
			123: 117 116 | 134 66
			121: 66 112 | 116 127
			38: 66 30 | 116 114
			36: 66 131 | 116 21
			135: 66 67 | 116 32
			70: 98 116 | 97 66
			41: 66 66
			119: 66 66 | 116 62
			83: 116 62 | 66 116
			11: 42 31
			101: 17 66 | 92 116
			28: 116 17 | 66 49
			98: 66 83 | 116 41
			93: 116 99 | 66 133
			72: 116 74 | 66 110
			69: 116 92 | 66 17
			20: 116 87 | 66 13
			57: 56 116 | 119 66
			5: 116 3 | 66 111
			54: 66 43 | 116 81
			37: 116 53 | 66 90
			13: 122 66 | 85 116
			16: 66 2 | 116 120
			81: 4 116 | 17 66
			73: 119 66 | 92 116
			88: 57 116 | 55 66
			92: 66 116 | 62 66
			18: 116 20 | 66 25
			77: 4 66 | 58 116
			56: 66 116 | 116 116
			95: 49 116 | 27 66
			7: 116 126 | 66 88
			59: 66 4 | 116 58
			127: 116 101 | 66 65
			48: 29 66 | 129 116
			52: 119 62
			15: 84 116 | 7 66
			24: 17 116 | 83 66
			102: 116 116 | 66 62
			40: 118 66 | 106 116
			85: 92 116 | 131 66
			109: 41 116
			114: 116 124 | 66 105
			30: 66 105 | 116 105
			67: 48 66 | 75 116
			131: 66 66 | 66 116
			105: 116 116
			111: 66 119 | 116 4
			51: 4 116 | 49 66
			78: 66 131 | 116 58
			104: 66 6 | 116 63
			129: 102 66 | 58 116
			74: 66 12 | 116 1
			89: 123 116 | 104 66
			27: 62 62
			6: 131 66 | 27 116
			99: 66 56 | 116 105
			68: 66 132 | 116 52
			0: 8 11
			17: 66 66 | 116 116
			39: 66 78 | 116 115
			80: 116 56 | 66 49
			21: 66 116
			29: 102 66 | 4 116
			23: 116 21 | 66 56
			115: 49 62
			46: 95 116 | 65 66
			125: 77 66 | 55 116
			112: 66 98 | 116 69
			128: 66 119 | 116 58
			64: 66 41 | 116 27
			79: 116 59 | 66 64
			118: 116 129 | 66 35
			75: 30 66 | 36 116
			14: 9 66 | 76 116
			19: 116 4 | 66 92
			94: 66 40 | 116 89
			44: 135 116 | 94 66

			babbbabababbababbabbabba
			aaaaaababaaaabbabbabbbbb
			babbaabbbabaabbbbabbaaaababbaabbbaabbbab
			babaabbbbbbabbaaaabaaaaa
			babaabbabbbbabbbababbbbbbababaaaaabaaabbbaaaaababbaababa
			abbabbabbaaabbbbbaabbaab
			abbbbabbaaabbabbaabaabaabaabbbbb
			bbbbaaaabaabaababbabaabaaabababb
			abaaaaaaaaaabbaabbabaaba
			bbbababbabbabbabbabaaaaa
			abbbbbabababbbaababababb
			baabaaaaababaaaabbbbbababbbbabbbabbaabba
			baaaabaabbabbaaababbabba
			babaabbbabbaaaaaaaababbabbababaaabaabbaaabababaabbbbbaabbbbbbaba
			ababbbbbababbbbbbbbaaaaa
			aabbbabbaaaabbababbbbaba
			bbaaaaaaaabaaabbabbaabba
			baabaabbbababbaaababababaaaabaababaaabaaaababaabbaababbbbbabbaabbaaabbab
			bbbbabbaababbbbabbabbbaa
			aaabbabababbaabbbbabbbaa
			bbbbaabbbbaabbbabbbbbabb
			abaaaaaabaabaaaabbabbaab
			ababababbabaabbbaaaaabba
			bababaaabbabbbbabaaabaaa
			aaaabaabbaabbaaaaabbabab
			baabbabbabaabbbaabbbaabaaabbaabaabbbaaababbbabba
			bbbbbbbbaabbabbbaabbbbba
			aaabbbbbaabbaababbaaabbb
			aabaabaaaaaaaabaaabbabab
			bbbbabbaaaaaabababbbaaba
			bbbbabbababaaabaabbaaaba
			aababbaaaaaabbaaabbaabaabbbbaaaa
			baaaabaabbbbbabaaaababaa
			abababababbaababaababbbbababaaaabbabaaabbbbbbabb
			aababbbabbbaababbbabaaba
			ababbbabababaaaaaaabbbbb
			ababaaaaaaaaabaaababbaabbabaababbaabbbaaaabbaababbaababa
			aaabbaabaaaabaaaaaababbbabbabbbbbbaabbab
			babaabbbaaabaabaaaabbaabbaaaaaab
			aaabbabbbbbabbbaaababbbbbbbbabbaaababbabbaabbbaa
			ababbbbaaaababbbbbbbbbbbaababbababababaa
			abbabbabaabbbaaabbaaabbb
			babaaabaaaaaaabbbabbababbbbbababbbababaa
			baabbbbaababbbabbbbbabaa
			abbabaababaaaaabaaaababb
			bbbabbbbbbaaabaaabbabbba
			ababaabbbbaaababaabbbaabaaabbbba
			ababbbaababaaaabaaaaabbaabbababbaabbabba
			ababbbbaaabbbaaabbbbbbaa
			bbaaabbabbababababaabbbb
			babababababbbbaabaaababb
			ababbabbaaaaabaaabbabbaa
			babaabbbbbabbaaabbaaaaab
			ababbbabbbaaababaabbabaa
			baabbabbababbbaabbbaabbb
			ababbbbbbaaabbaabaabbbab
			abaabbbababbaabbabbaaaba
			bbbaababbabaaabaabaabbaa
			ababababaaabbabbbbbaaaab
			baaabbaababababaabbbbbabaaabbbbb
			abaaaabaaabbabbbbaabbaba
			baabbabbaaabaabaaababbbbaabababbaaaaaaaa
			bababbabbabbaabbababababbabbbbabaabbbbbbabbabbbabbbbbaab
			aababbbababaaababaaaabaaabbaaabb
			bababaabbaaaabaabaaabbba
			bbbbaaabbbaaaababbbbbbbbbabbabbbbbabbabaaababbaaaabbabaa
			abaababbaabaabaaabaaaaaaabaababaaabaabbbaaababbaaaabbbabaaaaabba
			babbababaaabaabbbbabbaabbbbbbaabbbaaabbaaabbabbaaaabaaabbbaabbaabaaaababbbbbbbaaaababbab
			aababaaababaaabaabbaabbb
			abaabbbaaabbaaaabaabbaab
			aabbbbaaaaaabbababbbbbbb
			abbbababababaaaaabaaabba
			abbbabaaaabbbaaabbbbbaab
			bbbabbbbbbaabbbbbbaababa
			abbbbaabaabaabababababba
			aabbbabbaabababaabaabbbb
			abbbabaaaababbbbaabbbaaabaaabaaa
			bababababaaaaaaabbbbaaabbbaaaabaababbbaabaaabaab
			bbbababaababbbaabaabbaba
			aabbbaabaaabbabbbbbaababbaabaabaaabbabab
			bbabababbbabbababaaaabab
			bbbbbbbbbaaaaaababbbbaba
			bbbbaaabababbbabaaabbbba
			baaabbbbbaabaaaabbaababb
			ababababbaaaaaababbbaaab
			babbabbbbbaabbbbbbbababbbbbbbbbbaabbbaaaabaabaababbbbabaaabbababbbbabaab
			abbbaaaaaababbbbabbaaaab
			bbabababbababbbbaaababba
			babaaabababbbbaaabbaaabb
			bbababbababaaabbabbaaaabbaababbababbbaab
			aaaaaabbaaaabbbbabbabaababbbbaba
			bbaaababbbabaaaaaaabaaaa
			aabbbabbaabbabbbabbbbaaa
			bbaabbbaabaabbbaaababaaaabaaababbabbaaab
			bbabbaaababbbababbaabbbabbaababa
			bababbbbbbbbbabaabbbaaaa
			baaabbbbabbabbabaabaabaabaaaaababbaabbab
			bbaabbaaaaabbabbaabbaaab
			aaaabbbbaabbbabbbbbbabbaabababbabbbbbbaa
			ababbaabbbbababbaabaabaabaabaaba
			abbbababbabbbbababbaaaaa
			aababaaaabaaaaaaaaaaaaab
			aaaabbbbaabaaabbabbabaaa
			aabaabbababaabbaaaabababbbbababbaabbabbbbbbbabaabaababbababbabbbbbbababb
			bbbabababbaaaaaaaabaabaabbbbbaab
			bbabbabbbbbaaabaabababbbbaaabbabbbbaabab
			abbbbabbabaaaaaabaababaa
			abaaaabbbabbababaabaabba
			aabaaabbbababbbbbbabaaab
			bbbbbbbaabbbbbababbaabba
			aaabbaabbbaabbbbabbbbbba
			aaabaabaaaabbabbababaaba
			babbbbabbabbbbabaaaaababbabbbbbaaaabbbba
			aaaaabbbabbaabbaabaaabaababbaaaabbabbabbbababbbaaaaaabaabaabbbabaabbaaaababbbbbbbbaaaabbbaaaaaaa
			ababaabbbbaabbaaaabbbbaaaabababbbabaaababaaabaaabbbbbbaaaabbbbbb
			aaabbababbbabbabaaaaabbb
			babbabaabaabbaaabbaababa
			bbbabbbbbabbaaaabbbbabbabaabbbababbabaaabbaabaaabbabaaabbbbaabbb
			aaaabbaababababaabbbbaabaabbaabbbaabbbbb
			abbbabaaabbbbabbbaabbabbbbbabbbabaabbaaaaabbaaba
			ababbbabbaaaaaaabbaababb
			babbbbabbbaabbaaaaaaabaabbaabaaaaaaaaaab
			aaaabaaababbbbabbbabaaab
			aabbbbaaababbbbbbaabbbbb
			abbabbabaababbaaaabbbaaabbbbbbbbbabaaaabbbabbbabbaaaababbbabbbab
			ababbbaababaaaabbaababab
			bababaabaabaabaababbaaab
			bbbbbabaabbabaabaaabbaaa
			ababbaabbbaaabaababbaaab
			abaaaaaaababaabbbabbabaaaabbabab
			bbbababaaabbbbaaabaabbaa
			bbbbbbbbaabbbaabbbbaabbb
			ababbabbbabbaaaabbbaabba
			babaabbbbbbbaaababbabbaa
			aabaababbaabbbbabbaaababaaababbbababbababbbaaaaabaababaa
			bbabbaaabbbbaabaaabbbabbabbbaabbbbaabbabaabaabba
			aaaabbbbabaababaabbbbbabbbbbbaabbbaabaaa
			bbbabbababaaaaaabbbbabaa
			bbaaaabaabbbaaaabbabbbbb
			aabbabbabbbbaabbbbbabaabbabaaaaaaabaaaaabaaabbab
			abbbbaabbbaaabaaaaabbbba
			ababbbaabbbaaabbbaababaa
			abaaaabababaaaabbbbaaaaa
			aabbaaaabbbabbaabbbbaabbaabbabbbabbabaaabbbaabaaaaaaaaaa
			abbabaababbbbbaaaaababaa
			aaaaaabaabbbabbbabbbabbbbbaaababbbaaabaabaabaabaaaabbbabbababbba
			abbbabaaaaabaababbabbbaa
			aaababbbbaabbbbababbbabb
			bbaaababbabaaababbbaabababaabaabaaaaaaaa
			baabbaaaabaabababbbbaabaababbbbabaaaabbbbbbabbababaaabbb
			abbaababbbbabbbbbbbbaaaa
			abbabaabbbbbbabaaababaabaaaababa
			babaaaabbbbbaabbabaabbaa
			aaaabbaaaaaabbabaababbaababbbabaaabaaaaa
			babaaabaaabbaaaabaabbaba
			aabbabbbbaaaabbbaaabbabbababaaab
			aabaaabbabbaababbabaabaa
			bbabbaaaaabbaaaabaabbabbbabbabaabbabbaababbaaaaabbababbb
			aababbbbbababbababbbababaabaaaabbaabbbaa
			aabbaaaaaababaabbbbbabababbabaaabbbbabaaabbbbbbbbaabbaba
			babaaaabbbaaababaabaaabbbaaaaabbabaabaaa
			aaabbababbaabbaabbbbabbaababababbbaabbbbabababbaabaabbaabbaabaaabbbaaaba
			abbabaabbbbbaaabbbababbb
			baaaabbaaababbbbbaababbbabaaaababaaaabbabbaababb
			abaabbbabbabbaaabbaababb
			bbabbbbabababaabababbbaabaabbaaabaabbaaabbbaaaaabbbaaaabbbaababbaabbabaa
			aabaabaaaabbbbaababbbbaabbbbbbbbaabababb
			babbbbabbababbbbabbbbbba
			bbbbbababbbabbababbbbaba
			ababaabbababbbabbbbaaabb
			bbbbbaaababbaaaabbaaaaaabbabaabbaaababba
			bbbbaababbabbaaabaaaabab
			bbbbbababaaaaabaabaaabbbbabaaabbbabbabaaaaaabaabbaaabbababaababaaaaabaabbaabbbabbaabaaabbabbbabb
			baabaaaaababbabbbaaaabab
			bbaabbbbaaabaabaabababbb
			aaaabaaabbaaaabaabbaabbb
			aabaabaababbbbaabbbbbbbbbaaabbbababbaaab
			babababaaaabaabbbbbabaab
			babbbaaaaababaabaabbabaa
			aabbabbbbaaabbaabbbaabaa
			baabaaabbbaaababbababaabaaaabaaabbaaaaab
			bbabbbbaabaababaaaababaa
			bbbbbbbbaabaabaaaaabaabbabaabbbabbabbabb
			aabaabbbbaaaabaabaabaaababbbbbbababbabba
			bbbbbaaaabaaaabbabbaabaabbaabaaaabbabaaa
			babbabaaaaaabaabaabaabba
			abbabbabaaaaabaabbabbbaa
			bababaaaaababbbaabbbabba
			ababbbaaaaabbabaabbbaaba
			bbbababbaababaaaabaabaaa
			ababaaaabbbbaaabbaaabaab
			bbaaaababbabbababbabaaba
			baabbbabaaaaaaaababbbabbbbabaaaaabaabbaabaaaabbbababbbbabaabaaaabaaabaaaaaaabbab
			babbababaabaaaabaaaaaaabbaabbbabaababbaaaaabbbaabababaababbababaabbababa
			abaabababaaabbaaabaabbabbabbaaab
			babaabbbbababababbababaa
			babbbababbabaabbabbabaaa
			aaaabaabbbbababaabababaa
			bbaabbbbbaaaaabbabaabbaa
			bababaabaabbabbbababaaaababbabbbbabbbbbabbabbbab
			baaaabbbaabbbbbaababaabaabababbbbbabaabbbbaaaaaababaabaabbabbbbb
			aaaabbbabbaabbbababbabaababbabbbbababbbbbbaabaabaabababb
			bbbababbbaaaaaabaabaabbbaabbbbba
			babbbabaabbabaabbabaaaabaabababb
			aaaaaabbbaabaabbaaaabbba
			baabbbbaaaababbbaaaabaaabaaaaaba
			bbaaaabaaabaabbbabaaabab
			baababbbaaaabaaabbabbbaa
			aaaaaababbabababaababbbbabaaaabaabaaabbbbabaaaaa
			aabaabbbabaaaabbababaabbbababababbabbbab
			bbaaaaaaabaababaabababbb
			aaabaabbabbabababbbbbbbbbabbaabaaababbab
			abaababababbbabaaaaaababbabbbbbabbabbbab
			bababbbbababbbbbbbababaa
			abbbaaaababbababaababaabababbaaa
			bbbabbbbaabaabbbaabbabbb
			babbbababbabaabbbabbaaab
			baabbabbbabaabbbbaababab
			bbbbbabaabbbbabbbbaabaaa
			aaaabaaabbbaababaaabaabbbbbbbabb
			babababaaabbbabbbbaaabbb
			bbaaababbaaabbaabaabbaba
			abaaaabaababbbbabbabbaab
			aaaaababababaaaaababbbabababaaabbabbaaab
			aaaabaabbbbabbababbabaaa
			bbaaaabaaaabbabaaabbbaba
			babbbbaaaabaabaaabababbb
			aabbabbbbbaaabaaaaababbbaababaabbbbbbbbbabbaaaba
			bbbabbbaaabaaabbbbabbabb
			aaaaabaababaaaababaaabaa
			baabaabbabbbaaaaabbaaabb
			baabbaaaaaaabbabbaaaabab
			bbaaaababbabbbbbaaabaabababbabaaaaabbaabbabaaaaaaaaabbbbabbabbaaaababbbb
			ababaaaaabbbabbbaababbbaaaababbb
			aaabbabbaaababbbabaaabba
			aababababbabaaaaaaaababa
			abaabbbaabaaaaabbbbabbababaabbbaaaaababb
			babababababbbaaaababbaba
			baababaaabbbabbbbbaaabbbbbbbbbbbabbababbaabbbbba
			abaababbabaababaabbbaaba
			bababaabbbbbaabbabaaabaa
			abbbbbbaaababaabbbaabbbbabbaaaaaaaabababaababbaa
			baabaaaaaaabbabbbbabaaabbbabaabbbbabbaabaaababba
			bbabaaaababbbabaababbbbbabaababaabbaaabbbaaabaaa
			baaabbbbababaaaaabbabaaa
			aaabbabaabbbabaababbabba
			aabbbbaabaabaabbaaababaa
			aabbbbaabbbbbbbabbaaababbbbabaab
			abbbaabbbbbbaababbbbabab
			abbbabbbaababaaaaabaaabbaaaababb
			babbabaabababbbbabbbaaba
			aabaabbbbababaaabbbabbabbaaabaaa
			aaaabbabaabababaaaaabbabbaaaaabbaaaabaabbbabbabbbabbbaab
			bababaaabaaabbaaabbababb
			abaabbbabaaaaababaabaabbabaabaaabaabbabb
			ababababbabbaabbaabaaabbaababababaabbbbbaaabbbaa
			aaaabaabababbbaaabaaaabaaaaabbabaaabbbbb
			aaabbabbababaabbaabbbbba
			aaaabaabaabaabaaaababaaababbbbaabbbaabaa
			bababaaabababaaaabaabbbaababaaab
			babbaaaaaaaaabaaabaaabba
			bbabbabbaabbbbbbaabbabba
			aabaababbbabbaaaaababaabbaabbaaaaaaaabaaababaaabaabaaaababbbaabababaabaa
			aaaaaaabbbbaaaaaaaabbbbaabbbabba
			babbaaaaabbbaaaaaabbbbbb
			bbbbbababaaabbbbaabbbbba
			bbbbbaaaaababbbaabaabbbabbaaabababbbbbaa
			aaabbabbaaabbaabaabaaabbbbbbaaabaaaabaaaaabbbabbabbaaabbabbbaaabbaabaababbaaabbb
			ababbaabaababbbbaababbbbabbabbbbbbbabaab
			abbbabbbababbabbabbbbbba
			ababbbaababbababaaaaabbb
			aabbbaabbabaaaabbbababba
			aabbbbaaabbabbabbabbbbba
			baaaaabbbaaaabbabaabbaaaaaabbaaa
			aabaaabbbbabbaaabbababaa
			aaabbababaaaaabbabaaabbb
			bbaabbbaabbabaabbaaaabaaaabbbaabaaaaaabaaaaaaaaaaaabbaaa
			aaabaabbbabbbbaabaabaaabaaaaaabaaaaaaabbaabbbbba
			baaaabbaaaaaabbbabbbbbabaababababbbabababaababbabbabbabababbbbaa
			babaaaabbbbbbababaababba
			babaabbbaabbbbaabbbbabab
			bbaabbbbbabbabaaaabaaaaa
			abbbabbbbabaabbbaaaaaaab
			bbaabbbabbaaaababbbabaab
			ababbbbabbbbaabbbaaababa
			aabbbaabbabbbababbababaa
			aaaabaaaabbbabbbbaababba
			abbbbbaabbaabbaaaababbab
			babbbaabaaabbbaabbbbabaabbabaabababababaaababbabaabbbaaa
			abaabababbabbabaabaabbbabbbbbabbabbbaaab
			ababbbabbababbbbaaababbbbbbbbbaa
			baaabbaaaaaaabaaabaabaaa
			aaaaabaaababbbbabaaabaab
			abaababababbabaaabbbbabbbababbaa
			bbabbbbaaaabbbababbbaaabbaaababaabbaaabbbbbbaaaa
			bababbabaaabbabaabbaaabb
			aaaaabababbbabbbaaabbabbaabbabbbbaaaabab
			abaaaabbabbbbbabbbbabbbaababaaaa
			bababaabaaaabbbbbaabaaba
			bbabaabbaaabbbbbbbaabbab
			abbbbaaabaaabbabbbabbbbabbbaaaaabbbababaaaabbbababababab
			babaababbbbbaabbaaabbaabaabbabba
			ababbaabbbbabbaababaaaaa
			abbabbabbbbbaabaaabaaaaa
			abbabbabbbbbbabababbbbba
			bbbaabbbbbbaaabbbaabaabbbabbaababaabbbbabaabbabbbabbbbab
			bbbbabbaabbbbabbbbbbabaa
			abbbbbaabaabaaaaababbaba
			aabababababbbaaaabbbaabbbabaaabbaabbaabb
			baaabbaaababaaaaabbbbbbb
			aaabaababababbabbbabbabb
			aabbbbaabbbabababbbbabab
			bbabbbbaabbbbbababbaaabb
			aaaabaabaaaabbaabbbabbaaaaabbababbbaaaabbbbaaaaa
			bababaaaaaaabaabaabbabbbababbaaa
			abbabbabbbbbabbbbaabaaabaabbabab
			abaabbbabbbababaaaaaaababbaababa
			bbbbabaabbbabbababbbbababbaababbbbababbbbabababaaaababbabababbaa
			bbbabbbaaaababbbbbbbbaaabbbbbabb
			baaaabbaaaaabbaababaaaaa
			babbababbabbbbabbaababba
			aabbbabbbaaaabbabaaabaab
			aaabaabaabbbbabbaaaabaaaabaabbbb
			aaabbabbbbabaabbbaaaaaba
			aaaaaababaaabbbbbbbaabaa
			aabaabaabaaabbaabbaaabbaaabbaabb
			abbababaaaaabbbbbbabaaaabaaaabbbaaabaabb
			abbaababababbbabaaabbaabbbaaaababbabbababaabbbbbbbaaaabb
			abbaaabbabaaaabaaabaaabbbbabababbbbbbbabaabbbaaaaaabaabb
			baaaabbaaaabbaabbabaababbabbbabbabbaaaba
			aaaabbaaabaaaaaabaabbbbb
			bbbbaabaaabaaabbabbaababbaabbbbbbaabbbab
			babaaabaaaaaabaabaaabbab
			baaabbaaabbbabbbaaaababa
			babbbaabbaaababbbbabbaabbbabaaababaabbabbaaaaaaa
			aababbaaaabaaabbbaabbaab
			abbbaabbaaabaabbaabababb
			aababbaabbabaabbababbbbaaabaabaaaaaabbbbababbbabbbaababa
			aabaababbbbbaababaababba
			bababababbbbbababbababba
			aabbbbabbaabbbbaabbaabbb
			baaaaabbbaaaabaaabaabbbb
			abbbababaaaabaabbbaabbab
			babaabbbbaaaabbbbaaababb
			aabbbbababbbbabbbabbbaab
			baabaabbbbbabaaaababbabbbbaaababaabaabba
			babbaabbaababbbaaabbabba
			bbaabbbbaabbbaabbabababb
			ababaabbbbabbbbaabababbb
			aababaababbbbbabbababbbbaabbabbbaaababbbabbabaaa
			bbbbbaaabababbabbbaaabbb
			bbaabbbaabbaabaabbbaabba
			abbbbabbbbbbabbabbabbbbaabbbbbabaabbababbbaababa
			babaababbababaabaabaababbaaaaaaabbabaaaaabaaabbbabbabbba
			bbabababbaabbbbaaaaabaaaaaabbbbb
			abaabababbaabbbbaaabbaaa
			aaabaabaabbbbabbabababba
			bbbabbabbbbababbbbaabbab
			bbbbabbbaabababbaabaabbbabaaabaa
			babaaaabaabaababababbbabbabbabbbaabbaaaabaaababababbbabbabbaaaab
			aaaaaabbbbbbbbbababaabbbabbbaaaabbbaabbaaabbbaba
			babbababbaababbbababbaaa
			baabaabbabbbaaaaabbabaabbaaaabaabbbbbbbbbabbbaab
			bbbababbbbaaabaabaaabbba
			bbabaabbbabaaababaaaaaba
			abaabbabaabbbbaabbabbbaa
			abbaababbbbbaababbbbabab
			ababaaaaabbbaabbbbaaaabb
			babaaaabbabaaabaaaabbaaa
			aabababaaabababaabbaabbb
			abbbbbabbaabaaabbaaaabab
			baaabbaababbaabbaabbabbabaaaaaba
			aaaabaaaaabaabbbabbbbaba
			abaabbabbaaabbaababbaaaabaaabbbaabbabbaa
			aabaaabbababbaabbbaabbbaabaaaabaaaabbbab
			abaaaaaabababbbbabbaaaba
			abbbbaabaabbbabbbabbababaabbababbababbba
			aabaababbabaabbbaababbbaabaababbbbbabbaabbaabaaaabaabaab
			bbabaabbaaababbbabbaaaaa
			bbbabbbaaabbabbbaabbabab
			bbaaaababbbabbaabbbbaaabbabaaaabbbbabbbaaabababababbabba
			bbaaaaaabbbabbaaaaabbbbbaababaabababbbbabbabbbbaabbbbbabaabaaaabbbbabbbbbbaaabbbbaaaaaaaaabaaaab
			baaaabbaaaaaaababbaabaaa
			bbbbaababbaaabaabbababba
			abbaabaaabbbaabbaaabbbba
			aaabbabababbbbabbabbbababbaaaaaaaaabaaab
			baabbbbaaababbbbababbaaa
			bbabaaaaababbabbbabaabaa
			bbaabbbbabaaaabababbbbbb
			abaabbbaaabababaaaaabbba
			ababbbbbababbbaaaaaaaaab
			aaaaababbabbabaaaabbaabb
			bbaaabbabaabaaabaabbbbababbaaabb
			ababbbbaabbbbaabaabaaaba
			baabbaaabbbbbabaabbaaaaa
			baaaabbbbbababababaababababababaaabaababbaabaaaabbbaabba
			baabaaaabbbbbababaaaaaba
			abbbaabbbabbaaaaaaabbbaa
			abbaaabbaabbaabaaabbaabbbbaabaaa
			abbbbaabaabbbaabbbabbaab
			bbabaaaabbbababbbbaaabbb
			abaababbbaaaabbaaababaabaaaabbabbabbbbbb
			babaabbaaabababababbbbaabbbbbbab
			aaaabbabbbbabaaabbaabbab
			abbbabaabbaabbbaaabbaaaabaaabbbbbabaabbbabbbaaab
			ababbbbaababaaaabbbaaaba
			abaaaaaaaaabaabaaabbabaa
			aababaabbaaabbbbbbaababa
			aaaabbabbbbbbbbaaabbbaaaaaaaababaabaababaababbabaaaaabba
			bbbbaabbaabbbaaaabbaaaab
			bbabbbbabbbbaabaabbbbaba
			ababaaaaababaaaaababbaaabaaaabaabbababaaaabbbabb
			ababaaaabbaaabaaaabaaaba
			aababbaaaaabbabaaaaaaaaa
			bbaabababbabaaaabbbaabbabbbaaabbbbbbbabbabaaabaa
			abbbbabbaabbbbabbaababaa
			bbaaaababaabbabbabbabbabbababaaaabaabbaa
			aabaabaabbabbbbaabaabbaa
			ababababbaaabbaaaabababb
			baabbaaabababbabaaabbbaa
			baaaaaabbaaaaaaabaaaabbababbaaba
			aababbbbaaaabbaabbbabaab
			bbaaaabaaaaaababbbaaaababbbaababababbbab
			bbabbababbbababbabaabaaa
			abbbababbaabbaaaababaaaabbabbbab
			baabbaabaaaaaabaabababaabbbaaabbababbabbbabaaaabaaabaaabaaaaabbaababbaaa
			babaabbbbbbbbababbbaaaba
			babaaabaabaaaaabababbbbaabbbaaab
			bbbbbbbbaababbaabaababababbaabaabbbaabaaaabbbbba
			aaabaababbbabaaaabababaa
			babababababbbaababaaaabbbabaaabbaababbaabbbabbaabbaaabbabbababbaabaabbaa
			bababababaabbbbabbbaaaaa
			bbbbbaaabaaaaaabbbaabbbaaaaaaabaababaaab
			aaaabaabababbbbbabbbbaaa
			abbbbbbaaabaababbbaaaaabaaaabbabbabbbbabaabbaabbbbaaababababbbbb
			baababbbabbbbabbaaababaa
			ababbbbaabbbaabbbbabbaab
			bbbbaabbaaabaabaabbabbba
			ababaabbbababbbbbabbbabb
			baaaabbaaababbaabaaaabaabbaaaaaabbaaaabb
			abbbabaaaaaabbabbababbaa
			abaaabbbababbbbabbbbabbaababbabbbabbaabbabaabaaaabbaabaa
			bbbabbbabaaaabbbbbbbbbab
			bbabababbaaaabaabbbaabba
			baabbbbaaabbbaaaaaababba
			baabaaabbabaaababbaababb
			abaaaabbaabaaabbbbbaabbb
			bbababababaabbbaaaaabbbbabbbaaaaabbabababbbbbaabaababbab
			ababaaaaaabbbaabbbabbaba
			aabaabbbbbaaabaabaabbaba
			abbbabaababbabaabbaababa
			bbabababbbbabababaabaaabbbababaa
			bbbbaabbabbaabaaaaaaaaab
			aababbbbaaaaaababbbaaaba
			aababaabaaabbabaaabaabba
			babaabbaaabaabaaaaaaaabaaabaaaba
			ababaaaaababaabbbbbaabbb
			bbbbabbaaababbbbbbaaabbabaaababa
			bbbabbbaaabaabbbbbaabaaa
			abbabbabbaabbaaababbbabb
			""".components(separatedBy: "\n\n").map { $0.components(separatedBy: .newlines) }
		}
	}
}

struct Rule {
	let id: Int
	let matches: String

	init(string: String) {
		let parts = string.components(separatedBy: ": ")
		id = Int(parts[0])!
		if parts[1].hasPrefix("\"") {
			matches = String(parts[1].dropFirst().first!)
		} else {
			matches = "( " + parts[1] + " )"
		}
	}
}

// MARK: - Part 2

extension NSRegularExpression {
	func matchLen(_ string: String) -> Int {
		let range = NSRange(location: 0, length: string.utf16.count)
		return rangeOfFirstMatch(in: string, range: range).length
	}
}

enum Solve19StolenPart2 {
	static func regex(for rule: Rule, using rules: [Int: Rule]) -> String {
		var matches = rule.matches
		while matches.contains(where: { Int(String($0)) != nil }) {
			matches = matches
				.components(separatedBy: " ")
				.map { token in
					if let id = Int(token) {
						return rules[id]!.matches
					} else {
						return token
					}
				}
				.joined(separator: " ")
		}

		return matches.replacingOccurrences(of: " ", with: "")
	}

	static func run(example: Bool) -> Int {
		let input = example ? InputData.example2.data : InputData.challenge.data
		let rules = input[0].map(Rule.init).reduce(into: [Int: Rule]()) {
			$0[$1.id] = $1
		}

		let r31 = try! NSRegularExpression(pattern: regex(for: Rule(string: "999: ( 31 )+"), using: rules) + "$")

		let r = "^" + regex(for: Rule(string: "0: 42 ( 42 )+ ( 31 )+"), using: rules) + "$"
		let filtered = input[1].filter { $0.range(of: r, options: .regularExpression) != nil }

		let count = filtered.filter { r31.matchLen($0) < ($0.count / 2) }.count
		return count
	}
}
