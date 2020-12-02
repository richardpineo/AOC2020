
import Foundation

class FileHelper {
	static func loadAndTokenize(_ filename: String) -> [[String]] {
		tokenize(load(filename) ?? [])
	}
	
	static func tokenize(_ values: [String]) -> [[String]] {
		values.map {
			$0.components(separatedBy: " ")
		}
	}
	
	static func load(_ filename: String) -> [String]? {
		guard let path = Bundle.main.path(forResource: filename, ofType: "txt") else {
			return nil
		}

		do {
			let content = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
			return content.components(separatedBy: "\n")
		} catch _ as NSError {
			return nil
		}
	}
}
