//We use SwiftUI instead of Foundation so we can post UIAccesibilityNotifications when a HintAnswerPair is set to solved.
import SwiftUI
//For announcing when a puzzle hint is solved
import AVFoundation

class GameData: ObservableObject {
var soundManager : SoundManager
//used in CheckSpellingAndInformCurrentPuzzle
let speech = AVSpeechSynthesizer()
@Published private(set) var currentSpelling = ""
@Published private(set) var puzzle: Puzzle
@Published private(set)var buttonData = [LetterGroupButtonData]()
//When a button's name is added to currentSpelling, we also add its data here so we can make sure it doesn't become enabled again if the answer is corresponds to is solved.
//If it does become solved, we then transfer the data from this array into permanentlyDisabledButtonData
private(set) var buttonDataAppliedToCurrentSpelling = [LetterGroupButtonData]()
//used for pulling letter groups from hard-coded answers and removing the spaces from those groups to get the actual answer
let answerParser = AnswerParser()

init(puzzle: Puzzle) {
print("GameData passed \(puzzle.title) in init")
self.puzzle = puzzle
//this class doesn't have allSettings as a stored property, so need to figure out how I want to do this Maybe use userDefaults
//self.soundManager = SoundManager(allSettings: self.AllSettings)
print("GameData's puzzle is now \(puzzle.title)")
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
func transferButtonDataFromSolvedAnswerIntoPermanentlyDisabledButtonData() {

var groupsAddedToDisabled = 0
for dataSet in buttonDataAppliedToCurrentSpelling {
puzzle.addToDisabledLetterGroupData(dataSet)
groupsAddedToDisabled += 1
}//loop

//empties the array
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
if !puzzle.disabledLetterGroupData!.contains(where: {$0 == dataSet}) {
if dataSet.shouldBeHidden == true {
dataSet.setShouldBeHidden(false)
}//conditional
}//conditional for contains()
}//loop
}//restore

//We have to pass the new value as a parameter because of the way the onChange() modifier captures the old value before running code
func checkSpellingAndInformCurrentPuzzle(newValue: String) {
let lowercasedNewValue = newValue.lowercased()
var spellingMatchesAnswer = false
for pair in puzzle.hintAnswerPairs {

if lowercasedNewValue == answerParser.compressLetterGroupsIntoAnswer(for: pair.answer).lowercased() {
//we're able to pass a pair here because its equatable conformance compares the answer properties
if let indexOfPair = puzzle.hintAnswerPairs.firstIndex(of: pair) {
puzzle.hintAnswerPairs[indexOfPair].setSolved(true)
let utterance = AVSpeechUtterance(string: "Solved: \(lowercasedNewValue)")
utterance.prefersAssistiveTechnologySettings = true
speech.usesApplicationAudioSession = false
speech.speak(utterance)

DocumentDirectoryProvider().savePuzzleToDocumentDirectory(for: puzzle)
spellingMatchesAnswer = true
}//unwrap
}//conditional
}//loo

//We have to make sure the buttons currentlyApplied to currentlSpelling stay disabled
if spellingMatchesAnswer {
transferButtonDataFromSolvedAnswerIntoPermanentlyDisabledButtonData()
clearCurrentSpelling()
soundManager.playHintSolved()
}//conditional

CheckAndSetIfPuzzleIsComplete()
}//checkSpellingAndInformCurrentPuzzle

func CheckAndSetIfPuzzleIsComplete() {

var completedPairs = 0

for i in puzzle.hintAnswerPairs {
if i .solved {
completedPairs += 1
}//conditional
}//loop

if completedPairs == puzzle.hintAnswerPairs.count {
puzzle.setFinished(true)
soundManager.playPuzzleCompleted()
DocumentDirectoryProvider().savePuzzleToDocumentDirectory(for: puzzle)
}//conditional
}//checkIfEntirePuzzleIsComplete

//Rearranges letter groups and replaces the array of letter groups with the shuffled version.
//Used in ActivePuzzleView
func shuffleLetterGroups() {
}//shuffleLetterGroups

//Takes-in the total number of LetterGroupButtons for a puzzle, and how many times a letterGroupButton was pressed to generate a score, like golf.
func generateFinalScoreForPuzzle() -> Int {

return puzzle.totalButtonsPressed! - buttonData.count
}//generateFinalScoreForPuzzle

//The rest of these methods pertain to initializing game information
//Called in onAppear of Active Puzzle view when players want to be able to get a score for their puzzle
func initializeHardCodedData() {

//Because the answers are stored with sapces in their name, we'll have to remove them to set the answers for the puzzle
var allAnswersSeparatedBySpaces = [String]()

//We remove the spaces from the answers when we check the spelling, and inside the Solved HintAnswerViews using the AnswerParser type
for i in puzzle.hintAnswerPairs {
allAnswersSeparatedBySpaces.append(i.answer)
}//loop
let letterGroups = answerParser.parseLetterGroups(in: allAnswersSeparatedBySpaces)

for group in letterGroups {
buttonData.append(LetterGroupButtonData(name: group))
}//loop
for dataSet in buttonData {
//we use names instead of id because they get different UUIDs whenever they are initialized
if puzzle.disabledLetterGroupData!.contains(where: {$0.name == dataSet.name}) {
print("initialize hardcoded data just hid \(dataSet.name)")
dataSet.setShouldBeHidden(true)
}//nested conditional
}//nested loop

}//initialize hardcoded data

//This takes all of the answers, converts them to letter groups, fills button data, and appends the array of button data
//Called in onAppear of ActivePuzzleView
func initializeRandomizedData() {
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
//print("calling split Even")
//returned array
var wordAsLetterGroups = [String]()
let inputWordAsCharacters = Array(word)
let totalLetterCount = inputWordAsCharacters.count
//represents the base of the index range we want to access.
var baseIndex = 0

while baseIndex < totalLetterCount - 1{
//print("At start, baseIndex: \(baseIndex), totalCount: \(totalLetterCount)")
//While there are 6 or more letters remaining, we let the function split the word into groups of two and three
if baseIndex + 5 < totalLetterCount {

let newGroup = makeRandomGroupOfTwoOrThree(from: inputWordAsCharacters, startingAt: baseIndex)
wordAsLetterGroups.append(newGroup)
baseIndex += newGroup.count

//if there are exactly 6 letters left, we either make two groups of three or three groups of two
} else if baseIndex + 5 == totalLetterCount - 1 {
var timesLoopHasRun = 0
//Makes two groups of three so we don't end-up with an odd number of letters
if Bool.random() {
while timesLoopHasRun <= 2 {
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 2]))
baseIndex += 3
timesLoopHasRun += 1
}//while loop

} else { //Makes three groups of two so we don't end-up with an odd number of letters remaining
while timesLoopHasRun <= 3 {

wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 1]))
baseIndex += 2
timesLoopHasRun += 1
}//while loop
}//conditional for multiple groups of two or three

} else if baseIndex + 4 == totalLetterCount - 1 {
let newGroups = makeOneGroupOfTwoAndOneGroupOfThree(from: inputWordAsCharacters, startingAt: baseIndex)
wordAsLetterGroups.append(newGroups[0])
wordAsLetterGroups.append(newGroups[1])
baseIndex += (newGroups[0].count + newGroups[1].count)

//There should only be 4 or less letters left, so we split into groups of two
} else {

wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 1]))
baseIndex += 2
}//conditionals checking how many letters are left
}// while loop
//print("ending splitEven()")
return wordAsLetterGroups
}//splitEven

func splitOdd(word: String) -> [String] {
//print("starting splitOdd()")
//returned array
var wordAsLetterGroups = [String]()
let inputWordAsCharacters = Array(word)
let totalLetterCount = inputWordAsCharacters.count
var baseIndex = 0

while baseIndex < totalLetterCount {

//if there are more than 5 letters remaining in the word, we let the code randomly decide between groups of two and three
if baseIndex + 4 >= inputWordAsCharacters.count {

let newGroup = makeRandomGroupOfTwoOrThree(from: inputWordAsCharacters, startingAt: baseIndex)
wordAsLetterGroups.append(newGroup)
baseIndex += newGroup.count

//First, we check if there are only five letters left so we can make one group of two and one group of three
} else if baseIndex + 4 == totalLetterCount - 1 {

//if this random bool is true, we make a group of three before tthe group of two. If false, we do the opposite
if Bool.random() {
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 2]))
baseIndex += 3
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 1]))
baseIndex += 2
}else {
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 1]))
baseIndex += 2
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 2]))
baseIndex += 3
}//conditional deciding how we split up the five remaining letters

//Next, we check if making another group of two or three would leed to an out-of-bounds error, or end-up with a remainder of one determine what size the next letter group can be
// check makes sure that if there are only four letters remaining to be split into letterGroups, we make a group of two so we dont't try and make a group of three and end-up with one letter leftover.
} else if baseIndex + 3 == totalLetterCount - 1 {
//We do this twice so that we don't have to cycle the loop and conditionals just to make the last group of two

wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 1]))
baseIndex += 2
wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 1]))
baseIndex += 2

//Second check makes sure that if there are only three letters left in the word, we make a group of three
} else if baseIndex + 2 == totalLetterCount - 1 {
//makes a group of three

wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 2]))
baseIndex += 3

//otherwise, there should only be two letters remaining, so we make a group of two
}else {

wordAsLetterGroups.append(String(inputWordAsCharacters[baseIndex...baseIndex + 1]))
baseIndex += 2
}//conditional
}//loop
//print("end splitOdd()")
return wordAsLetterGroups
}//splitOdd

//used in splitEven() and splitOdd(). To inverement the baseIndex in those methods, we just get the size of the string returned by this function
func makeRandomGroupOfTwoOrThree(from inputWordAsCharacters: [Character], startingAt index: Int) -> String {
//print("start randomGroupOfTwoOrThree")

//returned value
var newLetterGroup = String()
if Bool.random() {
newLetterGroup = String(inputWordAsCharacters[index...index + 1])
} else {
newLetterGroup = String(inputWordAsCharacters[index...index + 2])
}//conditional
//print("end random groupOfTwoOrThree")
return newLetterGroup
}//makeRandomGroupOfTwoOrThree

//used in splitEven() and splitOdd() for whenever there are exactly five letters left in a word.
func makeOneGroupOfTwoAndOneGroupOfThree(from inputWordAsCharacters: [Character], startingAt index: Int) -> [String] {
//print("starting maekOnGroupOfTwoAndOneGroupOfThree")
//return value
var bothLetterGroups = [String]()

if Bool.random() {
bothLetterGroups.append(String(inputWordAsCharacters[index...index + 1]))
bothLetterGroups.append(String(inputWordAsCharacters[index + 2...index + 4]))

} else {

bothLetterGroups.append(String(inputWordAsCharacters[index...index + 2]))
bothLetterGroups.append(String(inputWordAsCharacters[index + 3...index + 4]))
}//conditional
//print("end makeOneGroupOfTwoAndOneOfThree")
return bothLetterGroups
}//makeOneGroupOfTwoAndOneGroupOfThree

func GetAllAnswersFromCurrentPuzzle() -> [String] {

//return value
var allAnswersWithSpaces = [String]()
for pair in puzzle.hintAnswerPairs {
allAnswersWithSpaces.append(pair.answer)
}//loop

return allAnswersWithSpaces
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
