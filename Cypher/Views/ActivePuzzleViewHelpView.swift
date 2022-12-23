import SwiftUI

//This is displayed as a sheet when the 'help' button is selected in the navigation bar of ActivePuzzleView
struct ActivePuzzleHelpView: View {

@EnvironmentObject var allSettings: AllSettings

var body: some View {
NavigationStack {
ZStack {

Rectangle()
.fill(allSettings.colorScheme.primaryBackgroundColor)
.ignoresSafeArea()
RadialGradient(colors: [.gray, .clear], center: .center, startRadius: 50, endRadius: 200)
.opacity(50.0)

Form {

HStack {

Spacer()
Text("How to Play")
.font(.title)
.accessibilityHeading(.h1)
Spacer()

}//HStack

//We contain each section in a group so we can apply modifiers to each without repeating code
Group {
Section {

Text("\t Zanagrams is an anagram word-puzzle game, meaning that the answers to the hints you'll find on-screen are presented as scrambled groups of letters.\n\n\t Each puzzle consists of six hints, and six associated answers. When a hint is unsolved, you'll notice a number displayed next to the hint. That number tells you how many letters are in the answer to that hint. Once you've solved that hint, the hint will change to also show the answer.")
Text("\t Below the hints is an area that displays your current spelling. To add to your current spelling, select any of the buttons at the bottom of the screen that display groups of letters. When you press one of those buttons, the letter group they represent will automatically be added to your current spelling, and the button will be disabled because each letter group is only needed once to solve the puzzle. \n\n\t As you add more letter groups to your current spelling, the game will inform you if you've solved any of the hints. In the event that this happens, the buttons that were used to spell that word will become permanently disabled, as you won't need them again. \n\n\t On the other hand, if you reach a point where you'd like to clear your current spelling and start fresh, you can select the 'Clear Current Spelling' button, located just below the current spelling field.  When you press this button, any of the buttons that were applied to your current spelling will become usable once again.")
Text("\t Once you've solved all six of the hints in a puzzle, you'll be notified, then directed to another screen where you can share your score with your friends or make a choice as to what you'd like to do next")
Text("Please note: \n\n\t To maintain fairness in Zanagrams, you'll only be able to earn one score for each puzzle, even though each puzzle can be randomized and replayed as many times as you'd like. This is because each player is shown the exact same puzzle on the first playthrough, so that scores can be accurately compared. \n\n\t When replaying puzzles you've already completed, the hints will remain the same, but the words will be split-up into completely different groups of letters each time you play. Since the hints remain the same, I recommend you wait some time before replaying a puzzle so you don't rememver the hints.")
}//Section containing How To Play section

HStack {

Spacer()
Text("Feedback and Bug Reporting")
.font(.title)
.accessibilityHeading(.h1)
Spacer()

}//HStack

Section {
Text("\t I'm a completely-blind developer, and Zanagrams is completely-accessible to the blind and visually-impaired. With that said, I can't see what I've created, so if you find visual bugs, please be as descriptive as-possible when providing me with information about the situation you're referencing.")
Text("\t For example, please include what device you are using, which version of iOS it is running-on, and which version of the app you are using. In addition, please provide context as to what you were doing in Zanagrams, including what puzzle you were working on, if applicable. Lastly, please provide contact information so that I can work with you to fix the issue.")
}//Section for reporting bugs
}//Group
.padding(.vertical)
.font(.body)
.lineLimit(nil)
}//Form
}//Zstack
.navigationTitle("Help")
}//NavStack
}//body
}//struct

struct ActivePuzzleViewHelpView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ActivePuzzleHelpView preview")
    }
}
