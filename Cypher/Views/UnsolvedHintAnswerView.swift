import SwiftUI

struct UnsolvedHintAnswerView: View {
@EnvironmentObject private  var allSettings: AllSettings
let pair: HintAnswerPair

    var body: some View {
        HStack {
Text(pair.hint)
.foregroundColor(allSettings.colorScheme.secondaryFontColor)
.padding(.trailing)
Image(systemName: "\(pair.answer.count).circle")
.accessibilityRemoveTraits(.isImage)
.accessibilityLabel("\(pair.answer.count) letters")
.foregroundColor(allSettings.colorScheme.secondaryBackgroundColor)

}//HStack
.accessibilityElement(children: .combine)
    }//body
}//struct

struct UnsolvedHintAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Placeholder for unsolvedAnswerView preview")
    }
}
