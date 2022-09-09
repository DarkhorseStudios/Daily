//
//  ActivePuzzleView.swift
//  Cypher
//
//  Created by Zach Tidwell on 8/29/22.
//

import SwiftUI

struct ActivePuzzleView: View {
@ObservedObject var allSettings: AllSettings
@State var currentPuzzle: Puzzle
@State private var currentSpelling = ""
@State private var allAnswers = [String]()

    var body: some View {
        NavigationView {
ZStack {
        LinearGradient(colors: [allSettings.primaryBackgroundColor, allSettings.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()

VStack {
//A custom view to display the hints
//A text view for the current letters
Text(currentSpelling)
.clipShape(Capsule())
.navigationTitle("Your current spelling is:")

//A view to show all of the letter grouping buttons
Section {
//This sill end-up being a custom-shaped field.
//Need all of the answers as an array
//ForEach(self.parseAnswersFrom(hintAsnwerPairs: currentPuzzle.hintAnswerPairs), id: \self.answer) { answer in
//}//loop
//Need to check how the answers are separated, and put thought into how to draw them
Button("Shuffle Letters") {
//rearrange letter groups
}//shuffle button
.clipShape(Capsule())
}//section
}//VStack
}//ZStack
}//NavView
.navigationTitle(currentPuzzle.title)
.font(.title)
    }//body

//This is used to separate all of the answers into scrambled letter groups so that they can be passed into the LetterGroupButtonView
func splitAllAnswersIntoLetterGroups(answers: [String]) -> [String] {
//returned array
var letterGroups = [String]()
for answer in answers {
let newAnswer = self.splitAnswerIntoLetterGroups(input: answer)
for group in newAnswer {
letterGroups.append(group)
}//nested loop
}//loop
return letterGroups
}//func
//Separates each answer into different word groups, based on their size.
func splitAnswerIntoLetterGroups(input: String) -> [String] {
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
//returned array
var wordAsLetterGroups = [String]()
let wordAsCharacters = [word]
//if the word is less than or equal to 6 letters, we strictly split it into groups of two letters. If it's the
//if the word is bigger than 6 letters, we give the code the option to split it into multiple three-letter groups.
//If the word is in between 6 and 8, we throw an error.
//**This ondtional is commented-out so I can just test the logic.
//if totalLetterCount <= 6 {
//represents the base of the index range we want to access.
var baseIndex = 0

//We use baseIndex + 1 for the compared value because it's the bottom end of the range of characters we're getting the the array of characters

while (baseIndex + 1) < wordAsCharacters.count {
var newLetterGroup = String()
newLetterGroup += wordAsLetterGroups[baseIndex]
newLetterGroup += wordAsCharacters[baseIndex + 1]

wordAsLetterGroups.append(newLetterGroup)
baseIndex += 2
}// while loop
//} else if totalLetterCount >= 8 {
//Start here. Need to test the above code first though. Consider just editing the condtional to allow for basic testing.
//} else {
//fatalError("In struct ActivePuzzleView, func splitEven failed to split '\(word)")
//}//conditional
return wordAsLetterGroups
}//func

func splitOdd(word: String) -> [String] {
//returned array
var wordAsLetterGroups = [String]()
let wordAsCharacters = [word]
let totalLetterCount = wordAsCharacters.count
var baseIndex = 0

for value in self.getArrayOfGroupSizes(letterCount: totalLetterCount) {

let indexRange = baseIndex...baseIndex + value
var newGroup = String()
for letter in indexRange {
newGroup.append(wordAsCharacters[letter])
} // loop adding letters to newGroup

wordAsLetterGroups.append(newGroup)
baseIndex += value
}//loop

return wordAsLetterGroups
}//func

func getArrayOfGroupSizes(letterCount: Int) -> [Int] {
//returned array
var groupSizes = [Int]()
var totalLettersRepresentedInArray = 0

//This condition decides if the group of three will come from one of the ends or the middle.
if Bool.random() {
//Nested Bool decides if the group of three comes from the front or the back
if Bool.random() { //Group of three comes from the front of the word.
groupSizes.append(3)
totalLettersRepresentedInArray += 3
//adding remaining letters to word.
while totalLettersRepresentedInArray != letterCount {
groupSizes.append(2)
totalLettersRepresentedInArray += 2
}//loop

}else { //The group will come from the end of the wortd

while totalLettersRepresentedInArray != letterCount - 3 {
groupSizes.append(2)
totalLettersRepresentedInArray += 2
}//loop
groupSizes.append(3)
}//nested conditional

} else { // the group of three will come from the middle of the word

var groupOfThreeHasBeenAdded = false

while totalLettersRepresentedInArray != letterCount {

if !groupOfThreeHasBeenAdded {
if totalLettersRepresentedInArray > 2 && totalLettersRepresentedInArray < (letterCount - 2) {
if Bool.random()  || totalLettersRepresentedInArray == (letterCount - 5){
groupSizes.append(3)
groupOfThreeHasBeenAdded = true
}//conditional that adds three
}//nested conditional
}//conditional chcking if group of three has been added
}//loop

}//conditional deciding if group of three comes from middle of word or one of the ends

return groupSizes
}//func
func parseAnswersFrom(hintAsnwerPairs: [HintAnswerPair]) -> [String] {
var isolatedAnswers = [String]()
for pair in hintAsnwerPairs {

//isolatedAnswers.append(pair.answer)
}//loop
return isolatedAnswers
}//func
}//struct

struct ActivePuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        ActivePuzzleView(allSettings: AllSettings(), currentPuzzle: Puzzle())
    }
}
