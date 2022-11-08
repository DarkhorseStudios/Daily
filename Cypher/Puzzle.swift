import Foundation

class Puzzle: Codable, ObservableObject {
//== has two initializers

 private(set) var title = "default title"
 private(set) var hintAnswerPairs = [HintAnswerPair]()
 private(set)var started: Bool
 private(set) var finished: Bool {
 didSet {
var numberOfSolvedHints = 0
for pair in hintAnswerPairs {
if pair.solved {
numberOfSolvedHints += 1
}//conditional
}//loop

if numberOfSolvedHints == hintAnswerPairs.count {
finished = true}//conditional
}//didset
}//finished computation block

init (fromFileWithName: String) {
let ref: Puzzle = Bundle.main.decode(fromFileName: fromFileWithName)
self.title = ref.title
self.hintAnswerPairs = ref.hintAnswerPairs
self.started = ref.started
self.finished = ref.finished
}//init

required init(from decoder: Decoder) throws {
let container = try decoder.container(keyedBy: CodingKeys.self)

title = try container.decode(String.self, forKey: .title)
hintAnswerPairs = try container.decode([HintAnswerPair].self , forKey: .hintAnswerPairs)
started = try container.decode(Bool.self, forKey: .started)
finished = try container.decode(Bool.self, forKey: .finished)
}//required init
//CodingKeys for conformance to Observable object because the properties of the class are wrapped with @Published
enum CodingKeys: CodingKey {
case title, hintAnswerPairs, started, finished
}//codingKeys
//methods

func SetHintAnswerPairToSolved(atIndex: Int) {
hintAnswerPairs[atIndex].setSolved(true)
}//setHintAnswerPairToSolved
func setStarted(_ new: Bool) {
started = new
}//setStarted
func setFinished(_ new: Bool) {
finished = new
}//setFinished
//For ObservableObject conformance
func encode(to encoder: Encoder) throws {

var container = encoder.container(keyedBy: CodingKeys.self)

try container.encode(title, forKey: .title)
try container.encode(hintAnswerPairs, forKey: .hintAnswerPairs)
try container.encode(started, forKey: .started)
try container.encode(finished, forKey: .finished)
}//encode
}//class
