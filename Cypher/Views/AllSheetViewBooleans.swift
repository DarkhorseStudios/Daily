import Foundation

//This class contains the values that are passed to sheet modifiers as bindings. Storing them at a centralized location lets me control how views are shown and dismissed from anywhere, like when the user makes choices in the NextPuzzlePromptView
class AllSheetViewBooleans: ObservableObject {

@Published var showingPuzzlePacksView = false
@Published var showingActivePuzzleView = false
@Published var showingNextPuzzlePromptView = false

//methods

//Each of these are called by buttons in NextPuzzzlePromptView
func userSelectedPuzzlePacks() {
showingNextPuzzlePromptView = false
showingActivePuzzleView = false
}//userSElectedPuzzlePacks

func userSelectedMainMenu() {
showingNextPuzzlePromptView = false
showingActivePuzzleView = false
showingPuzzlePacksView = false
}//userSelectedMainMenu
}//class
