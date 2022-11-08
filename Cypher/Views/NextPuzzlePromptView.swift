import SwiftUI

//This view is for when the player has successfully completed a puzzle
struct NextPuzzlePromptView: View {
//Some array to store different congats messages
@EnvironmentObject var allSettings: AllSettings

    var body: some View {
        NavigationView {
ZStack {
        LinearGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()

        VStack {
        Section {
Button("Next Puzzle") {
//Open Next Puzzle
}//Button
Button("Puzzlepacks") {
//Back to the list of all puzzles
}//Button
Button("Main Menu") {
//ContentView()
}//button
}//Section
}//VStack
}//ZStack
}//NavView
.navigationTitle("Placeholder")
    }//body
}//struct

struct NextPuzzlePromptView_Previews: PreviewProvider {
    static var previews: some View {
        NextPuzzlePromptView()
    }
}
