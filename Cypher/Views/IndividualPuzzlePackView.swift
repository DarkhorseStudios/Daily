import SwiftUI

//Represents the expanding/collapsing view for puzzle packs in PuzzlePacksView
struct IndividualPuzzlePackView: View {

@EnvironmentObject var allSettings: AllSettings
let puzzlePackTitle: String
@State private(set) var puzzlesInPack: [Puzzle] {
didSet {
print("IndividualPuzzlePackView passed the following puzzles: \(puzzlesInPack)")
}//didSet
}//puzzlesInPack

var body: some View {

DisclosureGroup(puzzlePackTitle) {
ForEach(puzzlesInPack, id: \.self.title) {
PuzzleButton(puzzle: $0)
}//loop
}//Disclosure Group
.environmentObject(allSettings)
.background(.ultraThinMaterial)
.foregroundColor(allSettings.colorScheme.primaryFontColor)
.border(.thickMaterial)

}//body
}//struct

struct IndividualPuzzlePackView_Previews: PreviewProvider {
    static var previews: some View {
        Text("IndividualPuzzlePackView Preview")
    }
}
