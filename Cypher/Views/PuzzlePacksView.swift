import SwiftUI

struct PuzzlePacksView: View {

@EnvironmentObject private var allSettings: AllSettings
@EnvironmentObject var allPuzzlePacks: AllPuzzlePacks
//passed-in from ContentView from the sheet modifier for PuzzlePacksView
@Binding var showing: Bool
let directoryProvider = BundleDirectoryProvider()

    var body: some View {
NavigationView {
        ZStack {
        LinearGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()
ScrollView {
LazyVStack {

ForEach(allPuzzlePacks.puzzlePacks) {
IndividualPuzzlePackView(puzzlePackTitle: $0.title, puzzlesInPack: $0.puzzles)
.padding()
}//loop
}//LazyVstack
}//ScrollView
.navigationTitle("Unstarted Puzzles")
.environmentObject(allSettings)
.environmentObject(allPuzzlePacks)
}//ZStack
.environmentObject(allSettings)
.foregroundColor(allSettings.colorScheme.secondaryFontColor)
.toolbar {
ToolbarItem(placement: .navigationBarLeading) {
Button("Back") {
showing = false}//button
}//ToolbarItem

ToolbarItem(placement: .navigationBarTrailing) {
Button("Help") {
//sheet
}//button
}//ToolbarItem
}//toolbar
}//NavView
.font(.title)
}//body
}//struct

struct PuzzlePacksView_Previews: PreviewProvider {
    static var previews: some View {
        Text("PuzzlePacksView Preview")
    }
}
