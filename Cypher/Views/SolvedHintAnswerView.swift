import SwiftUI

struct SolvedHintAnswerView: View {

@EnvironmentObject private  var allSettings: AllSettings
let pair: HintAnswerPair

    var body: some View {
HStack {

Spacer()

VStack {

Text("Solved: \(pair.hint)")
.accessibilityLabel("Solved: \(pair.hint): \(pair.answer)")
.opacity(90.0)
Text(pair.answer)
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
