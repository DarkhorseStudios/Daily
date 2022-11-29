import SwiftUI

struct PuzzlePacksView: View {

@EnvironmentObject private var allSettings: AllSettings
@EnvironmentObject var allSheetViewBooleans: AllSheetViewBooleans
@EnvironmentObject var allPuzzlePacks: AllPuzzlePacks
let directoryProvider = BundleDirectoryProvider()
//for testing
let documentDirectory = DocumentDirectoryProvider()

    var body: some View {
        
        ZStack {
        LinearGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()
ScrollView {

//PuzzleButton(puzzle: DocumentDirectoryProvider().tryLoadingPuzzleFromDocumentDirectory(using: "TestPuzzle.json"))
LazyVStack {
//For testing nextPuzzleView
Section {
//NavigationLink("Open test puzzle") {
//ActivePuzzleView
//}//Navlink
}//section
Button("Reset all puzzles to unstarted") {
for puzzlePack in allPuzzlePacks.puzzlePacks {
for puzzle in puzzlePack.puzzles {
let freshPuzzle: Puzzle = Bundle.main.decode(fromFileName: puzzle.fileName!)
documentDirectory.savePuzzleToDocumentDirectory(for: freshPuzzle)
}//nested loop
}//loop
}//button

ForEach(allPuzzlePacks.puzzlePacks) {
IndividualPuzzlePackView(puzzlePackTitle: $0.title, puzzlesInPack: $0.puzzles)
.padding()
}//loop
}//LazyVstack
}//ScrollView
.environmentObject(allSettings)
.environmentObject(allPuzzlePacks)
}//ZStack
.environmentObject(allSettings)
.foregroundColor(allSettings.colorScheme.secondaryFontColor)
.onDisappear() {
//allSheetViewBooleans.showingPuzzlePacksView = false
}//onDisappear
.toolbar {
ToolbarItem(placement: .navigationBarTrailing) {
Button("Help") {
//insert sheet here
}//button
}//ToolbarItem
}//toolbar
.navigationTitle("Puzzle Packs")
}//body
}//struct

struct PuzzlePacksView_Previews: PreviewProvider {
    static var previews: some View {
        Text("PuzzlePacksView Preview")
    }
}
