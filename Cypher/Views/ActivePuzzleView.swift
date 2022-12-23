import SwiftUI
import AVFoundation

struct ActivePuzzleView: View {

//Used to react to a player's choice in NextPuzzlePromptView to dismiss this. We decide based off of allSheetViewBooleans values
@Environment(\.dismiss) var dismiss
@EnvironmentObject var allSettings: AllSettings
@EnvironmentObject var allSheetViewBooleans: AllSheetViewBooleans
//This is passed-in the PuzzleButton in the .sheet modifier that initializes this view
@ObservedObject var gameData: GameData
//used to show help screen when toolbar button for 'Help' is tapped
@State private var showingHelp = false
private(set) var speech = AVSpeechSynthesizer()

init(gameData: GameData) {
self.gameData = gameData
print("ActivePuzzleView init() thinks it's puzzle's started value is \(gameData.puzzle.started)")
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

GeometryReader { geometry in
Group {
//tries to draw buttons in rows
gameData.getButtonsInRows()
}//Group
.frame(width: geometry.size.width)
}//GeometryReader
}//Vstack
}//ZStack
.toolbar {

ToolbarItem(placement: .navigationBarTrailing) {
Button("Help") {
showingHelp = true
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
print("From ActivePuzzleView onAppear(): GameData initialized with puzzle \(gameData.puzzle.title)")
print("PuzzleButton trying to set puzzle to started")
gameData.puzzle.setStarted(true)
print("PuzzleButton finished trying to set puzzle to started")
print("From ActivePuzzleView onAppear(), puzzle has \(gameData.puzzle.disabledLetterGroupData!.count) disabled groups.")
}//onAppear
.onDisappear() {
allSheetViewBooleans.showingActivePuzzleView = false
print("ActivePuzzleView.onDisappear() saving puzzle")
DocumentDirectoryProvider().savePuzzleToDocumentDirectory(for: gameData.puzzle)
print("After ActivePuzzleView saves, \(gameData.puzzle.title), started = \(gameData.puzzle.started), and finished = \(gameData.puzzle.finished) ")
}//onDisappear
.onChange(of: gameData.currentSpelling) { newValue in
gameData.checkSpellingAndInformCurrentPuzzle(newValue: newValue)
//The CheckSpellingInCurrentPuzzle() function will also set the puzzle to finished upon completion, so we just check if it's true
if gameData.puzzle.finished {
allSheetViewBooleans.showingNextPuzzlePromptView = true
}//conditional
}//onChange
//used for dismissing this view via the NextPuzzlePromptView
.onChange(of: allSheetViewBooleans.showingActivePuzzleView) { newValue in
if newValue == false {
dismiss()
}//conditional
}//onchange
.sheet(isPresented: $allSheetViewBooleans.showingNextPuzzlePromptView) {
NextPuzzlePromptView()
.environmentObject(allSheetViewBooleans)
.environmentObject(gameData)
}//sheet
.sheet(isPresented: $showingHelp) {
ActivePuzzleHelpView()
.environmentObject(allSettings)
}//sheet for help
}//body
}//struct

struct ActivePuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ActivePuzzleView Preview")
    }
}
