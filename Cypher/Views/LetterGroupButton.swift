import SwiftUI
import AVFoundation

struct LetterGroupButton: View {

@EnvironmentObject var allSettings:AllSettings
@EnvironmentObject var gameData: GameData
private var speech = AVSpeechSynthesizer()
@State private var model: LetterGroupButtonData

//Have to use an initializer because of the access level of model
init(model: LetterGroupButtonData) {
self.model = model
}//init

var body: some View {

Button(model.name.uppercased()) {
if model.shouldBeHidden == false {
gameData.appendCurrentSpelling(with: model.name)
gameData.appendButtonDataAppliedToCurrentSpelling(with: model)
gameData.puzzle.incrementTotalButtonsPressed()
withAnimation {
//also sets opacity and rotationAmount
model.setShouldBeHidden(true)
}//WithAnimation
}//conditional checking model.shouldBeHidden
}//button
.clipShape(RoundedRectangle(cornerRadius: 5.0))
.foregroundColor(allSettings.colorScheme.secondaryFontColor)
.opacity(model.appearanceData.opacity)
.accessibilityLabel(model.appearanceData.accessibilityLabel)
.speechSpellsOutCharacters(model.appearanceData.accessibilityLabelShouldBeReadAsCharacters)
.rotation3DEffect(.degrees(model.appearanceData.rotationAmount), axis: (x: 1, y: 0, z: 0))
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
.onTapGesture(count: 3, perform: {
if UIAccessibility.isVoiceOverRunning {
for pair in gameData.puzzle.hintAnswerPairs {
if !pair.solved {
let utterance = AVSpeechUtterance(string: pair.hint)
utterance.prefersAssistiveTechnologySettings = true

//Routes this speech to the system, which automatically  uses audio ducking and things like that.
speech.usesApplicationAudioSession = false
speech.speak(utterance)
}//nested loop
}//loop
}//conditional checking if voiceover is running

})//triple tap

}//body
}//struct

struct LetterGroupButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("LetterGroupButtonPreview")
    }
}
