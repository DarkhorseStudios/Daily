import SwiftUI

//Represents buttons inside the Disclosure Groups in IndividualPuzzlePackViews
struct PuzzleButton: View {

@EnvironmentObject var allSettings: AllSettings
let puzzle: Puzzle
//For showing Sheet with ActivePuzzleView
@State private var buttonPressed = false
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

Button() {
buttonPressed.toggle()
puzzle.setStarted(true)
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
.sheet(isPresented: $buttonPressed) {
ActivePuzzleView(gameData: GameData(puzzle: puzzle), showing: $buttonPressed)
}//sheet
}//body
}//struct

struct PuzzleButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("PuzzleButton Preview")
    }
}
