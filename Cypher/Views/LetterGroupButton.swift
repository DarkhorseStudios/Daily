import SwiftUI
import AVFoundation

struct LetterGroupButton: View {

@EnvironmentObject var allSettings:AllSettings
@EnvironmentObject var gameData: GameData
@State private var model: LetterGroupButtonData

//Have to use an initializer because of the access level of model
init(model: LetterGroupButtonData) {
self.model = model
}//init

var body: some View {

Button(model.name.uppercased()) {
gameData.appendCurrentSpelling(with: model.name)
gameData.appendButtonDataAppliedToCurrentSpelling(with: model)
model.setShouldBeHidden(true)
}//button
.disabled(model.shouldBeHidden)
.accessibilityLabel(model.name.lowercased())
.speechSpellsOutCharacters(true)
.accessibilityAction(.magicTap) {

let speech = AVSpeechSynthesizer()
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
}//body
}//struct

struct LetterGroupButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("LetterGroupButtonPreview")
    }
}
