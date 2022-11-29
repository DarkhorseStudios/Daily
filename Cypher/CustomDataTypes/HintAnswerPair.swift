import SwiftUI
import AVFoundation

class HintAnswerPair: Codable, Equatable, ObservableObject {
//== has two initializers; the required initializer for ObservableObject Conformance, and a regular one
 private(set) var hint: String
 private(set) var  answer: String {
didSet {
answer = answer.lowercased()
}//didset
}//answer
 private(set) var solved = false

init(hint: String, answer: String) {
self.hint = hint
self.answer = answer
}//init
required init( from decoder: Decoder) throws {
let container = try decoder.container(keyedBy: CodingKeys.self)

hint = try container.decode(String.self, forKey: .hint)
answer = try container.decode(String.self, forKey: .answer)
solved = try container.decode(Bool.self, forKey: .solved)
}//required init
//CodingKeys needed to conform to ObservableObject because the decoded properties are wrapped with @Published
enum CodingKeys: CodingKey {
case hint, answer, solved
}//CodingKeys

//methods

func setSolved(_ to: Bool) {
self.solved = to
}//func
//These two are for ObservableObjectConformance
func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: CodingKeys.self)

try container.encode(hint, forKey: .hint)
try container.encode(answer, forKey: .answer)
try container.encode(solved, forKey: .solved)
}//encode


//For equatable conformance
static func ==(lhs: HintAnswerPair, rhs: HintAnswerPair) -> Bool {
return lhs.answer == rhs.answer
}//func

}//class
