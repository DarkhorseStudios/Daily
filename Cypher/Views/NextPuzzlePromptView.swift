import SwiftUI

//This view is for when the player has successfully completed a puzzle
struct NextPuzzlePromptView: View {

@EnvironmentObject var allSettings: AllSettings
//used for calculating score
@EnvironmentObject var gameData: GameData
@EnvironmentObject var allSheetViewBooleans: AllSheetViewBooleans
let completionMessages = ["Nice work!", "You nailed it!", "Boom! You're finished", "Great job!"]

var body: some View {

ZStack {
        RadialGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], center: .center, startRadius: 300, endRadius: 50)
.ignoresSafeArea()

VStack {
HStack {

Spacer()
//we force-unwrap this string because it's hard-coded and shouldn't be able to fail
Text(completionMessages.randomElement()!)
.font(.title)
.foregroundColor(allSettings.colorScheme.primaryFontColor)
.padding()

Text("Your score was \(gameData.generateFinalScoreForPuzzle())! There were \(gameData.buttonData.count) groups of letters, and you added them to your spelling \(gameData.puzzle.totalButtonsPressed!) times.")
.lineLimit(nil)
Spacer()
}//HStack
.padding(.vertical)

Section {
//The share button is bigger than the others, which is why it's not in an HStack

ShareScoreButton()
.clipShape(Capsule())
.shadow(radius: 5.0)
.buttonStyle(.borderedProminent)

HStack {
Spacer()
Button("Next Puzzle ** Not hokked-up**") {
//Need code here
}//Button
Spacer()
}//HStack

HStack {
Spacer()
Button("Puzzlepacks") {
allSheetViewBooleans.userSelectedPuzzlePacks()
}//Button
Spacer()
}//HStack

HStack {
Spacer()
Button("Main Menu") {
allSheetViewBooleans.userSelectedMainMenu()
}//button
Spacer()
}//HStack
}//Section
}//VStack
}//ZStack
    }//body
}//struct

struct NextPuzzlePromptView_Previews: PreviewProvider {
    static var previews: some View {
Text("NextPuzzlePromptView preview")
    }
}
