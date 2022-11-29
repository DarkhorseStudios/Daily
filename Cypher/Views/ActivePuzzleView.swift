import SwiftUI
import AVFoundation

struct ActivePuzzleView: View {

@EnvironmentObject var allSettings: AllSettings
@EnvironmentObject var allSheetViewBooleans: AllSheetViewBooleans
//This is passed-in the PuzzleButton in the .sheet modifier that initializes this view
@ObservedObject var gameData: GameData
private(set) var speech = AVSpeechSynthesizer()

init(gameData: GameData) {
print("ActivePuzzleView passed \(gameData.puzzle.title) in init.")
self.gameData = gameData
print("ActivePuzzleView's game data holds \(self.gameData.puzzle.title) at end of init")
}//init

var body: some View {

ZStack {
LinearGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
VStack {

Spacer()

HintAnswerView()

Section {
Text("Your current spelling is: ")
.foregroundColor(allSettings.colorScheme.primaryFontColor)
+ Text(gameData.currentSpelling)
.speechSpellsOutCharacters(true)

//Contains the button in an HStack to center it
HStack {

Spacer()

Button("Clear Current Spelling") {
gameData.clearCurrentSpelling()
gameData.restoreButtonVisibility()
}//button
.clipShape(Capsule())

Spacer()

}//Hstack
}//section
Spacer()

Spacer()
//Centers the shuffle button
HStack {

Spacer()

Button("Shuffle LetterGroups") {
gameData.shuffleLetterGroups()
}//button

Spacer()
}//Hstack
Text("Should be \(gameData.buttonData.count) buttons")
ForEach(gameData.buttonData, id: \.self.id) { dataSet in
LetterGroupButton(model: dataSet)

}//loop
.background(.clear)

}//Vstack
}//ZStack
.toolbar {

ToolbarItem(placement: .navigationBarTrailing) {
Button("Help") {
//show help for playing through puzzles
}//help button
}//ToolbarItem
}//toolbar
.navigationTitle(gameData.puzzle.title)

.accessibilityAction(.magicTap) {
var stringToSay = "Current spelling: \(gameData.currentSpelling)"

if gameData.currentSpelling.isEmpty {
stringToSay = "Current spelling is empty"
}//conditional
let utterance = AVSpeechUtterance(string: stringToSay)
utterance.prefersAssistiveTechnologySettings = true

//Routes this speech to the system, which automatically  uses audio ducking and things like that.
speech.usesApplicationAudioSession = false
speech.speak(utterance)
}//magicTap
.environmentObject(allSettings)
.environmentObject(gameData)
.onAppear() {
gameData.initializeHardCodedData()
print("From ActivePuzzleView onAppear(): GameData initialized with puzzle \(gameData.puzzle.title)")
print("From ActivePuzzleView onAppear(), puzzle has \(gameData.puzzle.disabledLetterGroupData!.count) disabled groups.")
}//onAppear
.onDisappear() {
allSheetViewBooleans.showingActivePuzzleView = false
DocumentDirectoryProvider().savePuzzleToDocumentDirectory(for: gameData.puzzle)
}//onDisappear
.onChange(of: gameData.currentSpelling) { newValue in
gameData.checkSpellingAndInformCurrentPuzzle(newValue: newValue)
//The CheckSpellingInCurrentPuzzle() function will also set the puzzle to finished upon completion, so we just check if it's true
if gameData.puzzle.finished {
allSheetViewBooleans.showingNextPuzzlePromptView = true
}//conditional
}//onChange
.sheet(isPresented: $allSheetViewBooleans.showingNextPuzzlePromptView) {
NextPuzzlePromptView()
.environmentObject(allSheetViewBooleans)
.environmentObject(gameData)
}//sheet
}//body
}//struct

struct ActivePuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ProtoActivePuzzleView Preview")
    }
}
