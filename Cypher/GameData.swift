//We use SwiftUI instead of Foundation so we can post UIAccesibilityNotifications when a HintAnswerPair is set to solved.
import SwiftUI

class GameData: ObservableObject {

@Published private(set) var currentSpelling = ""
@Published private(set) var puzzle: Puzzle
@Published private(set) var allAnswers = [String]()
@Published private(set) var letterGroups = [String]()
@Published private(set)var buttonData = [LetterGroupButtonData]()
//When a button's name is added to currentSpelling, we also add its data here so we can make sure it doesn't become enabled again if the answer is corresponds to is solved.
//If it does become solved, we then transfer the data from this array into permanentlyDisabledButtonData
private(set) var buttonDataAppliedToCurrentSpelling = [LetterGroupButtonData]()
private(set) var permanentlyDisabledButtonData = [LetterGroupButtonData]()

init(puzzle: Puzzle) {
self.puzzle = puzzle
}//init

//methods

//This first group of methods is for accessing data in this class
func appendCurrentSpelling(with: String) {
currentSpelling += with.lowercased()
}//appendCurrentspelling
func clearCurrentSpelling() {
currentSpelling = ""
}//clearCurrentSpelling
//We add this data to the array so we can make sure any buttons that spelled a completed answer don't become enabled again when we set the HintAnswerPair to solved and clearCurrentSpelling()
func appendButtonDataAppliedToCurrentSpelling(with data: LetterGroupButtonData) {
buttonDataAppliedToCurrentSpelling.append(data)
}//appendButtonDataAppliedToCurrentSpelling
//When the letters  applied to currentSpelling end-up solving an answer for a HintAnswerPair, we transfer their data from the buttonDataAppliedToCureentSpellingArray into permanentlyDisabled so that they can't become enabled in restoreButtonVisibility
func tranferButtonDataFromSolvedAnswerIntoPermanentlyDisabledButtonData() {
permanentlyDisabledButtonData += buttonDataAppliedToCurrentSpelling
buttonDataAppliedToCurrentSpelling = [LetterGroupButtonData]()
}//transerData
//Loops over the array of buttonData to find the data that corresponds with a button that was pressed so we can update its shouldBeHidden values
private func updateShouldBeHiddenForButtonData(with id: UUID, to new: Bool) {
}//updateShouldBHidden

//Allows us to find a dataSet with a certain UUID
//Gets called in the above actions that update values of the data sets in buttonData
func accessSetOfButtonData(with id: UUID) -> LetterGroupButtonData{
var matchingData = LetterGroupButtonData(name: "Placeholder name from accessSetOfButtonData() in GameData")
for dataSet in buttonData {
if dataSet.id == id {
matchingData = dataSet
}//conditional
}//loop

return matchingData
}//accessSetOfButtonData
func restoreButtonVisibility() {
for dataSet in buttonData {
if !permanentlyDisabledButtonData.contains(where: {$0.id == dataSet.id}) {
if dataSet.shouldBeHidden == true {
dataSet.setShouldBeHidden(false)
}//conditional
}//conditional for contains()
}//loop
}//restore

//We have to pass the new value as a parameter because of the way the onChange() modifier captures the old value before running code
func checkSpellingAndInformCurrentPuzzle(newValue: String) {
let lowerCasedNewValue = newValue.lowercased()
var spellingMatchesAnswer = false
for pair in puzzle.hintAnswerPairs {
if lowerCasedNewValue == pair.answer.lowercased() {
//we're able to pass a pair here because its equatable conformance compares the answer properties
if let indexOfPair = puzzle.hintAnswerPairs.firstIndex(of: pair) {
puzzle.hintAnswerPairs[indexOfPair].setSolved(true)
spellingMatchesAnswer = true
}//unwrap
}//conditional
}//loo

//We have to make sure the buttons currentlyApplied to currentlSpelling stay disabled
if spellingMatchesAnswer {
clearCurrentSpelling()

}//conditional
}//checkSpellingAndInformCurrentPuzzle
func checkIfEntirePuzzleIsComplete(newValue: Int) -> Bool {
//return value
var completed = false

if newValue == puzzle.hintAnswerPairs.count {
puzzle.setFinished(true)
completed = true
}//conditional

return completed
}//checkIfEntirePuzzleIsComplete
func savePuzzle(puzzle: Puzzle, puzzleFileName: String) {
DocumentDirectoryProvider().savePuzzleToDocumentDirectory(for: puzzle, withFileName: puzzleFileName)

}//save

//The rest of these methods pertain to initializing game information
//This takes all of the answers, converts them to letter groups, fills button data, and appends the array of button data
//Called in onAppear of ActivePuzzleView
func initializeData() {
var allAnswers = [String]()
for i in puzzle.hintAnswerPairs {
allAnswers.append(i.answer)
}//loop

let allLetterGroups = splitAllAnswersIntoLetterGroups(allAnswers: allAnswers)

var indexOfRow = 0
//This value is for retrieving the name of each button
var indexInAllLetterGroups = 0

for rowSize in getNumberOfButtonsPerRow(allLetterGroups: allLetterGroups) {
for indexOfButtonInRow in 0..<rowSize {
buttonData.append(LetterGroupButtonData(name: allLetterGroups[indexInAllLetterGroups]))
indexInAllLetterGroups += 1
}//nested loop

indexOfRow += 1
}//loop
}//initializeData

//This is used to separate all of the answers into scrambled letter groups so that they can be passed into the LetterGroupButtonView
//It does so by calling successive functions that ultimately split words into groups of two or three letters, then returning an array containing every one of those groups of letters
func splitAllAnswersIntoLetterGroups(allAnswers: [String]) -> [String] {
//returned array
var letterGroups = [String]()
for answer in allAnswers {
let answerAsLetterGroups = self.splitIndividualAnswerIntoLetterGroups(input: answer)
for group in answerAsLetterGroups {
letterGroups.append(group)
}//nested loop
}//loop
return letterGroups
}//func
//Separates each answer into different word groups, based on their size.
func splitIndividualAnswerIntoLetterGroups(input: String) -> [String] {
//returned array
var answerAsLetterGroups = [String]()
//checks if the word has an even or odd number of letters in it
if input.count % 2 == 0 {
answerAsLetterGroups = self.splitEven(word: input)
} else {
answerAsLetterGroups = self.splitOdd(word: input)
}//conditional checking modulas of input's count

return answerAsLetterGroups
}//func

//These next two functions handle words differently if they contain an even or odd number of letters, and depending on the size of the word
func splitEven(word: String) -> [String] {
print("Starting SplitEven for \(word)")
//returned array
var wordAsLetterGroups = [String]()
let inputWordAsCharacters = Array(word)
let totalLetterCount = inputWordAsCharacters.count
print("letter count for \(word) is \(totalLetterCount)")
//if the word is less than or equal to 6 letters, we strictly split it into groups of two letters. If it's the
//if the word is bigger than 6 letters, we give the code the option to split it into multiple three-letter groups.

//if totalLetterCount <= 6 {
//represents the base of the index range we want to access.
var baseIndex = 0

//We use baseIndex + 1 for the compared value because it's the bottom end of the range of characters we're getting the array of characters
while (baseIndex + 1) < totalLetterCount{
let newGroup = String(inputWordAsCharacters[baseIndex...baseIndex + 1])
wordAsLetterGroups.append(newGroup)
baseIndex += 2
}// while loop
/*
//} else {// totalLetterCount >= 8
//We have to increment baseIndex differently bu deciding ahead of time if the word will have some letter groups of three letters. If we have one group of three, we have to have at least two to end-up with an even number of letter groups
//}//lop for more than 6 letters
*/
print("splitEven is returning letter groups for \(word)")
print(wordAsLetterGroups.count)
return wordAsLetterGroups
}//func

func splitOdd(word: String) -> [String] {
//returned array
var wordAsLetterGroups = [String]()
let inputWordAsCharacters = Array(word)
let totalLetterCount = inputWordAsCharacters.count
var baseIndex = 0

//Need an intelligent loop to establish groups of two and three letters
var safetyCount = 0
//** when I would only miss one letter per word , this conditional was baseIndex + 1 = totalLetterCount + 1
while baseIndex + 2 < totalLetterCount && safetyCount < 10 {

//Also need to check if there are 5 letters left in the word.

//First, we check if making another group of two or three would leed to an out-of-bounds error, or end-up with a remainder of one determine what size the next letter group can be
// first check makes sure that if there are only four letters remaining to be split into letterGroups, we make a group of two so we dont't try and make a group of three and end-up with one letter leftover.

if baseIndex + 3 == totalLetterCount - 1 {
print("splitOdd going down route for two groups of two with baseIndex starting at \(baseIndex)")
//We do this twice so that we don't have to cycle the loop and conditionals just to make the last group of two
let group = String(inputWordAsCharacters[baseIndex...baseIndex + 1])
print("splitOdd's conditional  adding \(group) ")
wordAsLetterGroups.append(group)
baseIndex += 2
let secondGroup = String(inputWordAsCharacters[baseIndex...baseIndex + 1])
print("splitOdd's conditional for two groups of two attempting to add \(secondGroup)")
wordAsLetterGroups.append(secondGroup)
baseIndex += 2

//Second check makes sure that if there are only three letters left in the word, we make a group of three
} else if baseIndex + 2 == totalLetterCount - 1 {
print("SplitOdd's random assignment beginning with baseIndex : \(baseIndex)")
//makes a group of three
let group = String(inputWordAsCharacters[baseIndex...baseIndex + 2])
print("splitOdd adding \(group)")
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 2]))
baseIndex += 3

//Otherwise, we just let the game decide if it's going to make a group of two or three
} else {
print("splitOdd() randomly deciding for group of two or three")
if Bool.random() {
print("splitOdd() making group of two")
let group = String(inputWordAsCharacters[baseIndex...baseIndex + 1])
print("splitodd randomly adding \(group)")
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 1]))
baseIndex += 2
} else {
print("splitOdd() making group of three")
//**I think the issue is here
let group = String(inputWordAsCharacters[baseIndex...baseIndex + 2])
print("split odd randomly adding \(group)")
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 2]))
baseIndex += 3
}//nested conditional with random Bool
}//conditional
print("basIndex at end of loop is \(baseIndex)")
print("safetyCount is \(safetyCount) before incrementing")
safetyCount += 1
}//loop
print("splitOdd() returning lettergroups for \(word)")
print("splitOdd input word size: \(word.count)")
print("splitOdd returning word with size: \(wordAsLetterGroups.count)")
return wordAsLetterGroups
}//func
func GetAllAnswersFromCurrentPuzzle() {
var placeholderArray = [String]()
for pair in puzzle.hintAnswerPairs {
print(pair.answer)
placeholderArray.append(pair.answer)
//self.allAnswers.append(pair.answer)
}//loop
self.allAnswers = placeholderArray
}//func
//Used in initializeData(). Determines the number of buttons per row
func getNumberOfButtonsPerRow(allLetterGroups: [String]) -> [Int] {
//return array
var buttonsPerRow = [Int]()
//We use 5 here because we only want a maximum of 5 buttons per row
let remainder = allLetterGroups.count % 5
if remainder > 0 {

let numberOfFullRows = (allLetterGroups.count - remainder) / 5
for _ in 1...numberOfFullRows {
buttonsPerRow.append(5)
}//loop

buttonsPerRow.append(remainder)
}else {
let numberOfRows = Int(allLetterGroups.count / 5)
for i in 1...numberOfRows {
buttonsPerRow.append(i)
}//loop
}//conditional
return buttonsPerRow
}//func
}//class
