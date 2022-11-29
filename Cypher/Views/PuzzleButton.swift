import SwiftUI

//Represents buttons inside the Disclosure Groups in IndividualPuzzlePackViews
struct PuzzleButton: View {

@EnvironmentObject var allSettings: AllSettings
@EnvironmentObject var allSheetViewBooleans: AllSheetViewBooleans
@ObservedObject var puzzle: Puzzle {
didSet {
print("puzzle object in PuzzleButton just set to \(puzzle.title) in property observer")
}//didset
}//puzzle
@State private var status: String

init(puzzle: Puzzle) {
self.puzzle = puzzle
var refStatus = "Status Not Set in init() for PuzzleButton"
if !puzzle.started {
refStatus = "Unstarted"
} else if puzzle.started && !puzzle.finished {
refStatus = "in-progress"
} else {
refStatus = "Finished"
}//conditional

self.status = refStatus
}//init
var body: some View {

NavigationLink() {
ActivePuzzleView(gameData: GameData(puzzle: puzzle))
} label: {
Button() {
print("PuzzleButton just pressed with puzzle \(puzzle.title)")
allSheetViewBooleans.showingActivePuzzleView = true
puzzle.setStarted(true)
determineStatusOfPuzzle()
} label: {
Text(puzzle.title)
.font(.body.bold())
.padding()
Text("Status: \(status)")
.accessibilityLabel(status)
.font(.caption)
.opacity(0.80)
}//button
.clipShape(RoundedRectangle(cornerRadius: 0.90))
.foregroundColor(allSettings.colorScheme.primaryFontColor)
.background(allSettings.colorScheme.primaryBackgroundColor)
.border(.thinMaterial)
}//nav link
.onAppear() {
determineStatusOfPuzzle()
}//onAppear
}//body

//methods
//Used in onAppear() for this view, in the button's action, and in the property observer for buttonPressed to make sure the view is redrawn when the number of completed hints is changed
func determineStatusOfPuzzle() {

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
