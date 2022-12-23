import SwiftUI

struct PuzzlePacksHelpView: View {

@ObservedObject var allSettings: AllSettings

var body: some View {

NavigationStack {
ZStack {

Rectangle()
.fill(allSettings.colorScheme.primaryBackgroundColor)
.ignoresSafeArea()
RadialGradient(colors: [.gray, .clear], center: .center, startRadius: 50, endRadius: 200)
.opacity(50.0)

Form {

Section {
HStack {

Spacer()
Text("Navigating the menu")
.font(.title)
Spacer()
}//HStack

Text("\t This screen displays all of your puzzle packs. Each puzzle pack contains 10 puzzles, each of which contain 6 anagrams, totaling 60 scrambled word-puzzles per pack. \n\n When this screen first appears, you'll be presented with rows of expandable buttons that represent each puzzle pack. To view the puzzles in a given pack, navigate to its row on this screen, and select the pack you're interested in. This will expand that button and present information on each of the puzzles in that pack. All you have to do at that point is select the button for whichever puzzle you'd like to play, and you're all set!")
.font(.body)
.lineLimit(nil)
}//section

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

}//Form
}//ZStack
.navigationTitle("Help")
}//NavStack
}//body
}//struct

struct PuzzlePacksHelpView_Previews: PreviewProvider {
    static var previews: some View {
        Text("PuzzlePacksHelpViewPreview")
    }
}
