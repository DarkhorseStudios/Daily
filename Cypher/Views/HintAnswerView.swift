import SwiftUI

struct HintAnswerView: View {

@EnvironmentObject var allSettings: AllSettings
//This binding is passed whenever an ActivePuzzle is initialized, when the active view is initializing a hintAnswerView.
 @EnvironmentObject  var gameData: GameData

    var body: some View {

//The Background for this view is ultraThin so it pops against the gradient
        VStack {
ForEach(gameData.puzzle.hintAnswerPairs, id: \.self.answer) { pair in
if !pair.solved {
UnsolvedHintAnswerView(pair: pair)
.transition(.asymmetric(insertion: .push(from: .leading), removal: .move(edge: .trailing)))
} else {
SolvedHintAnswerView(pair: pair)
.transition(.asymmetric(insertion: .push(from: .leading), removal: .move(edge: .trailing)))
.onAppear() {
UIAccessibility.post(notification: .announcement, argument: "Solved")
}//onAppear
}//conditional
}//ForEach
}//VStack
.environmentObject(allSettings)
.environmentObject(gameData)
.background(.ultraThinMaterial)
.border(.thinMaterial)
    }//body
    }//struct

struct HintAnswerView_Previews: PreviewProvider {
    static var previews: some View {
Text("This is a placeholder view for the HintAnswerViewPreview")
    }
}
