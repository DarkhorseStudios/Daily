import SwiftUI

//This is used to ShareScoreButton so that users have a picture they can share with their post
struct SharedScoreView: View {

@EnvironmentObject var allSettings: AllSettings
let puzzleTitle: String
let score: Int
let totalButtonsPressed: Int
//Comes ffrom GameData, by passing the size of the buttonData array
let numberOfLetterGroups: Int

//A few of the values in Puzzle objects are optional, because we don't provide values im in our Bundle, but we provide default values for them when moving them to the user's DocumentDirectory. Because of this, we can force-unwrap them
init(puzzle: Puzzle, numberOfLetterGroups: Int) {
self.puzzleTitle = puzzle.title
self.score = puzzle.score!
self.totalButtonsPressed = puzzle.totalButtonsPressed!
self.numberOfLetterGroups = numberOfLetterGroups

}//init

var body: some View {

ZStack {

LinearGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()

VStack {

HStack {

Spacer()
Text(puzzleTitle)
.foregroundColor(allSettings.colorScheme.primaryFontColor)
.font(.largeTitle)
Spacer()
}//HStack
.padding()
Text("I just got a score of \(score). There were\(numberOfLetterGroups) letter groups to choose from, and it tooke me \(totalButtonsPressed) tries to finish spelling all six words in \(puzzleTitle)")
.lineLimit(nil)
.foregroundColor(allSettings.colorScheme.secondaryFontColor)
.font(.title)

}//VStack
}//ZStack

}//body
}//struct
struct SharedScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Text("SharedScoreView preview")
    }
}
