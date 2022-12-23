import Foundation

class Puzzle: Codable, ObservableObject, Equatable {
//== has two initializers

 private(set) var title = "default title"
  private(set) var hintAnswerPairs = [HintAnswerPair]()
 @Published private(set)var started: Bool {
didSet {
print("Started for \(title) is \(started)")
}//didset
}//started
@Published  private(set) var finished: Bool {
didSet {
print("finished set to \(finished) for \(title)")
}//didset
}//finished
//when a hint is solved, the letter groups that applied to that puzzle are added to this array so that they will be dimmed if a puzzle-in-progress is opened again
private(set) var disabledLetterGroupData: [LetterGroupButtonData]?
//Marked as an optional so Swift doesn't try to decode a value that's not provided inside Bundle files for puzzles
private(set) var fileName: String?
//optional score so Swift doesn't look for it when decoding from bundle
//Default value is 99999
private(set) var score: Int?
//incremented by LetterGroupButtons when they are pressed while not disabled. Used for calculating score for the puzzle. default value is 0
private(set) var totalButtonsPressed: Int?
/* Tutorial for optionals in codable types
 https://www.hackingwithswift.com/books/ios-swiftui/using-generics-to-load-any-kind-of-codable-data
*/

init (fromFileWithName: String) {
let ref: Puzzle = Bundle.main.decode(fromFileName: fromFileWithName)
self.title = ref.title
self.hintAnswerPairs = ref.hintAnswerPairs
self.started = ref.started
self.finished = ref.finished
self.fileName = fromFileWithName
//nil coalescing for disabledLetterGroupButtonData makes it an empty array if it hasn't been saves
self.disabledLetterGroupData = ref.disabledLetterGroupData ?? [LetterGroupButtonData]()
//use nil coalescing for the score to set it to zero if it hasn't been saved yet
self.score = ref.score ?? 99999
//nil coalescing sets buttons pressed to zero if it hasn't been save
self.totalButtonsPressed = ref.totalButtonsPressed ?? 0
}//init

required init(from decoder: Decoder) throws {
let container = try decoder.container(keyedBy: CodingKeys.self)

title = try container.decode(String.self, forKey: .title)
hintAnswerPairs = try container.decode([HintAnswerPair].self, forKey: .hintAnswerPairs)
started = try container.decode(Bool.self, forKey: .started)
finished = try container.decode(Bool.self, forKey: .finished)
if let attemptedDisabledLetterGroups = try? container.decode([LetterGroupButtonData].self, forKey: .disabledLetterGroupData) {
disabledLetterGroupData = attemptedDisabledLetterGroups
} else {
disabledLetterGroupData = [LetterGroupButtonData]()
}//unwrap
if let attemptedFileName = try? container.decode(String.self, forKey: .fileName) {
fileName = attemptedFileName
} else {
fileName = "Required initializer for class Puzzle didn't find a fileName for \(title). Remember, you have to set the fileName after decoding a puzzle instance that hasn't been saved to the DocumentDirectory yet."
}//unwrap
if let attemptedScore = try? container.decode(Int.self, forKey: .score) {
score = attemptedScore
} else {
score = 99999
}//unwrap
if let  attemptedTotalButtonsPressed = try? container.decode(Int.self, forKey: .totalButtonsPressed) {
totalButtonsPressed = attemptedTotalButtonsPressed
} else {
totalButtonsPressed = 0
}//unwrap for totalButtonsPressed
}//required init

func encode(to encoder: Encoder) throws {

var container = encoder.container(keyedBy: CodingKeys.self)

try container.encode(title, forKey: .title)
try container.encode(hintAnswerPairs, forKey: .hintAnswerPairs)
try container.encode(started, forKey: .started)
try container.encode(finished, forKey: .finished)
try container.encode(disabledLetterGroupData, forKey: .disabledLetterGroupData)
try container.encode(fileName, forKey: .fileName)
try container.encode(score, forKey: .score)
try container.encode(totalButtonsPressed, forKey: .totalButtonsPressed)
}//encode

//CodingKeys for conformance to Observable object because the properties of the class are wrapped with @Published
enum CodingKeys: CodingKey {
case title, hintAnswerPairs, started, finished, fileName, score, disabledLetterGroupData,
totalButtonsPressed
}//codingKeys

//For Equatable conformance

static func == (lhs: Puzzle, rhs: Puzzle) -> Bool {
return lhs.title == rhs.title
}// ==

//methods

func SetHintAnswerPairToSolved(atIndex: Int) {
hintAnswerPairs[atIndex].setSolved(true)
}//setHintAnswerPairToSolved
func setStarted(_ new: Bool) {
print("\(title) calling setStarted()")
started = new
}//setStarted
func setFinished(_ new: Bool) {
print("\(title) calling setFinished()")
finished = new
}//setFinished
func setScore(_ new: Int) {
score = new}//setScore
func setFileName(_ new: String) {
fileName = new
}//setName
func addToDisabledLetterGroupData(_ newDataSet: LetterGroupButtonData) {
//We force unwrap the array because when we decode a puzzle, if no disabledLetterGroups sarray is found, we initialize an empty array and set disabledLetterGroup's value to it
disabledLetterGroupData!.append(newDataSet)
}//addToDisabledGroups
func incrementTotalButtonsPressed() {
//we force unwrap the value because both initializers give it a default value of 0 if nothing is found in the json file for the puzzle
totalButtonsPressed! += 1
}//incrementTotalButtonsPressed
}//class
