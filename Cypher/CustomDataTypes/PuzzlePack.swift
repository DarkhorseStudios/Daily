import Foundation

//Takes in initialized PuzzlePackDataAnd Puzzles from class AllPuzzleData.
class PuzzlePack: ObservableObject, Identifiable {

@Published private(set) var title: String
@Published private(set) var puzzles = [Puzzle]()
let id = UUID()

init(puzzlePackData: PuzzlePackData, puzzles: [Puzzle]) {
self.title = puzzlePackData.title
self.puzzles = puzzles
}//init

//methods

func setTitle(_ new: String) {
title = new
}//setTitle
}//class
