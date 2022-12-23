import SwiftUI

//Represents buttons inside the Disclosure Groups in IndividualPuzzlePackViews
struct PuzzleButton: View {

@EnvironmentObject var allSettings: AllSettings
@EnvironmentObject var allSheetViewBooleans: AllSheetViewBooleans
//initialized in init, then passed to ActivePuzzleView in NavLink
@State private var gameData: GameData
//@State private var puzzle: Puzzle
//used for showing alert if they player has completed the hardcoded version of the puzzle.
@State private var showingAlert = false
@State private var status: String

init(puzzle: Puzzle){

self.gameData = GameData(puzzle: puzzle)
var refStatus = "Status Not Set in init() for PuzzleButton"
if !puzzle.started {
refStatus = "Unstarted"
} else if puzzle.started && !puzzle.finished {
refStatus = "in-progress"
} else {
refStatus = "Finished"
}//conditional

self.status = refStatus
//self.puzzle = puzzle

if !puzzle.finished {
gameData.initializeHardCodedData()
} else {
gameData.initializeRandomizedData()
}//conditional
}//init

var body: some View {

NavigationLink() {
ActivePuzzleView(gameData: gameData)
} label: {
Text(gameData.puzzle.title)
.font(.body.bold())
.padding()
Text("Status: \(status)")
.font(.caption)
.opacity(0.80)
.clipShape(RoundedRectangle(cornerRadius: 0.90))
.foregroundColor(allSettings.colorScheme.primaryFontColor)
.background(allSettings.colorScheme.primaryBackgroundColor)
.border(.thinMaterial)
}//nav link
.onAppear() {
determineStatusOfPuzzle()
}//onAppear
.alert("You've already completed the official version of this puzzle, so you'll be restarting it with a randomized version. You can replay this with different iterations as many times as you want, but it won't change your score.", isPresented: $showingAlert) {}
}//body

//methods
//Used in onAppear() for this view, in the button's action, and in the property observer for buttonPressed to make sure the view is redrawn when the number of completed hints is changed
func determineStatusOfPuzzle() {

let puzzle = gameData.puzzle
print("PuzzleButton.determineStatus() thinks \(puzzle.title) started value is \(puzzle.started)")
var totalSolved = 0
if puzzle.started && !puzzle.finished {
for pair in puzzle.hintAnswerPairs {
if pair.solved {
totalSolved += 1
}//conditional
}//loop

status = "Started: \(totalSolved)/\(puzzle.hintAnswerPairs.count)"

} else if puzzle.finished {
status = "Completed"
} else {
status = "Unstarted"
}//conditional to set status
}//determineStatusOfPuzzle

}//struct

struct PuzzleButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("PuzzleButton Preview")
    }
}
