import Foundation

//This class contains the values that are passed to sheet modifiers as bindings. Storing them at a centralized location lets me control how views are shown and dismissed from anywhere, like when the user makes choices in the NextPuzzlePromptView
class AllSheetViewBooleans: ObservableObject {

@Published var showingPuzzlePacksView = false
@Published var showingActivePuzzleView = false
@Published var showingNextPuzzlePromptView = false {
didSet {
if showingNextPuzzlePromptView == false {
determineWhichViewsToShowAndDismiss()
}//conditional
}//didSet
}//showingNextPuzzlePromptView
//These booleans pertain to buttons that can be pressed in NextPuzzlePrompt view and are used in the determineWhichViewsToShowAndDismiss() method
@Published var userSelectedNextPuzzle = false
@Published var userSelectedPuzzlePacksView = false
@Published var userSelectedMainMenu = false


//methods

//called in property observer for showingNextPuzzlePromptView
func determineWhichViewsToShowAndDismiss() {
//Whatever button is pressed in NextPuzzlePromptView dismisses that view , so we only need to check which of the other booleans was true.
if userSelectedNextPuzzle {
showingNextPuzzlePromptView = false
//** need to show next puzzle
} else if userSelectedPuzzlePacksView {
showingNextPuzzlePromptView = false
} else if userSelectedMainMenu {
showingNextPuzzlePromptView = false
//** need to dismiss Puzzle Packs View
}//conditional
}//determineWhichViewsToShowAn dDismss


}//class
