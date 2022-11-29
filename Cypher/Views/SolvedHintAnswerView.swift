import SwiftUI

struct SolvedHintAnswerView: View {

@EnvironmentObject private  var allSettings: AllSettings
let pair: HintAnswerPair
let compressedAnswer: String
init(pair: HintAnswerPair) {
self.pair = pair
self.compressedAnswer = AnswerParser().compressLetterGroupsIntoAnswer(for: pair.answer).capitalized
}//init
var body: some View {

HStack {

Spacer()

VStack {

Text("Solved: \(pair.hint)")
.accessibilityLabel("Solved: \(pair.hint): \(compressedAnswer)")

.opacity(90.0)
Text(compressedAnswer)
.accessibilityHidden(true)
.font(.caption)
}//VStack
.foregroundColor(allSettings.colorScheme.secondaryFontColor )

Spacer()
}//VStack
.foregroundColor(allSettings.colorScheme.secondaryFontColor)

    }//body
}//struct

struct SolvedHintAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Placeholder for SolvedAnswerView preview")
    }
}
