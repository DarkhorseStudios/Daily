import Foundation

struct PuzzlePackData: Decodable {
private(set) var title: String
//This is the compressed version of the title, without any whitespace so that we can use it to iterate over files that contain the name, adding any number as needed.
private(set) var fileNameWithoutNumbers: String
//private(set) var puzzles: [Puzzle]
}//struct
