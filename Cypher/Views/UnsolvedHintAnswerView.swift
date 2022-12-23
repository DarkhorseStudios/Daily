import SwiftUI

struct UnsolvedHintAnswerView: View {
@EnvironmentObject private  var allSettings: AllSettings
let pair: HintAnswerPair
let compressedAnswer: String

init(pair: HintAnswerPair) {
self.pair = pair
self.compressedAnswer = AnswerParser().compressLetterGroupsIntoAnswer(for: pair.answer)
}//init

    var body: some View {
        HStack {
Text(pair.hint)
.lineLimit(nil)
.fixedSize(horizontal: false, vertical: true)
.foregroundColor(allSettings.colorScheme.secondaryFontColor)
.padding(.trailing)
Image(systemName: "\(compressedAnswer.count).circle")
.accessibilityRemoveTraits(.isImage)
.accessibilityLabel("\(compressedAnswer.count) letters")
.foregroundColor(allSettings.colorScheme.secondaryBackgroundColor)

}//HStack
.padding(.vertical)
.accessibilityElement(children: .combine)
    }//body
}//struct

struct UnsolvedHintAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Placeholder for unsolvedAnswerView preview")
    }
}
