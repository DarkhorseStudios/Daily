import Foundation
import UIKit
//Uses UITextChecker to iterate over evey puzzle checking for issues with the hints and answers
//We can call this in Content View after initializing AllPuzzlePacks, or by just iterating over the bundle
struct SpellingTest {

let checker = UITextChecker()
//used to compress letter groups into answers when checking spelling
let answerParser = AnswerParser()

func testAllPuzzles(allPuzzlePacks: AllPuzzlePacks) {

var allPuzzleFileNames = BundleDirectoryProvider().allPuzzleFileNames()

//omit any files that aren't for puzzles so we don't get decoding errors
for fileName in allPuzzleFileNames {
for directoryName in allPuzzlePacks.getPuzzlePackDirectoryFileNames() {
if fileName == "\(directoryName)PuzzlePacksDirectory.json" || fileName.hasSuffix("Template.json") {
allPuzzleFileNames.remove(at: allPuzzleFileNames.firstIndex(of: fileName)!)
}//conditional
}//loop over directory file names
}//loop over all puzzleFileNames
//represents puzzles that still have spaces in their answers

var allRawPuzzlesFromBundle = [Puzzle]()

for fileName in allPuzzleFileNames {
allRawPuzzlesFromBundle.append(Puzzle(fromFileWithName: fileName))
}//loop

//Now we loop over each puzzle
for puzzle in allRawPuzzlesFromBundle {
testIndividualPuzzle(puzzle)
}//loop
}//testAllPuzzles

func testIndividualPuzzle(_ puzzle: Puzzle) {
print("=== summary for \(puzzle.title)")
var indexInHintAnswerPairs = 0
//used to test for repeated letter groups
var allAnswersWithSpaces = [String]()
for pair in puzzle.hintAnswerPairs {

allAnswersWithSpaces.append(pair.answer)
let hintSeaparatedIntoWords = pair.hint.components(separatedBy: " ")
//a value of false means the word was spelled wrong
//each word fromt he hint is tested, and has ithe truth of whether or not it failed added to this array.
//So, we can iterate over each word as we iterate over the array to know which words match which booleans
let hintTestBools = testHint(hintSeparatedIntoWords: hintSeaparatedIntoWords)

for i in 0..<hintTestBools.count {
if hintTestBools[i] == false {
print("hint at index \(indexInHintAnswerPairs) word: \(hintSeaparatedIntoWords[i])")
}//conditional
}//loop over hints

//returns false if the answer was spelled incorrectly
if testAnswer(pair.answer) == false {
print("Answer at index \(indexInHintAnswerPairs), \(pair.answer) was spelled incorrectly")
}//conditional for answers
indexInHintAnswerPairs += 1
}//loop over hintAnswerPairs

testForRepeatedLetterGroups(allAnswersWithSpaces: allAnswersWithSpaces)

}//testIndividualPuzzle

func testHint(hintSeparatedIntoWords: [String]) -> [Bool] {

//return value
var successOfTests = [Bool]()

for word in hintSeparatedIntoWords {
//should return true if spelled wrong
if !testWord(word) {
successOfTests.append(false)
} else {
successOfTests.append(true)
}//conditional
}//loop

return successOfTests
}//test hint

//returns true if failed
func testAnswer(_ answer: String) -> Bool {
let answerWithoutSpaces = answerParser.compressLetterGroupsIntoAnswer(for: answer)

return testWord(answerWithoutSpaces)
}//testAnswer
//Having repetitive letter groups can cause issues in ForEach loops, and making sure they're all different will also make puzzles a little harder.
func testForRepeatedLetterGroups(allAnswersWithSpaces: [String]) {
var allLetterGroups = [String]()

for value in allAnswersWithSpaces {

let newGroupOfGroups = value.components(separatedBy: " ")

for letterGroup in newGroupOfGroups {
allLetterGroups.append(letterGroup.lowercased())
}//loop
}//loop

//now we loop over all letter groups for this puzzle to find matches.
for group in allLetterGroups {

var instancesOfGroupInPuzzle = 0

for i in 0..<allLetterGroups.count {

if allLetterGroups[i] == group {
instancesOfGroupInPuzzle += 1
}//conditional
}//loop

if instancesOfGroupInPuzzle > 1 {
print("LetterGroup \"\(group)\" appears \(instancesOfGroupInPuzzle) times")
}//conditional
}//loop
}//test for repeated letter groups
//a return value of false means it was spelled incorrectly
func testWord(_ word: String) -> Bool {

    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound

}//testWord
}//struct
