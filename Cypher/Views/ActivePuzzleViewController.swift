import Foundation

//Used in PuzzlePacks as a stored property. Then, each PuzzleButton calls the drawActivePuzzleView() action to add an ActivePuzzleViewToTheStack
class ActivePuzzleViewController: ObservableObject {
@Published private(set) var activePuzzleView = ActivePuzzleView(gameData: GameData(puzzle: Puzzle(fromFileWithName: "TestPuzzle.json")))
//func drawActivePuzzleView(puzzle: Puzzle, withHardCodedData: Bool) -> ActivePuzzleView {
//}//drawActivePuzzleView
}//class
