import Foundation

//used for making letter groups for hard-coded puzzles
struct AnswerParser {
//takes-in array of all the answers for a puzzle
//called in the custom initialize() functions in GameData
func parseLetterGroups(in inputArray: [String]) -> [String] {

//return array
var letterGroups = [String]()
for answer in inputArray {
let groups = answer.components(separatedBy: " ")
letterGroups += groups

}//loop
return letterGroups
}//parseLetterGroups

//Takes in the hard-coded answer as letter groups and returns it without spaces.
//called in GameData.CheckSpelling() and in SolveHintAnswerView when showing the answer in the HintAnswerView
func compressLetterGroupsIntoAnswer(for answer: String) -> String {
let separatedLetterGroups = answer.components(separatedBy: " ")
var answerWithoutSpaces = String()

for letterGroup in separatedLetterGroups {
answerWithoutSpaces.append(letterGroup)
}//loop

return answerWithoutSpaces
}//compressLetterGroupsIntoAnswer
}//struct
