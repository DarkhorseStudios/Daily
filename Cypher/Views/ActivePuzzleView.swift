import SwiftUI
import AVFoundation

struct ActivePuzzleView: View {

@EnvironmentObject var allSettings: AllSettings
//This is passed-in the PuzzleButton in the .sheet modifier that initializes this view
@ObservedObject var gameData: GameData
@Binding var showing: Bool
@State private var puzzleIsComplete = false
@State private var speech = AVSpeechSynthesizer()

var body: some View {

NavigationView {
ZStack {
LinearGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
VStack {

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

List {
ForEach(gameData.buttonData, id: \.self.id) { dataSet in
LetterGroupButton(model: dataSet)
}//loop
}//list
.background(.clear)
}//Vstack
}//ZStack
.navigationTitle(gameData.puzzle.title)

.toolbar {
//ToolbarItemGroup {
ToolbarItem(placement: .navigationBarLeading) {

Button("Back") {
showing = false
}//Back button
}//ToolbarItem
ToolbarItem(placement: .navigationBarTrailing) {
Button("Help") {
Text("Show help for playing the game")
}//help button
}//ToolbarItem
}//toolbar
}//NavView
.accessibilityAction(.magicTap) {
var stringToSay = "Current spelling: \(gameData.currentSpelling)"

if gameData.currentSpelling.isEmpty {
stringToSay = "Current spelling is empty"
}//conditional
var utterance = AVSpeechUtterance(string: stringToSay)
utterance.prefersAssistiveTechnologySettings = true

//Routes this speech to the system, which automatically  uses audio ducking and things like that.
speech.usesApplicationAudioSession = false
speech.speak(utterance)
}//magicTap
.environmentObject(allSettings)
.environmentObject(gameData)
.onAppear() {
gameData.initializeData()
}//onAppear
//.onChange(of: gameData.currentSpelling, perform: gameData.checkSpellingAndInformCurrentPuzzle(newValue:))
.onChange(of: gameData.currentSpelling) { newValue in
gameData.checkSpellingAndInformCurrentPuzzle(newValue: newValue)
if gameData.puzzle.finished {
puzzleIsComplete = true
}//conditional
}
/*.onChange(of: gameData.numberOfHintsSolvedInCurrentPuzzle) { newValue in
if gameData.checkIfEntirePuzzleIsComplete(newValue: newValue) {
//trigger congrats and next puzzle prompt
//maybe use a bool to trigger a sheet to be drawn.
puzzleIsComplete = true
}//conditional
}//onChange
.sheet(isPresented: puzzleIsComplete)
NextPuzzlePromptView()
.environmentObject(allSettings)
}//sheet
*/
}//body
}//struct

struct ActivePuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ProtoActivePuzzleView Preview")
    }
}
